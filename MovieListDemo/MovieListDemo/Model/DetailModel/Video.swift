//
//  Video.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation

struct Video : Codable {
    let id : Int?
    let results : [VideoResults]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        results = try values.decodeIfPresent([VideoResults].self, forKey: .results)
    }

}


struct VideoResults : Codable {
    let iso_639_1 : String?
    let iso_3166_1 : String?
    let name : String?
    let key : String?
    let site : String?
    let size : Int?
    let type : String?
    let official : Bool?
    let published_at : String?
    let id : String?

    enum CodingKeys: String, CodingKey {

        case iso_639_1 = "iso_639_1"
        case iso_3166_1 = "iso_3166_1"
        case name = "name"
        case key = "key"
        case site = "site"
        case size = "size"
        case type = "type"
        case official = "official"
        case published_at = "published_at"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso_639_1 = try values.decodeIfPresent(String.self, forKey: .iso_639_1)
        iso_3166_1 = try values.decodeIfPresent(String.self, forKey: .iso_3166_1)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        site = try values.decodeIfPresent(String.self, forKey: .site)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        official = try values.decodeIfPresent(Bool.self, forKey: .official)
        published_at = try values.decodeIfPresent(String.self, forKey: .published_at)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}

