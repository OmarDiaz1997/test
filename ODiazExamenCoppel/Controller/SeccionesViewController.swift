//
//  SeccionesViewController.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 02/02/23.
//

import UIKit

class SeccionesViewController: UIViewController {
    //var seccion: Int? = nil
    var idMovie: Int? = nil
    var idTV: Int? = nil
     
    @IBOutlet weak var MoviesCollectionVew: UICollectionView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var SegmentSelect : UISegmentedControl!
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if SegmentSelect.selectedSegmentIndex == 0 {
            print("Segmento popular")
            //seccion = 0
            GetAllPopularMovies()
        }else if SegmentSelect.selectedSegmentIndex == 1 {
            //seccion = 1
            print("Segmento TopRated")
            GetAllTopRatedMovies()
        }else if SegmentSelect.selectedSegmentIndex == 2 {
            //seccion = 2
            print("Segmento TVOn")
            GetAllTVOn()
        }else if SegmentSelect.selectedSegmentIndex == 3 {
            //seccion = 3
            print("Segmento tres")
            GetAllAiringToday()
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
        self.navigationItem.setHidesBackButton(true, animated: true)
        GetAllPopularMovies()
        
        self.MoviesCollectionVew.delegate = self
        self.MoviesCollectionVew.dataSource = self
        self.MoviesCollectionVew.register(UINib(nibName: "CeldaCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "Celda")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetAllPopularMovies()
    }
    
    func seccionSegmen(){
        if SegmentSelect.selectedSegmentIndex == 0 {
            GetAllPopularMovies()
        }else if SegmentSelect.selectedSegmentIndex == 1 {
            GetAllTopRatedMovies()
        }else if SegmentSelect.selectedSegmentIndex == 2 {
            GetAllTVOn()
        }else if SegmentSelect.selectedSegmentIndex == 3 {
            GetAllAiringToday()
        }
    }
    
    //MARK: - Get All Popular Movies
    func GetAllPopularMovies(){
        moviesViewModel.GetAllPopular(apiKey: apiKey, token: {requestData, error in
            if let requestData1 = requestData{
                //self.seccion = 0
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
                //self.seccion = 1
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
                //self.seccion = 2
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
    
    
    
    //MARK: - Get All Airing Today
    func GetAllAiringToday(){
        tvsViewModel.GetTVAiringToday(apiKey: apiKey, token: {requestData, error in
            if let requestData1 = requestData{
                //self.seccion = 3
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
        let actionSheet = UIAlertController(title: "Seleccione una opci??n",
                                  message: "??Qu?? desea hacer?",
                                  preferredStyle: .actionSheet)
        
        /* Ver perfil mandar a view de perfil */
        actionSheet.addAction(UIAlertAction(title: "Ver perfil",
                                            style: .default, handler: {_ in
            DispatchQueue.main.async {
                //self.seccion = nil
                self.performSegue(withIdentifier: "Profile", sender: self)
            }
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cerrar sesi??n",
                                            style: .destructive, handler: {_ in
            if let value = UserDefaults.standard.string(forKey: "sessionId"){
                
                self.loginViewModel.LogOut(sessionID: value, authorized: {requestData, error in
                    if let requestData1 = requestData{
                        self.result = requestData1
                        UserDefaults.standard.removeObject(forKey: "sessionId")
                        UserDefaults.standard.synchronize()
                        //Segues
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                            //self.performSegue(withIdentifier: "Delete", sender: self)
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
        let cell = MoviesCollectionVew.dequeueReusableCell(withReuseIdentifier: "Celda", for: indexPath) as! CeldaCollectionViewCell
        
        if SegmentSelect.selectedSegmentIndex == 0 || SegmentSelect.selectedSegmentIndex == 1{
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
                            cell.ImagenCell.image = UIImage(data: data)
                            cell.ImagenCell.layer.cornerRadius = 20
                        }
                    }
                }
            }
            
            
            cell.TituloCell.text = movie.original_title
            cell.FechaCell.text = movie.release_date!
            cell.RankCell.text = String(movie.vote_average!)
            cell.DetallesCell.text = movie.overview!
            cell.layer.cornerRadius = 20
            
            
        }else if SegmentSelect.selectedSegmentIndex == 2 || SegmentSelect.selectedSegmentIndex == 3 {
            let tv: TV = tvsModel!.results[indexPath.row]
            
            if let url = URL(string: ("https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + (tvsModel?.results[indexPath.row].poster_path)!))
            {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url)
                    {
                        DispatchQueue.main.async {
                            cell.ImagenCell.image = UIImage(data: data)
                            cell.ImagenCell.layer.cornerRadius = 20
                        }
                    }
                }
            }
            
            
            cell.TituloCell.text = tv.original_name
            cell.FechaCell.text = tv.first_air_date
            cell.RankCell.text = String(tv.vote_average)
            cell.DetallesCell.text = tv.overview
            cell.layer.cornerRadius = 20
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if SegmentSelect.selectedSegmentIndex == 0 || SegmentSelect.selectedSegmentIndex == 1 {
            self.idMovie = moviesModel?.results[indexPath.row].id
            self.performSegue(withIdentifier: "DetallesSegues", sender: self)
        }else if SegmentSelect.selectedSegmentIndex == 2 || SegmentSelect.selectedSegmentIndex == 3 {
            self.idTV = tvsModel?.results[indexPath.row].id
            self.performSegue(withIdentifier: "DetallesSegues", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetallesSegues"{
            if SegmentSelect.selectedSegmentIndex == 0 || SegmentSelect.selectedSegmentIndex == 1 {
                let id = segue.destination as! DetallesViewController
                id.idMovie = self.idMovie
            }else if SegmentSelect.selectedSegmentIndex == 2 || SegmentSelect.selectedSegmentIndex == 3 {
                let id = segue.destination as! DetallesViewController
                id.idTV = self.idTV
            }
        }
    }
}
