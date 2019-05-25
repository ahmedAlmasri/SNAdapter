//
//  PagingController.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class PagingController: UIViewController {
     var pagingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pagingTableView = UITableView(frame: self.view.bounds)
        self.view.addSubview(pagingTableView)
    }
}
