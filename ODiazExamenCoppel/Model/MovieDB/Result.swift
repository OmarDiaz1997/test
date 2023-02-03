//
//  Result.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 01/02/23.
//

import Foundation

struct Result: Decodable{
    var success : Bool
    var expiresAt : Date
    var requestToken : String
    var sessionId : String
    
    enum CodingResult: String, CodingKey{
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case sessionId = "session_id"
    }
    
    init(success: Bool, expiresAt: Date, requestToken: String, sessionId: String) {
        self.success = success
        self.expiresAt = expiresAt
        self.requestToken = requestToken
        self.sessionId = sessionId
    }
    
    init(){
        self.success = false
        self.expiresAt = Date()
        self.requestToken = ""
        self.sessionId = ""
    }
}
