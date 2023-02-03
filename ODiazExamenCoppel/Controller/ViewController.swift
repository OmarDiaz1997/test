//
//  ViewController.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 30/01/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var UserNameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var LogInButton: UIButton!
    
    
    let api_key = "77a0b23ec14008bf7ff74a56d3d6f040"
    
    /*Request Token*/
    let requestViewModel = ResquestTokenViewModel()
    var requestModel: RequestToken? = nil
    
    
    
    
    //let login = LoginViewModel()

    
    /* Autorizacion de inicio de sesion */
    let autorizacionViewModel = LoginViewModel()
    var autorizacionModel: AuthorizeRequestToken? = nil
    

    
    
    /* ID sesion*/
    let sesionIdViewModel = SessionIdViewModel()
    var sessionIdModel: SessionId? = nil
    
    /*Peliculas favoritas*/
    let favoriteMoviesViewModel = MovieViewModel()
    var favotiteMoviesModel: ResultMovies? = nil
    var movieModel: Movie? = nil
    let id: String = "2f7b6e4e1abd2f1e6913328de46a489f92c70d9f"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CreateNewRequestToken()
        
        
        
        
        
        func CreateNewRequestToken(){
            let newToken = requestViewModel.GetResquestToken(api_key: api_key, token: {requestData, error in
                if let requestData1 = requestData{
                    self.requestModel = requestData1
                }
                if let error1 = error{
                    print(error1.localizedDescription)
                }
            })
        }
        
        

        
        
        
        
        
        func createSessionId(requestToken: SessionId){
            sesionIdViewModel.GetSessionId(request_token: requestToken.session_id, session: {requestData, error in
                if let requestData1 = requestData{
                    self.sessionIdModel = requestData1
                }
                if let error1 = error{
                    print(error1.localizedDescription)
                }
            })
        }
        
        func GetAllFavoritesMovies(){
            favoriteMoviesViewModel.GetAllFavoriteMovies(session: id, token: {requestData, error in
                if let requestData1 = requestData{
                    self.favotiteMoviesModel = requestData1
                }
                if let error1 = error{
                    print(error1.localizedDescription)
                }
            })
        }
        
        /*autorizacionViewModel.Login(username: "omardiaz", password: "Welcome01$$$@", request_token: "8be679704e8d7dae0becadd4e06e0e2309c0fce5", authorized: {requestData, error in
            if let requestData1 = requestData{
                self.autorizacionModel = requestData1
            }
            if let error1 = error{
                print(error1.localizedDescription)
            }
        })*/
        
        
        
        //var login = LoginViewModel()
        
    }
    
    func AuthorizedRequesToken(request: String, userName: String, password: String){
        autorizacionViewModel.Login(username: userName,
                                    password: password,
                                    request_token: request,
                                    authorized: {requestData, error in
            if let requestData1 = requestData{
                self.autorizacionModel = requestData1
                //createSessionId(requestToken: <#T##SessionId#>)
            }
            if let error1 = error{
                print(error1.localizedDescription)
            }
        })
    }
    
    
    
    @IBAction func LogInAction(_ sender: Any) {
        guard let NombreUsuario = UserNameField.text, NombreUsuario != "" else{
            UserNameField.placeholder = "Ingrese un nombre de usuario"
            return
        }
        
        guard let Contrasenia = PasswordField.text, Contrasenia != "" else{
            PasswordField.placeholder = "Ingrese su contraseña"
            return
        }
        
        AuthorizedRequesToken(request: requestModel!.request_token, userName: NombreUsuario, password: Contrasenia)
        
    }
    
}
