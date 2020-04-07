//
//  UITableCellTargettingObserver.swift
//  Passions
//
//  Created by Simone Scionti on 07/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation
import UIKit
protocol UITableCellTargettingObserver {
    func tableCell(cell: UITableViewCell ,targetChanged toIndex: Int)
}
