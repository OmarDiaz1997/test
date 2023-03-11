//
//  DetallesViewController.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 09/02/23.
//

import UIKit


class DetallesViewController: UIViewController {
    @IBOutlet weak var DetallesImageView: UIImageView!
    @IBOutlet weak var DetallesTitulo: UILabel!
    @IBOutlet weak var DetallesFecha: UILabel!
    @IBOutlet weak var DetallesRank: UILabel!
    @IBOutlet weak var DetallesFavoritesButton: UIButton!
    @IBOutlet weak var DetallesDislikeButton: UIButton!
    @IBOutlet weak var DetallesDescripcion: UITextView!
    @IBOutlet weak var DetallesProduction: UICollectionView!
    
    /* Detalle pelicula */
    let moviesViewModel = MovieViewModel()
    var movieModel: Movie?
    var moviesResult: ResultMovies?
    let apiKey = "77a0b23ec14008bf7ff74a56d3d6f040"
    var idMovie: Int? = nil
    let sessionID = UserDefaults.standard.string(forKey: "sessionId")
    var result : ResultLogin? = nil
    
    /* Detalle TV */
    let tvViewModel = TVViewModel()
    var tvModel: TV?
    var tvsResult: ResultTV?
    var idTV: Int? = nil
    
    let vc = PerfilViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetDetalles()

        self.DetallesProduction.delegate = self
        self.DetallesProduction.dataSource = self
        self.DetallesProduction.register(UINib(nibName: "ProductionCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "Production")
    }
    

    
    func GetDetalles(){
        if idMovie != nil{
            idTV = nil
            moviesViewModel.GetDetalles(apiKey: apiKey, id: idMovie!, token: {requestData, error in
                if let requestData1 = requestData{
                    self.movieModel = requestData1
                    
                    if let url = URL(string: ("https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + (self.movieModel?.poster_path)!))
                    {
                        DispatchQueue.global().async {
                            if let data = try? Data(contentsOf: url)
                            {
                                DispatchQueue.main.async {
                                    self.DetallesImageView.image = UIImage(data: data)
                                    self.DetallesTitulo.text = self.movieModel?.original_title
                                    self.DetallesFecha.text = self.movieModel?.release_date
                                    self.DetallesRank.text = String(self.movieModel!.vote_average!)
                                    self.DetallesDescripcion.text = self.movieModel?.overview
                                }
                            }
                        }
                    }
                    
                }

                
                if let error1 = error{
                    print(error1.localizedDescription)
                }
            })
        }else if idTV != nil {
            idMovie = nil
            tvViewModel.GetDetalles(apiKey: apiKey, id: idTV!, token: {requestData, error in
                if let requestData1 = requestData{
                    self.tvModel = requestData1
                    
                    if let url = URL(string: ("https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + (self.tvModel?.poster_path)!))
                    {
                        DispatchQueue.global().async {
                            if let data = try? Data(contentsOf: url)
                            {
                                DispatchQueue.main.async {
                                    self.DetallesImageView.image = UIImage(data: data)
                                    self.DetallesTitulo.text = self.tvModel?.original_name
                                    self.DetallesFecha.text = self.tvModel?.first_air_date
                                    self.DetallesRank.text = String(self.tvModel!.vote_average)
                                    self.DetallesDescripcion.text = self.tvModel?.overview
                                }
                            }
                        }
                    }
                    
                }
                
                
                if let error1 = error{
                    print(error1.localizedDescription)
                }
            })
        }
    }

    
    @IBAction func FavoritesButtonAction(_ sender: UIButton) {
        moviesViewModel.AddToFavotrite(apiKey: apiKey, idSession: sessionID!, id: idMovie!, addToFavorite: {requestData, error in
            if let requestData1 = requestData{
                self.result = requestData1
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Confirmación", message: "Agregado a favoritos", preferredStyle: .alert)
                    
                    let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                        //self.navigationController?.popViewController(animated: true)
                        //self.dismiss(animated: true, completion: nil)
                        //self.vc.reloadCollectionView()
                    })
                    
                    alert.addAction(Aceptar)
                    self.present(alert,animated: false)
                }
            }
            
            if let error1 = error{
                print(error1.localizedDescription)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Confirmación", message: "No se pudo agregar a favoritos", preferredStyle: .alert)
                    
                    let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                        self.vc.reloadCollectionView()
                    })
                    
                    alert.addAction(Aceptar)
                    self.present(alert,animated: false)
                }
            }
        })
    }
    
    
    @IBAction func DislikeButtonAction(_ sender: UIButton) {
        moviesViewModel.RemoveFavotrite(apiKey: apiKey, idSession: sessionID!, id: idMovie!, removeFavotrite: {requestData, error in
            if let requestData1 = requestData{
                self.result = requestData1
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Confirmación", message: "Eliminado de favoritos", preferredStyle: .alert)
                    
                    let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                        //self.navigationController?.popViewController(animated: true)
                        //self.dismiss(animated: true, completion: nil)
                        //self.vc.reloadCollectionView()
                    })
                    
                    alert.addAction(Aceptar)
                    self.present(alert,animated: false)
                }
            }
            
            if let error1 = error{
                print(error1.localizedDescription)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Confirmación", message: "No se pudo quitar de favoritos", preferredStyle: .alert)
                    
                    let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                        //self.vc.GetAllFavorites()
                    })
                    
                    alert.addAction(Aceptar)
                    self.present(alert,animated: false)
                }
            }
        })
    }
    
}



extension DetallesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel?.production_companies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DetallesProduction.dequeueReusableCell(withReuseIdentifier: "Production", for: indexPath) as! ProductionCollectionViewCell
        
        let production: ProductionCompanies = movieModel!.production_companies![indexPath.row]
        
        if movieModel?.production_companies![indexPath.row].logo_path != nil{
            if let url = URL(string: ("https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + (movieModel?.production_companies![indexPath.row].logo_path)!))
            {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url)
                    {
                        DispatchQueue.main.async {
                            cell.ProductionImage.image = UIImage(data: data)
                            cell.ProductionImage.layer.cornerRadius = 20
                        }
                    }
                }
            }
        }
        else {
            cell.ProductionImage.image = UIImage(named: "notFound")
        }
        
        cell.ProductionTitle.text = production.name!
        cell.layer.cornerRadius = 20
        
        return cell
    }
    

    
}
