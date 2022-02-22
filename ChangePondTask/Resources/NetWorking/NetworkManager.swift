//
//  NetworkManager.swift
//  ChangePondTask
//
//  Created by Sasikumar Perumal on 20/02/22.

import Foundation
import RSLoadingView

// MARK:- API Class

final class NetworkManager {
    
    func getRequestFunctionAndParametersForWeatherAPI(apiName: String , parameters: [String:Any], onCompletion: @escaping (_ success: Bool, _ error: Error?, _ result: [String: Any]?, _ responseData:Data)->()) {
            
        DispatchQueue.main.async {
            RSLoadingView().showOnKeyWindow()
        }
        
            let urlComp = NSURLComponents(string: apiName)!
            
            var items = [URLQueryItem]()
            
            for (key,value) in parameters {
                items.append(URLQueryItem(name: key, value: value as? String))
            }
            
            items = items.filter{!$0.name.isEmpty}
            
            if !items.isEmpty {
                urlComp.queryItems = items
            }
            
            var request = URLRequest(url: urlComp.url!)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"

            request.timeoutInterval = 30.0
            var returnRes:[String:Any] = [:]
            let task = URLSession.shared.dataTask(with: request) { data1, response, error in
                
                DispatchQueue.main.async {
                    RSLoadingView.hideFromKeyWindow()
                }
                
                if let error = error {
                    onCompletion(false, error, nil, Data())
                } else {
                    guard let data = data1 else {
                        onCompletion(false, error, nil, Data())
                        return
                    }
                    DispatchQueue.main.async(execute: { () -> Void in
                        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                            do {
                                returnRes = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                                onCompletion(true, nil, returnRes, data)
                                var theJSONText = String()
                                if (try? JSONSerialization.data(
                                    withJSONObject: [String:Any](),
                                    options: [])) != nil {
                                    theJSONText = String(data: data,
                                                         encoding: .utf8)!
                                }
                            } catch let error as NSError {
                                onCompletion(false, error, nil, data)
                            }
                        } else {
                            onCompletion(false, error, nil, data)
                            
                        }
                    })
                }
            }
            task.resume()
        }
}



