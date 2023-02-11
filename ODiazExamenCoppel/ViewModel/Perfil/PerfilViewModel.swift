//
//  PerfilViewModel.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 08/02/23.
//

import Foundation

class PerfilViewModel{
    
    /* Perfil */
    var resultPerfil: PerfilModel? = nil
    
    func GetProfile(apiKey: String, sessionId: String, token : @escaping (PerfilModel?, Error?) -> Void){
        //var peliculas = [Movie?]()
        
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let urlString = "https://api.themoviedb.org/3/account?api_key=\(apiKey)&session_id=\(sessionId)"
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        urlSession.dataTask(with: url!){data, response, error in
            print("Data: \(String(describing: data))")
            
            guard let data = data else{
                return
            }
            
            self.resultPerfil = try! decoder.decode(PerfilModel.self, from: data)
            //peliculas = self.resultPerfil!.results
            token(self.resultPerfil, nil)
            print(self.resultPerfil)
        }.resume()
    }
}
