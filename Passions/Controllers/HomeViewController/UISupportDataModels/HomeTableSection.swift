//
//  HomeTableSection.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation

class HomeTableSection{
    var sectionName :String!
    var sectionItems : [Any]!
    var lastTargetIndices : [Int]!
    
    init(name: String, items : [Any]) {
        self.sectionName = name
        self.sectionItems = items
        self.lastTargetIndices = [Int].init(repeating: 0, count: sectionItems.count)
    }
    
    private func updateTargetIndices(forCount count:Int){
        let newArray = [Int].init(repeating: 0, count: count)
        lastTargetIndices.append(contentsOf: newArray)
    }

    func appendItems(items: [Any]){
        self.sectionItems.append(contentsOf: items)
        updateTargetIndices(forCount: items.count)
    }
    
}
