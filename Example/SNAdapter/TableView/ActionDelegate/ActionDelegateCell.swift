//
//  ActionDelegateCell.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SNAdapter

protocol ActionDelegateCellDelegate: SNCellableDelegate {
    
    func infoTapped(_ sender: ActionDelegateCell)
}

class ActionDelegateCell: UITableViewCell, SNCellable {
    
    var delegate: SNCellableDelegate?
    weak var actionDelegate: ActionDelegateCellDelegate?
    
    func configure(_ object: SNCellableModel?) {
        guard let basicModel = object as? BasicModel else { return }

        self.textLabel?.text = basicModel.title
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if let delegate = delegate as? ActionDelegateCellDelegate {
            
            self.actionDelegate = delegate
        }
    }
    
    @IBAction func infoTapped(_ sender: UIButton) {
        
        self.actionDelegate?.infoTapped(self)
    }
    
}
