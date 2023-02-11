//
//  RequestToken.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 30/01/23.
//

import Foundation

struct RequestToken: Decodable{
    var success: Bool
    var expires_at: String
    var request_token: String
    
    /*enum CodingRequestToken: String, CodingKey{
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }*/
}
