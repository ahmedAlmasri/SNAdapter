//
//  Configurable.swift
//  Pods-SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//

import Foundation

public protocol SNConfigurableSection {
    var count: Int { get }
    var identifier: String {get set}
    var isLastPage: Bool {get set}
    var elements: [SNCellableModel] { get }
    var delegate: SNCellableDelegate? { get }
    func selected(at indexPath: IndexPath)
    func loadMoreData()
}
