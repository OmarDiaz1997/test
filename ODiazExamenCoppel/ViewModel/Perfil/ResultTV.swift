//
//  ResultTV.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 10/02/23.
//

import Foundation

struct ResultTV: Decodable{
    var page : Int
    //Propiedad de navegacion
    var results : [TV]
    var total_pages : Int
    var total_results : Int
}
