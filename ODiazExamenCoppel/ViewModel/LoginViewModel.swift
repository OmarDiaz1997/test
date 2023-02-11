//
//  LoginViewModel.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 01/02/23.
//

import Foundation

class LoginViewModel: ObservableObject{
    /* Inicio de sesion */
    var authorizeRequestToken: AuthorizeRequestToken? = nil
    let request_token: String = "8be679704e8d7dae0becadd4e06e0e2309c0fce5"
    let api_key: String = "77a0b23ec14008bf7ff74a56d3d6f040"
    
    /* Cerrar sesion */
    var deleteSession: DeleteSession? = nil
    
    @Published var authenticated = 0
    let login : LoginModel? = nil
    let result : Result? = nil
    

    
    func Login(username: String, password: String, request_token: String,authorized : @escaping (AuthorizeRequestToken?, Error?) -> Void){
        let decoder = JSONDecoder()
        guard let url = URL(string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(api_key)") else { return }
        let parametros = ["username": username, "password": password, "request_token": request_token]
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
            
            self.authorizeRequestToken = try! decoder.decode(AuthorizeRequestToken.self, from: data)
            authorized(self.authorizeRequestToken, nil)
            print(self.authorizeRequestToken)
            
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
    
    
    
    
    
    
    func LogOut(sessionID: String, authorized : @escaping (DeleteSession?, Error?) -> Void){
        let decoder = JSONDecoder()
        guard let url = URL(string: "https://api.themoviedb.org/3/authentication/session?api_key=\(api_key)") else { return }
        let parametros = ["session_id": sessionID]
        let body = try! JSONSerialization.data(withJSONObject: parametros)
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){data,response,error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else {
                return
            }
            
            self.deleteSession = try! decoder.decode(DeleteSession.self, from: data)
            authorized(self.deleteSession, nil)
            print(self.deleteSession)
            
        }.resume()
    }

    
    
    
}
