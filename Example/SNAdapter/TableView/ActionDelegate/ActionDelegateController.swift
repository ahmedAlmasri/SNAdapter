//
//  ActionDelegateController.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SNAdapter

class ActionDelegateController: UIViewController {
    
    @IBOutlet weak var actionTableView: UITableView!
    
    var actionSection: SNTableViewSection<BasicModel>!
    var actionAdapter: SNTableViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSection()
    }
    
    private func setupSection() {
        
        actionSection = SNTableViewSection<BasicModel>(items: getData(), delegate: self)
        actionAdapter = SNTableViewAdapter(sections: [actionSection])
        actionTableView.setAdapter(actionAdapter)
    }
    
    private func getData() -> [BasicModel] {
        var dummyList = [BasicModel]()
        for i in 1...10 {
            dummyList.append(BasicModel(title: "Action #\(i)"))
        }
        return dummyList
    }
}

extension ActionDelegateController: ActionDelegateCellDelegate {
    func infoTapped(_ sender: ActionDelegateCell) {
        guard let indexPath = actionTableView.indexPath(for: sender) else { return }
        
        let alert = UIAlertController(title: "Did tapped info ", message: "Selected Item at index \(indexPath.row)", preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)         
 
    }
    
    
}
