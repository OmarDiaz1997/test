//
//  PeliculaCollectionViewCell.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 30/01/23.
//

import UIKit

class PeliculaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var TituloLabel: UILabel!
    @IBOutlet weak var FechaLabel: UILabel!
    @IBOutlet weak var RankLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
