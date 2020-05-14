//
//  GraphViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 14/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit
import ScrollableGraphView

class GraphViewController: UIViewController, ScrollableGraphViewDataSource {
    
    @IBOutlet weak var graphView: ScrollableGraphView!
    
    var specificCrop: Crop?
    
    var minIdealTemperature: [Double] = []
    lazy var plotTwoData: [Double] = self.generateRandomData(self.numberOfItems, max: 80, shouldIncludeOutliers: false)
    
    var numberOfItems = 16
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        switch(plot.identifier) {
        case "one":
            return minIdealTemperature[pointIndex]
        case "two":
            return plotTwoData[pointIndex]
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return "FEB \(pointIndex+1)"
    }
    
    func numberOfPoints() -> Int {
        return numberOfItems
    }
    
    @IBAction func segmentController(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            minIdealTemperature = self.generateRandomData(self.numberOfItems, max: 100, shouldIncludeOutliers: true)
            plotTwoData = self.generateRandomData(self.numberOfItems, max: 100, shouldIncludeOutliers: true)
            graphView.rangeMax = 50
            setupGraph(graphView: graphView)
        }else{
            setupGraph(graphView: graphView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if specificCrop != nil {
            minIdealTemperature = []
            let minValue = (self.specificCrop?.minTemp as! NSString).doubleValue
            
            for i in 0..<16 {
                minIdealTemperature.insert(minValue, at: i)
            }
//            print(minIdealTemperature)
        }

        graphView.dataSource = self
        graphView.rangeMax = 50
        setupGraph(graphView: graphView)
        
    }
    
    private func generateRandomData(_ numberOfItems: Int, max: Double, shouldIncludeOutliers: Bool = true) -> [Double] {
        var data = [Double]()
        for _ in 0 ..< numberOfItems {
            var randomNumber = Double(arc4random()).truncatingRemainder(dividingBy: max)
            
            if(shouldIncludeOutliers) {
                if(arc4random() % 100 < 10) {
                    randomNumber *= 3
                }
            }
            
            data.append(randomNumber)
        }
        return data
    }
    
    func setupGraph(graphView: ScrollableGraphView) {
        
        // Setup the first line plot.
        let blueLinePlot = LinePlot(identifier: "one")
        
        blueLinePlot.lineWidth = 5
        blueLinePlot.lineColor = UIColor.colorFromHex(hexString: "#16aafc")
        blueLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        blueLinePlot.shouldFill = false
        blueLinePlot.fillType = ScrollableGraphViewFillType.solid
        blueLinePlot.fillColor = UIColor.colorFromHex(hexString: "#16aafc").withAlphaComponent(0.5)
        
        blueLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the second line plot.
        let orangeLinePlot = LinePlot(identifier: "two")
        
        orangeLinePlot.lineWidth = 5
        orangeLinePlot.lineColor = UIColor.colorFromHex(hexString: "#ff7d78")
        orangeLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        orangeLinePlot.shouldFill = false
        orangeLinePlot.fillType = ScrollableGraphViewFillType.solid
        orangeLinePlot.fillColor = UIColor.colorFromHex(hexString: "#ff7d78").withAlphaComponent(0.5)
        
        orangeLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Customise the reference lines.
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.black.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.black
        
        referenceLines.dataPointLabelColor = UIColor.black.withAlphaComponent(1)
        
        // All other graph customisation is done in Interface Builder,
        // e.g, the background colour would be set in interface builder rather than in code.
        // graphView.backgroundFillColor = UIColor.colorFromHex(hexString: "#333333")
        
        // Add everything to the graph.
        graphView.addReferenceLines(referenceLines: referenceLines)
        graphView.addPlot(plot: blueLinePlot)
        graphView.addPlot(plot: orangeLinePlot)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UIColor {
    
    // Convert a hex string to a UIColor object.
    class func colorFromHex(hexString:String) -> UIColor {
        
        func clean(hexString: String) -> String {
            
            var cleanedHexString = String()
            
            // Remove the leading "#"
            if(hexString[hexString.startIndex] == "#") {
                let index = hexString.index(hexString.startIndex, offsetBy: 1)
                cleanedHexString = String(hexString[index...])
            }
            
            // TODO: Other cleanup. Allow for a "short" hex string, i.e., "#fff"
            
            return cleanedHexString
        }
        
        let cleanedHexString = clean(hexString: hexString)
        
        // If we can get a cached version of the colour, get out early.
        if let cachedColor = UIColor.getColorFromCache(hexString: cleanedHexString) {
            return cachedColor
        }
        
        // Else create the color, store it in the cache and return.
        let scanner = Scanner(string: cleanedHexString)
        
        var value:UInt32 = 0
        
        // We have the hex value, grab the red, green, blue and alpha values.
        // Have to pass value by reference, scanner modifies this directly as the result of scanning the hex string. The return value is the success or fail.
        if(scanner.scanHexInt32(&value)){
            
            // intValue = 01010101 11110111 11101010    // binary
            // intValue = 55       F7       EA          // hexadecimal
            
            //                     r
            //   00000000 00000000 01010101 intValue >> 16
            // & 00000000 00000000 11111111 mask
            //   ==========================
            // = 00000000 00000000 01010101 red
            
            //            r        g
            //   00000000 01010101 11110111 intValue >> 8
            // & 00000000 00000000 11111111 mask
            //   ==========================
            // = 00000000 00000000 11110111 green
            
            //   r        g        b
            //   01010101 11110111 11101010 intValue
            // & 00000000 00000000 11111111 mask
            //   ==========================
            // = 00000000 00000000 11101010 blue
            
            let intValue = UInt32(value)
            let mask:UInt32 = 0xFF
            
            let red = intValue >> 16 & mask
            let green = intValue >> 8 & mask
            let blue = intValue & mask
            
            // red, green, blue and alpha are currently between 0 and 255
            // We want to normalise these values between 0 and 1 to use with UIColor.
            let colors:[UInt32] = [red, green, blue]
            let normalised = normalise(colors: colors)
            
            let newColor = UIColor(red: normalised[0], green: normalised[1], blue: normalised[2], alpha: 1)
            UIColor.storeColorInCache(hexString: cleanedHexString, color: newColor)
            
            return newColor
            
        }
            // We couldn't get a value from a valid hex string.
        else {
            print("Error: Couldn't convert the hex string to a number, returning UIColor.whiteColor() instead.")
            return UIColor.white
        }
    }
    
    // Takes an array of colours in the range of 0-255 and returns a value between 0 and 1.
    private class func normalise(colors: [UInt32]) -> [CGFloat]{
        var normalisedVersions = [CGFloat]()
        
        for color in colors{
            normalisedVersions.append(CGFloat(color % 256) / 255)
        }
        
        return normalisedVersions
    }
    
    // Caching
    // Store any colours we've gotten before. Colours don't change.
    private static var hexColorCache = [String : UIColor]()
    
    private class func getColorFromCache(hexString: String) -> UIColor? {
        guard let color = UIColor.hexColorCache[hexString] else {
            return nil
        }
        
        return color
    }
    
    private class func storeColorInCache(hexString: String, color: UIColor) {
        
        if UIColor.hexColorCache.keys.contains(hexString) {
            return // No work to do if it is already there.
        }
        
        UIColor.hexColorCache[hexString] = color
    }
    
    private class func clearColorCache() {
        UIColor.hexColorCache.removeAll()
    }
}
