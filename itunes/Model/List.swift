//
//  List.swift
//  itunes
//
//  Created by Jose A. Herran on 20/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import Foundation

struct List: Codable {
    var resultCount: Int
    var results: [ListArtist]
    
    static func endpoint() -> String {
        return "https://itunes.apple.com/search?entity=musicArtist&term="
    }
}

struct ListArtist: Codable {
    var artistName: String
    var artistLinkUrl: String
    var artistId: Int
    var primaryGenreName: String?
    var primaryGenreId: Int?
    var discography: [ListRecord]?
}

