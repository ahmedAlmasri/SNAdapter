//
//  SNTableViewAdapter.swift
//  Pods-SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//

import Foundation
import UIKit

open class SNTableViewHeaderConfig {
    var cell: SNCellable.Type
    var heightHeader: CGFloat
    var model: [SNCellableModel]
    weak var delegate: SNCellableDelegate?
    
    init(cell: SNCellable.Type, heightHeader: CGFloat, model: [SNCellableModel], delegate: SNCellableDelegate? = nil) {
        self.cell = cell
        self.heightHeader = heightHeader
        self.model = model
        self.delegate = delegate
    }
    
}

open class SNTableViewAdapter: NSObject {
    let sections: [SNConfigurableSection]
    var tableViewHeaderConfig: SNTableViewHeaderConfig?
    var cellHeightsDictionary: [IndexPath: CGFloat] = [:]
    
   public init(sections: [SNConfigurableSection], tableViewHeaderConfig: SNTableViewHeaderConfig? = nil ) {
        self.sections = sections
        self.tableViewHeaderConfig = tableViewHeaderConfig
    }
    
}

extension SNTableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        guard var cell = tableView.dequeueReusableCell(withIdentifier: section.identifier) as? SNCellable & UITableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.delegate = section.delegate
        cell.indexPath = indexPath
        cell.configure(section.elements[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        section.selected(at: indexPath)
    }
    
    // Header Configration
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let config = tableViewHeaderConfig {
            
            guard var cell  = tableView.dequeueReusableCell(withIdentifier: "\(config.cell.self)") as? SNCellable & UITableViewCell else {
                return nil
            }
            cell.delegate = config.delegate
            cell.section = section
            cell.configure(config.model[section])
            
            return cell
        }
        
        return nil
    }
    public  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return tableViewHeaderConfig?.heightHeader ?? CGFloat.leastNormalMagnitude
    }
    
    public  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.cellHeightsDictionary[indexPath] = cell.frame.size.height
        
        let section = sections[indexPath.section]
        
        if indexPath.row == section.count - 1 && !section.isLastPage {
            section.loadMoreData()
        }
    }
    
    public  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height =  self.cellHeightsDictionary[indexPath] {
            return height
        }
        
        return UITableView.automaticDimension
    }
}

open class SNTableViewSection<Model: SNCellableModel, Cell>: SNConfigurableSection where Cell: UITableViewCell & SNCellable {
    
   public typealias ModelCellClosure = (Model, IndexPath) -> Void
   public typealias LoadMoreClosure = () -> Void
    
    public var identifier: String
    public var isLastPage: Bool
    private var items: [Model]
    weak public var delegate: SNCellableDelegate?
    public var didSelect: ModelCellClosure?
    public var loadMore: LoadMoreClosure?
    
    public var count: Int {
        return items.count
    }
    
    public var elements: [SNCellableModel] {
        
        return items
    }
    
   public init(items: [Model], delegate: SNCellableDelegate? = nil, isLastPage: Bool = true) {
        
        self.items = items
        self.identifier =  Cell.identifier == nil ? "\(Cell.self)" : Cell.identifier!
        self.delegate = delegate
        self.isLastPage = isLastPage
    }
    
    public func loadMoreData() {
        loadMore?()
    }
    
    public func selected(at indexPath: IndexPath) {
        let model = items[indexPath.row]
        didSelect?(model, indexPath)
    }
    func updateData(_ items: [Model] ) {
        self.items = items
    }
    func setIsLastPage(_ isLastPage: Bool) {
        self.isLastPage = isLastPage
    }
    
}

public extension UITableView {
    func setAdapter(_ adapter: SNTableViewAdapter) {
        dataSource = adapter
        delegate = adapter
        reloadData()
    }
}
