//
//  BasicCollectionCell.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/31/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SNAdapter

class BasicCollectionCell: UICollectionViewCell, SNCellable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ object: SNCellableModel?) {
        guard let basicModel = object as? BasicModel else { return }
        self.backgroundColor = UIColor.blue
        titleLabel.text = basicModel.title
    }
}
