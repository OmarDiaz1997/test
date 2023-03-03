//
//  MovieCollectionViewCell.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 07/02/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImageViewCell: UIImageView!
    @IBOutlet weak var TituloCell: UILabel!
    @IBOutlet weak var FechaCell: UILabel!
    @IBOutlet weak var RanckCell: UILabel!
    @IBOutlet weak var DescripcionCell: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
