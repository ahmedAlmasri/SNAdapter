//
//  BasicCell.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SNAdapter

class BasicCell: UITableViewCell, SNCellable {
    
    func configure(_ object: SNCellableModel?) {
        guard let basicModel = object as? BasicModel else { return }
        
        self.textLabel?.text = basicModel.title
    }
    
    
}
