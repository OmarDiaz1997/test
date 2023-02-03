//
//  SessionId.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 30/01/23.
//

import Foundation

struct SessionId: Decodable{
    var success : Bool
    var session_id : String
    
    /*enum CodingCreateSessionWithLogin: String, CodingKey{
        case success
        case sessionId = "session_id"
    }*/
}
