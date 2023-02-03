//
//  AuthorizeRequestToken.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 30/01/23.
//

import Foundation

struct AuthorizeRequestToken: Decodable{
    var success : Bool
    var expires_at: String
    var request_token: String
    
    /*enum CodingAuthorizeRequestToken: String, CodingKey{
        case success
        case expires_at = "expires_at"
        case request_token = "request_token"
    }*/
}




/*struct AuthorizeRequestToken: Decodable{
    var userName: String
    var password: String
    var requestToken: String
    
    enum CodingAuthorizeRequestToken: String, CodingKey{
        case userName = "username"
        case password
        case requestToken = "request_token"
    }
}
*/
