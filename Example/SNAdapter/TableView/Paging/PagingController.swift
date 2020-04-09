//
//  PagingController.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SNAdapter

class PagingController: UIViewController {
    var pagingTableView: UITableView!
    
    var pagingSection: SNTableViewSection<BasicModel>!
    var pagingAdapter: SNTableViewAdapter!
    private var dummyList = [BasicModel]()
    private var pageNumber = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Paging TableView"
        pagingTableView = UITableView(frame: self.view.bounds)
        pagingTableView.register(BasicCell.self, forCellReuseIdentifier: "\(BasicCell.self)")
        self.view.addSubview(pagingTableView)
        setupSection()
    }
    
    private func setupSection() {
        
        pagingSection = SNTableViewSection<BasicModel>(items: getDummyData(), withPaging: true)
        
        pagingSection.didLoadMore = {
            
            print("start Load more data ")
            self.pagingTableView.showLoadMoreView()
            self.loadMoreDummyData()
            
        }
        pagingAdapter = SNTableViewAdapter(sections: [pagingSection])
        pagingTableView.setAdapter(pagingAdapter)
    }
    
    private func getDummyData() -> [BasicModel] {
        
        for i in 1...10 {
            dummyList.append(BasicModel(title: "Item #\(i * pageNumber)"))
        }
        return dummyList
    }
    private func loadMoreDummyData() {
        pageNumber += 1
        for i in 1...10 {
            dummyList.append(BasicModel(title: "Item #\(i * pageNumber)"))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
            self.pagingSection.updateData(self.dummyList)
            self.pagingTableView.reloadData()
            self.pagingTableView.hiddenLoadMoreView()  
        }
     

    }
}

extension UITableView {
    
    func showLoadMoreView() {
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: 44.0)
        self.tableFooterView = spinner
    }
    
    func hiddenLoadMoreView() {
        
        self.tableFooterView?.removeFromSuperview()
        
    }
}

