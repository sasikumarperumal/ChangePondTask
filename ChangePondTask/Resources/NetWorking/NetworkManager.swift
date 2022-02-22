//
//  NetworkManager.swift
//  Created by Sasikumar Perumal on 19/02/22.
//

import Foundation

struct NetworkError: Error, LocalizedError {
    let errorDescription: String?
    
    init(_ description: String) {
        errorDescription = description
    }
    
    static var invalidURL = NetworkError("Invalid URL")
    static var NoResponseError = NetworkError("No Response from server")
}

enum HTTPMethod: String {
    case GET
}

final class NetworkManager {
    
    var sessionConfiguration: URLSessionConfiguration
    var jsonDecoder: JSONDecoder
    
    init(configuration: URLSessionConfiguration = .default, jsonDecoder: JSONDecoder = JSONDecoder()){
        self.sessionConfiguration = configuration
        self.jsonDecoder = jsonDecoder
    }
    
    
    static let shared = NetworkManager()
    
    var defaultHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json",
    ]
    
    public func get<T: Decodable>(url: String, query: [String: String]? = nil, headers: [String: String] = [:], completion: @escaping (Result<T, Error>)->Void) {
        guard var url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        if let query = query {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            urlComponents.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
            guard let urlWithQuery = urlComponents.url else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            url = urlWithQuery
        }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.GET.rawValue
        defaultHeaders.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        
        let session = URLSession(configuration: sessionConfiguration)
        session.dataTask(with: urlRequest as URLRequest, completionHandler: { [weak self] (data, response, error) in
            guard let self = self else {
                return
            }
            
            let result: Result<T, Error> = self.decodeJsonAndCreateModel(data: data, response: response, error: error)
            DispatchQueue.main.async {
                completion(result)
            }
            
        }).resume()
    }
    
    
    private func serializedRequest<T: Decodable>(method: HTTPMethod, url:String, body: [String: Any], headers: [String: String] = [:], completion: @escaping (Result<T, Error>)->Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        urlRequest.httpMethod = method.rawValue
        defaultHeaders.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        
        print("url\(url)")
        print("body\(body)")
        
        let session = URLSession(configuration: sessionConfiguration)
        session.dataTask(with: urlRequest as URLRequest, completionHandler: { [weak self] (data, response, error) in
            guard let self = self else { return }
            let model: Result<T, Error> = self.decodeJsonAndCreateModel(data: data, response: response, error: error)
            DispatchQueue.main.async {
                completion(model)
            }
        }).resume()
    }
    
    private func decodeJsonAndCreateModel<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<T, Error> {
        if let error = error {
            return .failure(error)
        }
        else {
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkError.NoResponseError)
            }
            
            guard let data = data else {
                return .failure(NetworkError("No Data returned"))
            }
            
            do {
                guard (200..<300) ~= httpResponse.statusCode else {
                    let model = try self.jsonDecoder.decode(ErrorModel.self, from: data)
                    return .failure(NetworkError(model.message))
                }
                
                let model = try self.jsonDecoder.decode(T.self, from: data)
                return .success(model)
            }catch let error {
                //decoding error
                print(error)
                return .failure(NetworkError("Something went wrong"))
            }
        }
    }
    
    
}


//MARK:- Network mananger endpoints extension
extension NetworkManager {
    
    func get<T: Decodable>(port: Int, endpoint: Endpoints, query: [String: String]? = nil, headers: [String: String] = [:], completion: @escaping (Result<T, Error>)->Void) {
        self.get(url: endpoint.fullUrl(port: port), query: query, headers: headers, completion: completion)
    }
    
}



