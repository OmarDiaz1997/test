//
//  ResultLogin.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 14/02/23.
//

import Foundation

struct ResultLogin: Decodable{
    var success: Bool
    var status_code: Int
    var status_message: String
}
