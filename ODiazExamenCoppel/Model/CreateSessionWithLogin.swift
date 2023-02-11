//
//  CreateSessionWithLogin.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 30/01/23.
//

import Foundation

struct CreateSessionWithLogin{
    var success : String
    var expiresAt : String
    var request_token : String
    
    enum CodingCreateSessionWithLogin: String, CodingKey{
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
