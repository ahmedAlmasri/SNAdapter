//
//  SectionController.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SNAdapter

class SectionController: UIViewController {
    
    var sectionsTableView: UITableView!
    var sections = [SNTableViewSection<BasicModel>]()
    var sectionAdapter: SNTableViewAdapter!
    
    var dummyDataList = [SectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "Sections TableView"
        sectionsTableView = UITableView(frame: self.view.bounds)
        sectionsTableView.register(BasicCell.self, forCellReuseIdentifier: "\(BasicCell.self)")
              sectionsTableView.register(SectionHeaderCell.self, forCellReuseIdentifier: "\(SectionHeaderCell.self)")
        self.view.addSubview(sectionsTableView)
        
         setupSection()
    }
    
    private func setupSection() {
        for section in  getDummySectionData() {
           
            let section = SNTableViewSection<BasicModel>(items: section.list)
           
            sections.append(section)
        }
    
        let headerConfig = SNTableViewHeaderConfig(cell: SectionHeaderCell.self, heightHeader: 60, model: getDummySectionData())
        
     sectionAdapter = SNTableViewAdapter(sections: sections, tableViewHeaderConfig: headerConfig)
        
        sectionsTableView.setAdapter(sectionAdapter)
    
    }
    
    private func getDummySectionData() -> [SectionModel] {
        
        for i in 0...10 {
            
            dummyDataList.append(SectionModel(title: "section \(i)", list: getDummyData(i)))
        }
        return dummyDataList
    }
    
    
    private func getDummyData(_ section: Int) -> [BasicModel] {
        var dummyList = [BasicModel]()
        for i in 1...10 {
            dummyList.append(BasicModel(title: "Item #\(i) in section \(section)"))
        }
        return dummyList
    }
        
}
