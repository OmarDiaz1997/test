//
//  CollectionViewCell.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 15/02/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImagenCell: UIImageView!
    @IBOutlet weak var TituloCell: UILabel!
    @IBOutlet weak var FechaCell: UILabel!
    @IBOutlet weak var RankCell: UILabel!
    @IBOutlet weak var DetallesCell: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
