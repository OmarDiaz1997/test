//
//  TV.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 10/02/23.
//

import Foundation

struct TV: Decodable{
    var backdrop_path: String
    var first_air_date: String
    var genre_ids: [Int]
    var id: Int
    var name: String
    var origin_country: [String]
    var original_language: String
    var original_name: String
    var overview: String
    var popularity: Double
    var poster_path: String
    var vote_average: Double
    var vote_count: Int
}
