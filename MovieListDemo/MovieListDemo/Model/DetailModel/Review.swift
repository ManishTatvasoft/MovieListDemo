//
//  Review.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import Foundation

struct Review: Codable{
    let id : Int?
    let page : Int?
    let results : [ReviewResults]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([ReviewResults].self, forKey: .results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
    }
}

struct ReviewResults : Codable {
    let author : String?
    let author_details : AuthorDetails?
    let content : String?
    let created_at : String?
    let id : String?
    let updated_at : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case author = "author"
        case author_details = "author_details"
        case content = "content"
        case created_at = "created_at"
        case id = "id"
        case updated_at = "updated_at"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        author_details = try values.decodeIfPresent(AuthorDetails.self, forKey: .author_details)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}

struct AuthorDetails : Codable {
    let name : String?
    let username : String?
    let avatar_path : String?
    let rating : Double?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case username = "username"
        case avatar_path = "avatar_path"
        case rating = "rating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        avatar_path = try values.decodeIfPresent(String.self, forKey: .avatar_path)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
    }

}

