//
//  FontHandler.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 17/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import Foundation
import UIKit

class FontHandler{
    /// Method returns the font that is required for the labels
    static func getRegularFont() -> UIFont {
        return  UIFont(name: "SFProText-Regular", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)
    }
}
