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
    
    private var dummyList =  [BasicModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSection()
    }

    private func setupSection() {
        
        basicSection = SNTableViewSection<BasicModel, BasicCell>(items: getDummyData(), withPaging: true)
        
        basicSection.didSelect = { [weak self] model, indexPath in 
            DispatchQueue.main.async {
                
                let sectionController = SectionController()
                
                self?.navigationController?.pushViewController(sectionController, animated: true)
//                
//                let alert = UIAlertController(title: "Did select", message: "Selected Item \(model.title) \n at index \(indexPath.row)", preferredStyle: .alert)
//                alert.addAction( UIAlertAction(title: "Ok", style: .default, handler: nil))
//                self?.present(alert, animated: true, completion: nil)   
            }
            
            
        }
        
        basicSection.didLoadMore = {
            
            print("start Load more data ")
            self.loadMoreDummyData()
        }
        
        basicAdapter = SNTableViewAdapter(sections: [basicSection])
        basicTableView.setAdapter(basicAdapter)
    }

   private func getDummyData() -> [BasicModel] {
    for i in 1...10 {
        dummyList.append(BasicModel(title: "Item #\(i)"))
    }
    return dummyList
    }
    
    private func loadMoreDummyData() {
        
        for i in 1...10 {
            dummyList.append(BasicModel(title: "Item #\(i)"))
        }
        
        basicSection.updateData(dummyList)
        basicTableView.reloadData()
    }
}

