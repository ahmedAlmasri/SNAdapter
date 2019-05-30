//
//  SectionModel.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SNAdapter

struct SectionModel: SNCellableModel {
    var title: String
    var list: [BasicModel]
}
