//
//  SeccionesViewController.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 02/02/23.
//

import UIKit

class SeccionesViewController: UIViewController {
     
    @IBOutlet weak var MoviesCollectionVew: UICollectionView!
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            print("Segmento popular")
            GetAllPopularMovies()
        }else if sender.selectedSegmentIndex == 1 {
            print("Segmento TopRated")
            GetAllTopRatedMovies()
        }else if sender.selectedSegmentIndex == 2 {
            print("Segmento dos")
        }else if sender.selectedSegmentIndex == 3 {
            print("Segmento tres")
        }
    }
    
    let apiKey = "77a0b23ec14008bf7ff74a56d3d6f040"
    
    /*Peliculas favoritas*/
    let moviesViewModel = MovieViewModel()
    var moviesModel: ResultMovies? = nil
    var movieModel: Movie? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        GetAllPopularMovies()
        //GetAllTopRatedMovies()

    }
    
    func GetAllPopularMovies(){
        moviesViewModel.GetAllPopular(apiKey: apiKey, token: {requestData, error in
            if let requestData1 = requestData{
                self.moviesModel = requestData1
                self.MoviesCollectionVew.reloadData()
            }
            if let error1 = error{
                print(error1.localizedDescription)
            }
        })
    }
    
    
    func GetAllTopRatedMovies(){
        moviesViewModel.GetTopRated(apiKey: apiKey, token: {requestData, error in
            if let requestData1 = requestData{
                self.moviesModel = requestData1
            }
            if let error1 = error{
                print(error1.localizedDescription)
            }
        })
    }
    
    
    func loadData(){
        
    }
}





extension SeccionesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesModel!.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MoviesCollectionVew.dequeueReusableCell(withReuseIdentifier: "Movie", for: indexPath) as! PeliculaCollectionViewCell
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf:  URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/\(self.moviesModel!.results[indexPath.row].poster_path)")!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.MovieImage.image = image
                    }
                }
            }
        }
                
        
        cell.TituloLabel.text = moviesModel?.results[indexPath.row].original_title
        cell.FechaLabel.text = moviesModel?.results[indexPath.row].release_date
        //cell.RankLabel.text = String(moviesModel?.results[indexPath.row].vote_average)
        cell.DescriptionLabel.text = moviesModel?.results[indexPath.row].overview
        print("La celda se imprimio")
        
        return cell
    }
    
    
}
