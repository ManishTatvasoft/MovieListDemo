//
//  Genre.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import Foundation

struct Genre: Codable {
    let genres: [Genres]?

    enum CodingKeys: String, CodingKey {

        case genres = "genres"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
    }

}

struct Genres: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
