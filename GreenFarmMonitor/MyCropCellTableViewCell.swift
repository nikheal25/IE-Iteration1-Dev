//
//  MyCropCellTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class MyCropCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cropImageView: UIImageView!
    @IBOutlet weak var cropTitleLable: UILabel!
    @IBOutlet weak var cellView: UIView!
    var opened = Bool()
    
    func setCell(crop: Crop, opened: Bool) {
        self.opened = opened
        
        cropTitleLable.text = crop.cropName
        cropImageView.image = UIImage(named: crop.cropImage)
            //// MARK:- color behind cell
        self.contentView.backgroundColor = UIColor(hexString: "#B5D4BE")
        self.cellView.layer.cornerRadius = 8
        self.cellView.layer.shadowOpacity = 0.4
        self.cellView.layer.shadowRadius = 2
//        self.cellView.layer.masksToBounds = true
//        self.cellView.layer.shadowColor = UIColor(named: "Orange")?.cgColor
//         self.cropImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.cropImageView.layer.cornerRadius = 6
    }
}
extension UIColor {
convenience init(hexString: String, alpha: CGFloat = 1.0) {
    let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let scanner = Scanner(string: hexString)
    if (hexString.hasPrefix("#")) {
        scanner.scanLocation = 1
    }
    var color: UInt32 = 0
    scanner.scanHexInt32(&color)
    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask
    let red   = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue  = CGFloat(b) / 255.0
    self.init(red:red, green:green, blue:blue, alpha:alpha)
}
func toHexString() -> String {
    var r:CGFloat = 0
    var g:CGFloat = 0
    var b:CGFloat = 0
    var a:CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
    return String(format:"#%06x", rgb)
}
}
