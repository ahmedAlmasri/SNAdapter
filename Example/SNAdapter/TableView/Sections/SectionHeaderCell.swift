//
//  SectionHeaderCell.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SNAdapter

class SectionHeaderCell: UITableViewCell, SNCellable {
    func configure(_ object: SNCellableModel?) {
        guard let basicModel = object as? SectionModel else { return }
        self.backgroundColor = UIColor.gray
        self.textLabel?.text = basicModel.title
        
    }
    
    
}
