//
//  Abstraction.swift
//  Pods-SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//

import Foundation

public protocol SNCellableModel {}

public protocol SNCellableDelegate: class {}

/// used to configure cell data and actoins
public protocol SNCellable {
    func configure(_ object: SNCellableModel?)
    var delegate: SNCellableDelegate? {get set}
    var indexPath: IndexPath? {get set}
    var section: Int? {get set}
    static var identifier: String? {get set}
}

 public extension SNCellable {
    var delegate: SNCellableDelegate? {
        get { return  nil } set {}
    }
    var section: Int? {
        get { return nil} set {}
    }
    var indexPath: IndexPath? {
        get { return nil} set {}
    }
    static var identifier: String? {
        get {return nil} set {}
    }
    
}
