//
//  HeaderCollectionView.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/31/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SNAdapter

class HeaderCell: UICollectionReusableView, SNCellable {
    func configure(_ object: SNCellableModel?) {
    }
    
}

class HeaderCollectionController: UIViewController {
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    var headerSection: SNCollectionViewSection<BasicModel, BasicCollectionCell>!
    var headerAdapter: SNCollectionViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Header CollectionView"
        setupSection()
    }
    
    private func setupSection() {
        
        headerSection = SNCollectionViewSection<BasicModel, BasicCollectionCell>(items: getData())
        let config = SNCollectionReusableViewConfig(cell: HeaderCell.self, heightReusableView: 60)
        headerAdapter = SNCollectionViewAdapter(sections: [headerSection], collectionReusableViewConfig: config)
        headerCollectionView.setAdapter(headerAdapter)
    }
    
    
    private func getData() -> [BasicModel] {
        var dummyList = [BasicModel]()
        for i in 1...50 {
            dummyList.append(BasicModel(title: "Item #\(i)"))
        }
        return dummyList
    }
}
