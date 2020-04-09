//
//  BasicModel.swift
//  SNAdapter_Example
//
//  Created by Macbook Pro on 5/25/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SNAdapter

struct BasicModel: SNCellableModel {
	var cellIdentifier: String {
		return "ActionDelegateCell"
	}
	
    
    let title: String
}

