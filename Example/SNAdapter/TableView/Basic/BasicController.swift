//
//  ViewController.swift
//  SNAdapter
//
//  Created by ahmedAlmasri on 05/24/2019.
//  Copyright (c) 2019 ahmedAlmasri. All rights reserved.
//

import UIKit
import SNAdapter

enum Actions: Int {
    case sectionTableView
    case pagingTableView
    case delegateTableView
    case basicCollectionView
    case headerCollectionView
    case pagingCollectionView
    case delegateCollectionView
}

class BasicController: UIViewController {

    @IBOutlet weak var basicTableView: UITableView!
    
    var basicSection: SNTableViewSection<BasicModel>!
    var basicAdapter: SNTableViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSection()
    }

    private func setupSection() {
        
        basicSection = SNTableViewSection<BasicModel>(items: getData())
        
        basicSection.didSelect = { [weak self] _, indexPath in 
            self?.didSelect(at: indexPath)    
            
        }
        
        basicAdapter = SNTableViewAdapter(sections: [basicSection])
        basicTableView.setAdapter(basicAdapter)
    }
    
    private func didSelect(at indexPath: IndexPath) {
        guard let action = Actions(rawValue: indexPath.row) else { return }
        
        switch action {
      
        case .sectionTableView:
            let sectionController = SectionController()
           self.navigationController?.pushViewController(sectionController, animated: true)
        case .pagingTableView:
            let pagingController = PagingController()
            self.navigationController?.pushViewController(pagingController, animated: true)
        case .delegateTableView:
            let actionDelegateController = storyboard?.instantiateViewController(withIdentifier: "ActionDelegateController")
            self.navigationController?.pushViewController(actionDelegateController!, animated: true)

        case .basicCollectionView:
            let basicCollectionController = storyboard?.instantiateViewController(withIdentifier: "HeaderCollectionController")
            self.navigationController?.pushViewController(basicCollectionController!, animated: true)
        case .headerCollectionView:
            let headerCollectionController = storyboard?.instantiateViewController(withIdentifier: "HeaderCollectionController")
            self.navigationController?.pushViewController(headerCollectionController!, animated: true)
		 default:
            break
        }
    }

   private func getData() -> [BasicModel] {

    return [BasicModel(title: "Sections TableView"), BasicModel(title: "Paging TableView"), BasicModel(title: "Action delegate TableView"), BasicModel(title: "Basic CollectionView"), BasicModel(title: "Header CollectionView"), BasicModel(title: "Paging CollectionView"), BasicModel(title: "Action delegate CollectionView")]
    }
    
 
}

