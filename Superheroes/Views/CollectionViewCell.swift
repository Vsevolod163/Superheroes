//
//  CollectionViewCell.swift
//  Superheroes
//
//  Created by Vsevolod Lashin on 19.05.2023.
//

import UIKit
import Kingfisher

final class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 15
        }
    }
    
    func configure(with superhero: Superhero) {
        mainLabel.text = superhero.name
        let imageURL = URL(string: superhero.images.lg)
        
        imageView.kf.setImage(with: imageURL)
    }
}
