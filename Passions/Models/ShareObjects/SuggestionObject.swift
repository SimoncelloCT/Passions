//
//  SuggestionObject.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation

class SuggestionObject : ShareObject {
    override public func getContentTypeName() -> String { //virtual method
        return "Suggestion"
    }
}
