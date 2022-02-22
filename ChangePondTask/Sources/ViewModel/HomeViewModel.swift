//
//  HomeViewModel.swift
//  ChangePondTask
//
//  Created by Sasikumar Perumal on 20/02/22.
//

import Foundation
import CoreData
import UIKit

// MARK:- Delegate for Update the views
protocol refreshViewsDelegate : AnyObject {
    
    func refreshViews(hitDetailsData:[Hits])
}

class HomeViewModel: NSObject {
    
    private let networkManager = NetworkManager()
    
    var homeListData = [BaseModel]()
    //
    var homeNewsList: [NSManagedObject] = []
    
    var jsonDecoder = JSONDecoder()
    
    var newsFeeds = [Hits]()
    
    weak var delegate : refreshViewsDelegate?
    
    var isDataAvailable = true
    
    // MARK:- List Api Call
    
    func getListApiCall(param:[String:Any]) {
        
        networkManager.getRequestFunctionAndParametersForWeatherAPI(apiName: Endpoints.user_base.rawValue, parameters: param) { success, error, result, responseData in
            if success {
                
                do {
                    let model = try self.jsonDecoder.decode(BaseModel.self, from: responseData)
                    
                    CoreDataManagement.shared.saveResponseToCoreData(data: model.hits ?? [Hits]())
                    self.newsFeeds = CoreDataManagement.shared.fetchDataDetails() ?? [Hits]()
                    
                    if model.hits?.count == 0 {
                        self.isDataAvailable = false
                    }
                    DispatchQueue.main.async {
                        self.delegate?.refreshViews(hitDetailsData: self.newsFeeds)
                    }
                    
                }catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
    // MARK:- Split the data for Updating the views
    func homenData(indexpath:IndexPath,DataValue:[Hits]) -> HomeListCellViewModel {
        
        
        var itemModel : Hits?
        if DataValue.count > 0 {
            itemModel = DataValue[indexpath.item]
        }
        return HomeListCellViewModel(withModel: itemModel)
    }
    
}



