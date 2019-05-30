//
//  BasicCollectionController.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/30/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SNAdapter
class BasicCollectionCell: UICollectionViewCell, SNCellable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ object: SNCellableModel?) {
        guard let basicModel = object as? BasicModel else { return }
         self.backgroundColor = UIColor.blue
        titleLabel.text = basicModel.title
    }
}

class BasicCollectionController: UIViewController {
    
    @IBOutlet weak var basicCollectionView: UICollectionView!
    var basicSection: SNCollectionViewSection<BasicModel, BasicCollectionCell>!
    var basicAdapter: SNCollectionViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Basic CollectionView"
        setupSection()
    }
    
    private func setupSection() {
        
        basicSection = SNCollectionViewSection<BasicModel, BasicCollectionCell>(items: getData())
        
        basicAdapter = SNCollectionViewAdapter(sections: [basicSection])
        basicCollectionView.setAdapter(basicAdapter)
    }
    
    
    private func getData() -> [BasicModel] {
        var dummyList = [BasicModel]()
        for i in 1...50 {
            dummyList.append(BasicModel(title: "Item #\(i)"))
        }
        return dummyList
    }
}
