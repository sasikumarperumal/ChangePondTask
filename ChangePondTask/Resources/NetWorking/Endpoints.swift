//
//  Endpoints.swift
//  Created by Sasikumar Perumal on 19/02/22.
//

import Foundation

enum Endpoints: String {

    case user_base = "http://180.151.69.138:2232/v1/api/"
    
    case actionType = "milestone/action"

    
    func fullUrl(port: Int) -> String {
        if self == Endpoints.user_base {
            return self.rawValue
        }
        var fullUrl = ""
        if port == 1{
            fullUrl = Endpoints.user_base.rawValue + self.rawValue
        }
        return fullUrl
    }

}



