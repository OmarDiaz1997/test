//
//  MovieViewModel.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 30/01/23.
//

import Foundation

class MovieViewModel{
    let token: String = "77a0b23ec14008bf7ff74a56d3d6f040"
    
    var resultMovies: ResultMovies? = nil
    var movie: Movie? = nil
    
    let request_token: String = "439c929e4dae4a49df9bc6fdf7e1e555c53687e2"
    let api_key: String = "77a0b23ec14008bf7ff74a56d3d6f040"
    
    
    
    /*init(){
        Login(username: "omardiaz", password: "Welcome01$$$@", request_token: request_token)
    }*/
    
    func GetAllFavoriteMovies(sessionId: String,token : @escaping (ResultMovies?, Error?) -> Void){
        var peticiones = [Movie?]()
        
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let urlString = "https://api.themoviedb.org/3/account/{account_id}/favorite/movies?api_key=\(api_key)&session_id=\(sessionId)&language=en-US&sort_by=created_at.asc&page=1"
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        urlSession.dataTask(with: url!){data, response, error in
            print("Data: \(String(describing: data))")
            
            guard let data = data else{
                return
            }
            
            self.resultMovies = try! decoder.decode(ResultMovies.self, from: data)
            peticiones = self.resultMovies!.results
            token(self.resultMovies, nil)
            print(self.resultMovies)
        }.resume()
    }
    
    
    
    
    func GetAllPopular(apiKey: String, token : @escaping (ResultMovies?, Error?) -> Void){
        var peliculas = [Movie?]()
        
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(api_key)&language=en-US&page=1"
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        urlSession.dataTask(with: url!){data, response, error in
            print("Data: \(String(describing: data))")
            
            guard let data = data else{
                return
            }
            
            self.resultMovies = try! decoder.decode(ResultMovies.self, from: data)
            peliculas = self.resultMovies!.results
            token(self.resultMovies, nil)
            print(self.resultMovies)
        }.resume()
    }
    
    
    
    /* TOP RATED */
    func GetTopRated(apiKey: String, token : @escaping (ResultMovies?, Error?) -> Void){
        var peliculas = [Movie?]()
        
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(api_key)&language=en-US&page=1"
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        urlSession.dataTask(with: url!){data, response, error in
            print("Data: \(String(describing: data))")
            
            guard let data = data else{
                return
            }
            
            self.resultMovies = try! decoder.decode(ResultMovies.self, from: data)
            peliculas = self.resultMovies!.results
            token(self.resultMovies, nil)
            print(self.resultMovies)
        }.resume()
    }
    
    
    
    
    /* Detalles de pelicula */
    func GetDetalles(apiKey: String, id: Int, token : @escaping (Movie?, Error?) -> Void){
        //var peliculas = [Movie?]()
        
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US"
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        urlSession.dataTask(with: url!){data, response, error in
            print("Data: \(String(describing: data))")
            
            guard let data = data else{
                return
            }
            
            self.movie = try! decoder.decode(Movie.self, from: data)
            //peliculas = self.resultMovies!.results
            token(self.movie, nil)
            print(self.movie)
        }.resume()
    }
    
    
}















    

extension Data{
    func parseJSON(quitarString palabra: String) -> Data?{
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: palabra, with: "")
        
        guard let data = parseDataString?.data(using: .utf8) else{ return nil}
        return data
    }
}
