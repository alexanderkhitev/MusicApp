//
//  SpringCollectionViewCell.swift
//  MusicApp
//
//  Created by Alexsander  on 3/15/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit

class SpringCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var authorLabel: UILabel! {
        didSet {
            authorLabel.adjustsFontSizeToFitWidth = true
            authorLabel.textAlignment = .Center
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.adjustsFontSizeToFitWidth = true
            titleLabel.textAlignment = .Center
        }
    }
}
