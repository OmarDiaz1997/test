//
//  SeccionesViewController.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 02/02/23.
//

import UIKit

class SeccionesViewController: UIViewController {
    var seccion: Int? = nil
     
    @IBOutlet weak var MoviesCollectionVew: UICollectionView!
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            print("Segmento popular")
            seccion = 0
            GetAllPopularMovies()
        }else if sender.selectedSegmentIndex == 1 {
            seccion = 1
            print("Segmento TopRated")
            GetAllTopRatedMovies()
        }else if sender.selectedSegmentIndex == 2 {
            seccion = 2
            print("Segmento TVOn")
            GetAllTVOn()
        }else if sender.selectedSegmentIndex == 3 {
            seccion = 3
            print("Segmento tres")
        }
    }
    
    let apiKey = "77a0b23ec14008bf7ff74a56d3d6f040"
    
    /*Peliculas favoritas*/
    let moviesViewModel = MovieViewModel()
    var moviesModel: ResultMovies?
    var movieModel: [Movie?] = []
    
    /// TV On
    let tvsViewModel = TVViewModel()
    var tvsModel: ResultTV?
    var tvModel: TV?
    
    /* Cerrar sesion */
    var loginViewModel = LoginViewModel()
    var result: DeleteSession?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetAllPopularMovies()
        
        self.MoviesCollectionVew.delegate = self
        self.MoviesCollectionVew.dataSource = self
        self.MoviesCollectionVew.register(UINib(nibName: "PeliculaCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "Movie")

    }
    
    //MARK: - Get All Popular Movies
    func GetAllPopularMovies(){
        moviesViewModel.GetAllPopular(apiKey: apiKey, token: {requestData, error in
            if let requestData1 = requestData{
                self.moviesModel = requestData1
                DispatchQueue.main.async {
                    self.MoviesCollectionVew.reloadData()
                }
            }
            if let error1 = error{
                print(error1.localizedDescription)
            }
        })
    }
    
    
    //MARK: - Get All Top Rate Movies
    func GetAllTopRatedMovies(){
        moviesViewModel.GetTopRated(apiKey: apiKey, token: {requestData, error in
            if let requestData1 = requestData{
                self.moviesModel = requestData1
                DispatchQueue.main.async {
                    self.MoviesCollectionVew.reloadData()
                }
            }
            if let error1 = error{
                print(error1.localizedDescription)
            }
        })
    }
    
    
    //MARK: - Get All TV On
    func GetAllTVOn(){
        tvsViewModel.GetTVOn(apiKey: apiKey, token: {requestData, error in
            if let requestData1 = requestData{
                self.tvsModel = requestData1
                DispatchQueue.main.async {
                    self.MoviesCollectionVew.reloadData()
                }
            }
            if let error1 = error{
                print(error1.localizedDescription)
            }
        })
    }
    
    
    
    @IBAction func MenuButtonAction(_ sender: Any) {
        
        
        let actionSheet = UIAlertController(title: "Seleccione una opción",
                                  message: "¿Qué desea hacer?",
                                  preferredStyle: .actionSheet)
        
        /* Ver perfil mandar a view de perfil */
        actionSheet.addAction(UIAlertAction(title: "Ver perfil",
                                            style: .default, handler: {_ in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "Profile", sender: self)
            }
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cerrar sesión",
                                            style: .destructive, handler: {_ in
            if let value = UserDefaults.standard.string(forKey: "sessionId"){
                
                self.loginViewModel.LogOut(sessionID: value, authorized: {requestData, error in
                    if let requestData1 = requestData{
                        self.result = requestData1
                        UserDefaults.standard.removeObject(forKey: "sessionId")
                        UserDefaults.standard.synchronize()
                        //Segues
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "Delete", sender: self)
                        }
                        print(self.result!.success)
                        print("Sesion id eliminada")
                    }
                    if let error1 = error{
                        print(error1.localizedDescription)
                    }
                })
            }
        }))
        

        actionSheet.addAction(UIAlertAction(title: "Cancelar",
                                            style: .cancel,
                                            handler: nil))
        present(actionSheet, animated: true)
    }
    
    
}





extension SeccionesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesModel?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MoviesCollectionVew.dequeueReusableCell(withReuseIdentifier: "Movie", for: indexPath) as! PeliculaCollectionViewCell
        
        if seccion == 0 || seccion == 1{
            let movie: Movie = moviesModel!.results[indexPath.row]
            
            /*DispatchQueue.global().async {
                if let data = try? Data(contentsOf:  URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/\(self.moviesModel!.results[indexPath.row].poster_path)")!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.MovieImage.image = image
                        }
                    }
                }
            }*/
            
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
            
           
        }else if seccion == 2 || seccion == 3{
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
        }
        
        
        
        return cell
    }
    
    
}
