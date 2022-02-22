//  ChangePondTask
//
//  Created by Sasikumar Perumal on 20/02/22.

import Foundation
import CoreData

// MARK:- API Response Needed Model

struct BaseModel : Codable {
	let hits : [Hits]?
	let nbHits : Int?
	let page : Int?
	let nbPages : Int?
	let hitsPerPage : Int?
	let exhaustiveNbHits : Bool?
	let exhaustiveTypo : Bool?
	let query : String?
	let params : String?
	let processingTimeMS : Int?

	enum CodingKeys: String, CodingKey {

		case hits = "hits"
		case nbHits = "nbHits"
		case page = "page"
		case nbPages = "nbPages"
		case hitsPerPage = "hitsPerPage"
		case exhaustiveNbHits = "exhaustiveNbHits"
		case exhaustiveTypo = "exhaustiveTypo"
		case query = "query"
		case params = "params"
		case processingTimeMS = "processingTimeMS"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		hits = try values.decodeIfPresent([Hits].self, forKey: .hits)
		nbHits = try values.decodeIfPresent(Int.self, forKey: .nbHits)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
		nbPages = try values.decodeIfPresent(Int.self, forKey: .nbPages)
		hitsPerPage = try values.decodeIfPresent(Int.self, forKey: .hitsPerPage)
		exhaustiveNbHits = try values.decodeIfPresent(Bool.self, forKey: .exhaustiveNbHits)
		exhaustiveTypo = try values.decodeIfPresent(Bool.self, forKey: .exhaustiveTypo)
		query = try values.decodeIfPresent(String.self, forKey: .query)
		params = try values.decodeIfPresent(String.self, forKey: .params)
		processingTimeMS = try values.decodeIfPresent(Int.self, forKey: .processingTimeMS)
	}

}


// MARK:- Used for Common Model
struct CoreDataModel : Codable{
    
    let created_at : String?
    let title : String?
    let author : String?
    let points : Int?
    let comment_text : String?
    let url : String?
    let relevancy_score : Int?

    enum CodingKeys: String, CodingKey {

        case created_at = "created_at"
        case title = "title"
        case author = "author"
        case points = "points"
        case comment_text = "comment_text"
        case url = "url"
        case relevancy_score = "relevancy_score"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        points = try values.decodeIfPresent(Int.self, forKey: .points)
        comment_text = try values.decodeIfPresent(String.self, forKey: .comment_text)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        relevancy_score = try values.decodeIfPresent(Int.self, forKey: .relevancy_score)

        
    }

}

