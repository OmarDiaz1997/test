//
//  Movie.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 30/01/23.
//

import Foundation

struct Movie: Codable{
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
    
    init(adult: Bool? = nil, backdrop_path: String? = nil, genre_ids: [Int]? = nil, id: Int? = nil, original_language: String? = nil, original_title: String? = nil, overview: String? = nil, popularity: Double? = nil, poster_path: String? = nil, release_date: String? = nil, title: String? = nil, video: Bool? = nil, vote_average: Double? = nil, vote_count: Int? = nil) {
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.genre_ids = genre_ids
        self.id = id
        self.original_language = original_language
        self.original_title = original_title
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.release_date = release_date
        self.title = title
        self.video = video
        self.vote_average = vote_average
        self.vote_count = vote_count
    }
    
    init(){
        adult = false
        backdrop_path = ""
        genre_ids = []
        id = 0
        original_language = ""
        original_title = ""
        overview = ""
        popularity = 0.0
        poster_path = ""
        release_date = ""
        title = ""
        video = false
        vote_average = 0.0
        vote_count = 0
    }
}
