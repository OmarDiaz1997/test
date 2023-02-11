//
//  PerfilViewController.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 08/02/23.
//

import UIKit

class PerfilViewController: UIViewController {
    @IBOutlet weak var PerfilImageView: UIImageView!
    @IBOutlet weak var UserNameTextfield: UILabel!
    @IBOutlet weak var FavoritosCollectionView: UICollectionView!
    
    /*Peliculas favoritas*/
    let moviesViewModel = MovieViewModel()
    var moviesModel: ResultMovies?
    var movieModel: [Movie?] = []
    let apiKey = "77a0b23ec14008bf7ff74a56d3d6f040"
    
    /* Perfil */
    let perfilViewModel = PerfilViewModel()
    var perfilModel: PerfilModel?
    
    
    let sessionID = UserDefaults.standard.string(forKey: "sessionId")

    override func viewDidLoad() {
        super.viewDidLoad()
        GetProfile()
        GetAllFavorites()
        
        self.FavoritosCollectionView.delegate = self
        self.FavoritosCollectionView.dataSource = self
        self.FavoritosCollectionView.register(UINib(nibName: "PeliculaCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "Movie")

    }
    
    func GetProfile(){
        perfilViewModel.GetProfile(apiKey: apiKey, sessionId: sessionID!) { requestProfile, error in
            if let requestProfile1 = requestProfile{
                self.perfilModel = requestProfile1
                
                if let url = URL(string: ("https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + (self.perfilModel?.avatar.tmdb.avatar_path)!))
                {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url)
                        {
                            DispatchQueue.main.async {
                                self.PerfilImageView.image = UIImage(data: data)
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    
                    self.UserNameTextfield.text = self.perfilModel?.username
                }

            }
            if let error1 = error{
                print(error1.localizedDescription)
            }
        }
    }
    
    func GetAllFavorites(){
        self.moviesViewModel.GetAllFavoriteMovies(sessionId: self.sessionID!) { requestData, error in
            if let requestData1 = requestData{
                self.moviesModel = requestData1
                DispatchQueue.main.async {
                    self.FavoritosCollectionView.reloadData()
                }
            }
            if let error1 = error{
                print(error1.localizedDescription)
            }
            
        }
    }
    

}


extension PerfilViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesModel?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = FavoritosCollectionView.dequeueReusableCell(withReuseIdentifier: "Movie", for: indexPath) as! PeliculaCollectionViewCell
        
        let movie: Movie = moviesModel!.results[indexPath.row]
        
        
        if let url = URL(string: ("https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + (moviesModel?.results[indexPath.row].poster_path)!))
        {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url)
                {
                    DispatchQueue.main.async {
                        cell.MovieImage.image = UIImage(data: data)
                        cell.MovieImage.layer.cornerRadius = 20
                    }
                }
            }
        }
        
        cell.TituloLabel.text = movie.original_title!
        cell.FechaLabel.text = movie.release_date!
        cell.RankLabel.text = String(movie.vote_average!)
        cell.DescriptionLabel.text = movie.overview!
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    
}
