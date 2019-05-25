//
//  ViewController.swift
//  SNAdapter
//
//  Created by ahmedAlmasri on 05/24/2019.
//  Copyright (c) 2019 ahmedAlmasri. All rights reserved.
//

import UIKit
import SNAdapter

class ViewController: UIViewController {

    @IBOutlet weak var basicTableView: UITableView!
    var basicSection: SNTableViewSection<BasicModel, BasicCell>!
    var basicAdapter: SNTableViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSection()
    }

    private func setupSection() {
        
        basicSection = SNTableViewSection<BasicModel, BasicCell>(items: getDummyData())
        
        basicSection.didSelect = { [weak self] model, indexPath in 
            DispatchQueue.main.async {
                
                let alert = UIAlertController(title: "Did select", message: "Selected Item \(model.title) \n at index \(indexPath.row)", preferredStyle: .alert)
                alert.addAction( UIAlertAction(title: "Ok", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)   
            }
            
        }
        
        basicAdapter = SNTableViewAdapter(sections: [basicSection])
        basicTableView.setAdapter(basicAdapter)
    }

   private func getDummyData() -> [BasicModel] {
   
    return [BasicModel(title: "Sunday"), BasicModel(title: "Monday"), BasicModel(title: "Tuesday"), BasicModel(title: "Wednesday"), BasicModel(title: "Thursday"), BasicModel(title: "Friday"), BasicModel(title: "Saturday")]
    }
}

