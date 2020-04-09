//
//  File.swift
//  Passions
//
//  Created by Simone Scionti on 09/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

protocol SSTextViewObserver : class {
    func textDidChange(newText: String)
    func startEditing()
    func endEditing()
    func confirmButtonClicked(currentText: String)
}
