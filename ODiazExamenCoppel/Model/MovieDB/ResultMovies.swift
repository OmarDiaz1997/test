//
//  FavoriteMovies.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 01/02/23.
//

import Foundation

struct ResultMovies: Decodable{
    var page : Int
    //Propiedad de navegacion
    var results : [Movie]
    var total_pages : Int
    var total_results : Int
    
    /*enum CodingFavoriteMovies: String, CodingKey{
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }*/
}
