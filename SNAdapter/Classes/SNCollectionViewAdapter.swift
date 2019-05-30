//
//  SNCollectionViewAdapter.swift
//  Pods-SNAdapter_Example
//
//  Created by Macbook Pro on 5/30/19.
//

import Foundation
import UIKit

public protocol SNConfigurableCollectionSection: SNConfigurableSection {
    
    //   var cellSize: CGSize { get }
    var withPager: Bool { get set }
}

public struct SNCollectionReusableViewConfig {
    weak var delegate: SNCellableDelegate?
    var cell: SNCellable.Type
    var heightReusableView: CGFloat
    var model: [SNCellableModel?]?
    
   public init(cell: SNCellable.Type, heightReusableView: CGFloat, model: [SNCellableModel?]? = nil, delegate: SNCellableDelegate? = nil) {
        self.delegate = delegate
        self.cell = cell
        self.heightReusableView = heightReusableView
        self.model = model
    }
}

open class SNCollectionViewAdapter: NSObject {
    let sections: [SNConfigurableCollectionSection]
    var collectionViewHeaderConfig: SNCollectionReusableViewConfig?
    
   public init(sections: [SNConfigurableCollectionSection], collectionViewHeaderConfig: SNCollectionReusableViewConfig? = nil ) {
        self.sections = sections
        self.collectionViewHeaderConfig = collectionViewHeaderConfig
    }
    
}

extension SNCollectionViewAdapter: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
   public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
   public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: section.identifier, for: indexPath) as? SNCellable & UICollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = section.delegate
        cell.indexPath = indexPath
      //  cell.itemCount = section.elements.count
        cell.configure(section.elements[indexPath.row])
        
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = sections[indexPath.section]
        section.selected(at: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        if indexPath.row == section.count - 1 && !section.isLastPage {
            
            section.loadMoreData()
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let section = sections[section]
        
        if section.withPager {
            
            return CGSize(width: collectionView.frame.width, height: 50)
        }
        
        if let config = collectionViewHeaderConfig {
            
            return CGSize(width: collectionView.frame.width, height: config.heightReusableView)
        }
        
        return CGSize.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section]
        
        if section.withPager {
            
            if kind == UICollectionView.elementKindSectionFooter {
                
                return collectionView.addFooterSpinner(indexPath, isLatPage: section.isLastPage)
            }
        }
        
        if let config = collectionViewHeaderConfig {
            
            if kind != UICollectionView.elementKindSectionHeader && kind != UICollectionView.elementKindSectionFooter {
                return UICollectionReusableView()
            }
            guard var cell  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(config.cell.self)", for: indexPath) as? SNCellable &
                UICollectionReusableView else { return  UICollectionReusableView() }
            
            cell.delegate = config.delegate
            cell.didMoveToWindow()
            if let models = config.model {
                if let model = models[indexPath.row] {
                    cell.configure(model)
                }
            }
            return cell
            
        } else {
            
            return  UICollectionReusableView()
        }
        
    }
}

open class SNCollectionViewSection<Model: SNCellableModel, Cell>: SNConfigurableCollectionSection where Cell: UICollectionViewCell & SNCellable {
    public var withPager: Bool
    
    public var isLastPage: Bool
    
    //  var cellSize: CGSize
    
    weak public var delegate: SNCellableDelegate?
    
    public var elements: [SNCellableModel] {
        
        return items
    }
    
    public var identifier: String
    
    typealias ModelCellClosure = (Model, IndexPath) -> Void
    typealias LoadMoreClosure = () -> Void
    
    private var items: [Model]
    
    var didSelect: ModelCellClosure?
    var loadMore: LoadMoreClosure?
    public var count: Int {
        return items.count
    }
    
   public init(items: [Model], withPager: Bool = false, delegate: SNCellableDelegate? = nil, isLastPage: Bool = false) {
        self.items = items
        self.identifier = "\(Cell.self)"
        self.delegate = delegate
        self.isLastPage = isLastPage
        self.withPager = withPager
        //  self.cellSize = cellSize
    }
    
    public func selected(at indexPath: IndexPath) {
        
        let model = items[indexPath.row]
        didSelect?(model, indexPath)
    }
    
    public func loadMoreData() {
        
        loadMore?()
    }
    
    func updateData(_ items: [Model] ) {
        self.items = items
    }
    func setIsLastPage(_ isLastPage: Bool) {
        self.isLastPage = isLastPage
    }
}

public extension UICollectionView {
    func setAdapter(_ adapter: SNCollectionViewAdapter) {
        dataSource = adapter
        delegate = adapter
        reloadData()
    }
    
    func contentHeight() -> CGFloat {
        
        return self.collectionViewLayout.collectionViewContentSize.height
        
    }
    
    func setFooterSize(_ size: CGSize) {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.footerReferenceSize = size
        }
    }
    // MARK: -
    //FooterSpinner
    func registerFooterSpinner() {
        
        self.register(UICollectionViewCell.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
    }
    
    func addFooterSpinner(_ indexPath: IndexPath, isLatPage: Bool) -> UICollectionReusableView {
        
        let reusableView = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath)
        let pagerSpinner = UIActivityIndicatorView(frame: CGRect(x: reusableView.frame.width/2-5, y: reusableView.frame.height/2-5, width: 10, height: 10))
        pagerSpinner.style = .gray
        pagerSpinner.color = UIColor.black
        reusableView.addSubview(pagerSpinner)
        pagerSpinner.startAnimating()
        
        if isLatPage {
            
           return UICollectionReusableView()
        }
        return reusableView
    }

}
