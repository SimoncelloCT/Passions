//
//  SSCVSignalUpdateObserver.swift
//  Passions
//
//  Created by Simone Scionti on 05/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation
import UIKit

protocol SSCVSignalUpdateObserver : class {
    func alphaChanged(alpha :CGFloat)
    func targetIndexChanged(targetIndex: Int, previousTargetIndex : Int)
}
