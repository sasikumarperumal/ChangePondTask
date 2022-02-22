//
//  HomeListCellViewModel.swift
//  ChangePondTask
//
//  Created by Sasikumar Perumal on 20/02/22.
//

import Foundation

// MARK:- ViewModel for Setting Data

final class HomeListCellViewModel {
    
    var homeListData:Hits?

    init(withModel:Hits?)
      {
          homeListData = withModel
      }
    
    
    // MARK:- Created Date
    public var getCreatedDate: String {
        return convertedDate(DateStr: self.homeListData?.created_at ?? "")
    }

    // MARK:- Title
    public var getTitle: String {
        return self.homeListData?.title ?? ""
    }
    
    // MARK:- Author
    public var getAuthor: String {
        return self.homeListData?.author ?? ""
    }
    
    // MARK:- Points
    public var getPoints: Int {
        return Int(self.homeListData?.points ?? 0)
    }
    
    // MARK:- Score
    public var getRelevencyScore: Int {
        return Int(self.homeListData?.relevancy_score ?? 0)
    }
    
    // MARK:- Date Function for converting ISO to Date
    
    func convertedDate(DateStr:String) -> String {
        let inputDate = DateStr
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: inputDate) ?? Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: date)
    }

}

