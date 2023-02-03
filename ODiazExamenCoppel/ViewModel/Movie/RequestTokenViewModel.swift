//
//  RequestTokenViewModel.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 30/01/23.
//

import Foundation

class ResquestTokenViewModel{
    
    var requestToken: RequestToken? = nil
    
    func GetResquestToken(api_key: String,token : @escaping (RequestToken?, Error?) -> Void){
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=\(api_key)")
        
        urlSession.dataTask(with: url!){data, response, error in
            print("Data: \(String(describing: data))")
            
            guard let data = data else{
                return
            }
            
            self.requestToken = try! decoder.decode(RequestToken.self, from: data)
            token(self.requestToken, nil)
            print(self.requestToken)
        }.resume()
    }
}
