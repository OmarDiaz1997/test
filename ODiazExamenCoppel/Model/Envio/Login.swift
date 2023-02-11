//
//  Login.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 01/02/23.
//

import Foundation

struct LoginModel: Decodable{
    var username : String
    var password : String
    var request_token : String
    
    enum CodingLogin: String, CodingKey{
        case userName = "username"
        case password
        case requestToken = "request_token"
    }
}
