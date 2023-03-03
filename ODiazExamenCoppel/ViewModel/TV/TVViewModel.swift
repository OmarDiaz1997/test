//
//  TVViewModel.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 10/02/23.
//

import Foundation

class TVViewModel{
    var resultsTV: ResultTV? = nil
    var tv: TV? = nil
    
    func GetTVOn(apiKey: String, token : @escaping (ResultTV?, Error?) -> Void){
        var tvs = [TV?]()
        
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let urlString = "https://api.themoviedb.org/3/tv/on_the_air?api_key=\(apiKey)&language=en-US&page=1"
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        urlSession.dataTask(with: url!){data, response, error in
            print("Data: \(String(describing: data))")
            
            guard let data = data else{
                return
            }
            
            self.resultsTV = try! decoder.decode(ResultTV.self, from: data)
            tvs = self.resultsTV!.results
            token(self.resultsTV, nil)
            print(self.resultsTV)
        }.resume()
    }
    
    
    
    func GetTVAiringToday(apiKey: String, token : @escaping (ResultTV?, Error?) -> Void){
        var tvs = [TV?]()
        
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let urlString = "https://api.themoviedb.org/3/tv/airing_today?api_key=\(apiKey)&language=en-US&page=1"
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        urlSession.dataTask(with: url!){data, response, error in
            print("Data: \(String(describing: data))")
            
            guard let data = data else{
                return
            }
            
            self.resultsTV = try! decoder.decode(ResultTV.self, from: data)
            tvs = self.resultsTV!.results
            token(self.resultsTV, nil)
            print(self.resultsTV)
        }.resume()
    }
    
    
    
    func GetDetalles(apiKey: String, id: Int, token : @escaping (TV?, Error?) -> Void){
        //var tvs = [TV?]()
        
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        //let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US"
        let urlString = "https://api.themoviedb.org/3/tv/\(id)?api_key=\(apiKey)&language=en-US"
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        urlSession.dataTask(with: url!){data, response, error in
            print("Data: \(String(describing: data))")
            
            guard let data = data else{
                return
            }
            
            self.tv = try! decoder.decode(TV.self, from: data)
            //tvs = self.tv!.results
            token(self.tv, nil)
            print(self.tv)
        }.resume()
    }
    
    
}
