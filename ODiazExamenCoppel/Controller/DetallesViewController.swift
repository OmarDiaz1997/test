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
    @IBOutlet weak var DetallesDescripcion: UITextView!
    
    /* Detalle pelicula */
    
    let moviesViewModel = MovieViewModel()
    var movieModel: Movie?
    var moviesResult: ResultMovies?
    let apiKey = "77a0b23ec14008bf7ff74a56d3d6f040"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetDetalles()

    }
    
    func GetDetalles(){
        moviesViewModel.GetDetalles(apiKey: apiKey, id: 86311, token: {requestData, error in
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
                                //self.DetallesRank.text = String(self.movieModel.vote_average!)
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
    }

    
    @IBAction func FavoritesButtonAction(_ sender: UIButton) {
    }
    

}
