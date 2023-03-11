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
    @IBOutlet weak var successLabel: UILabel!
    
    
    let api_key = "77a0b23ec14008bf7ff74a56d3d6f040"
    
    /*Request Token*/
    let requestViewModel = ResquestTokenViewModel()
    var requestModel: RequestToken? = nil
    
    /* Autorizacion de inicio de sesion */
    let autorizacionViewModel = LoginViewModel()
    var autorizacionModel: AuthorizeRequestToken? = nil
    

    //let login = LoginViewModel()
    
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
        self.successLabel.isHidden = true
    }
    
    
    //MARK: -Crear nuevo request token
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
    
    
    func AuthorizedRequesToken(request: String, userName: String, password: String){
        autorizacionViewModel.Login(username: userName,
                                    password: password,
                                    request_token: String(requestModel!.request_token),
                                    authorized: {requestData, failed, error in
            if let requestData1 = requestData{
                self.autorizacionModel = requestData1
                self.createSessionId(requestToken: String(self.requestModel!.request_token))
                DispatchQueue.main.async {
                    self.UserNameField.text = ""
                    self.PasswordField.text = ""
                    self.successLabel.isHidden = true
                }
                UserDefaults.standard.set(userName, forKey: "userName")
                UserDefaults.standard.synchronize()
            }
            if let failed1 = failed{
                DispatchQueue.main.async {
                    self.successLabel.text = failed1.status_message
                    self.successLabel.isHidden = false
                }
            }
            if let error1 = error{
                print(error1.localizedDescription)
            }
        })
    }
    
    
    
    func createSessionId(requestToken: String){
        sesionIdViewModel.GetSessionId(request_token: requestToken, session: {requestData, error in
            if let requestData1 = requestData{
                self.sessionIdModel = requestData1
                UserDefaults.standard.set(self.sessionIdModel?.session_id,
                                          forKey: "sessionId")
                UserDefaults.standard.synchronize()
                //Segues
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "login", sender: self)
                }
                print("Sesion id creada")
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
            PasswordField.placeholder = "Ingrese su contrasenia"
            return
        }
        
        AuthorizedRequesToken(request: requestModel!.request_token,
                              userName: NombreUsuario,
                              password: Contrasenia)
        
    }
    
}
