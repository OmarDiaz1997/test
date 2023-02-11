//
//  SessionIdViewModel.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 02/02/23.
//

import Foundation

class SessionIdViewModel: ObservableObject{
    var sessionIdModel: SessionId? = nil
    
    let request_token: String = "439c929e4dae4a49df9bc6fdf7e1e555c53687e2"
    let api_key: String = "77a0b23ec14008bf7ff74a56d3d6f040"
    
    @Published var authenticated = 0
    let login : LoginModel? = nil
    let result : Result? = nil
    
    /*init(){
        Login(username: "omardiaz", password: "Welcome01$$$@", request_token: request_token)
    }*/
    
    func GetSessionId(request_token: String, session : @escaping (SessionId?, Error?) -> Void){
        let decoder = JSONDecoder()
        guard let url = URL(string: "https://api.themoviedb.org/3/authentication/session/new?api_key=\(api_key)") else { return }
        let parametros = ["request_token": request_token]
        let body = try! JSONSerialization.data(withJSONObject: parametros)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){data,response,error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else {
                return
            }
            
            self.sessionIdModel = try! decoder.decode(SessionId.self, from: data)
            session(self.sessionIdModel, nil)
            print(self.sessionIdModel)
            
            /*do{
                let datos = try JSONDecoder().decode(Result.self, from: data)
                if !datos.requestToken.isEmpty {
                    DispatchQueue.main.async {
                        self.authenticated = 1
                    }
                }
            }catch let error as NSError{
                print("Error al hacer la autenticacion", error.localizedDescription)
                DispatchQueue.main.async {
                    self.authenticated = 2
                }
            }*/
            
        }.resume()
    }
}
