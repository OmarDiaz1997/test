//
//  CeldaCollectionViewCell.swift
//  ODiazExamenCoppel
//
//  Created by MacbookMBA8 on 07/03/23.
//

import UIKit

class CeldaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImagenCell: UIImageView!
    @IBOutlet weak var TituloCell: UILabel!
    @IBOutlet weak var FechaCell: UILabel!
    @IBOutlet weak var RankCell: UILabel!
    //@IBOutlet weak var DetallesCell1: UITextView!
    @IBOutlet weak var DetallesCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
