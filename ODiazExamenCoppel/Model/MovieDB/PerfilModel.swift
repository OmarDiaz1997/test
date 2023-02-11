//
//  PerfilModel.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 08/02/23.
//

import Foundation

struct PerfilModel: Codable{
    var avatar: Avatar
    var username: String
}

struct Avatar: Codable{
    var tmdb: TMDB
}

struct TMDB: Codable{
    var avatar_path: String
}
