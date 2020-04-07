//
//  Passion.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation
import UIKit

class Passion {
    var passionName: String!
    var passionImage: UIImage!
    var passionColor: UIColor!
    init(name: String, image: UIImage? = nil, color: UIColor) {
        passionName = name
        passionImage = image
        passionColor = color
    }
    
}
