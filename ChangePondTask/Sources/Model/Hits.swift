/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Hits : Codable {
	let created_at : String?
	let title : String?
	let url : String?
	let author : String?
	let points : Int?
	let story_text : String?
	let comment_text : String?
	let num_comments : Int?
	let story_id : String?
	let story_title : String?
	let story_url : String?
	let parent_id : String?
	let created_at_i : Int?
	let relevancy_score : Int?
	let _tags : [String]?
	let objectID : String?
	let _highlightResult : _highlightResult?

	enum CodingKeys: String, CodingKey {

		case created_at = "created_at"
		case title = "title"
		case url = "url"
		case author = "author"
		case points = "points"
		case story_text = "story_text"
		case comment_text = "comment_text"
		case num_comments = "num_comments"
		case story_id = "story_id"
		case story_title = "story_title"
		case story_url = "story_url"
		case parent_id = "parent_id"
		case created_at_i = "created_at_i"
		case relevancy_score = "relevancy_score"
		case _tags = "_tags"
		case objectID = "objectID"
		case _highlightResult = "_highlightResult"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		author = try values.decodeIfPresent(String.self, forKey: .author)
		points = try values.decodeIfPresent(Int.self, forKey: .points)
		story_text = try values.decodeIfPresent(String.self, forKey: .story_text)
		comment_text = try values.decodeIfPresent(String.self, forKey: .comment_text)
		num_comments = try values.decodeIfPresent(Int.self, forKey: .num_comments)
		story_id = try values.decodeIfPresent(String.self, forKey: .story_id)
		story_title = try values.decodeIfPresent(String.self, forKey: .story_title)
		story_url = try values.decodeIfPresent(String.self, forKey: .story_url)
		parent_id = try values.decodeIfPresent(String.self, forKey: .parent_id)
		created_at_i = try values.decodeIfPresent(Int.self, forKey: .created_at_i)
		relevancy_score = try values.decodeIfPresent(Int.self, forKey: .relevancy_score)
		_tags = try values.decodeIfPresent([String].self, forKey: ._tags)
		objectID = try values.decodeIfPresent(String.self, forKey: .objectID)
		_highlightResult = try values.decodeIfPresent(_highlightResult.self, forKey: ._highlightResult)
	}

}