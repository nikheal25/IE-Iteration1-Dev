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
    
    @IBOutlet weak var firstGraphView: ScrollableGraphView!
    @IBOutlet weak var secondGraph: ScrollableGraphView!
    
    var specificCrop: Crop?
    
    @IBOutlet weak var subtitileLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    
    weak var weatherAPI: APIProtocol?
    var allWeather:[Weather] = []
    
    var hideFlagTemp = false
    var hideFlagRain = true
    
    var currentDateTime = Date()
    let formatter = DateFormatter()
    
    var rangeMaxValue = 50.00
    var rangeMinValue = 0.00
    
    var rangeRainMaxValue = 80.0
    var rangeRainMinValue = 0.00
    
    var minIdealTemperature: [Double] = []
    var maxIdealTemperature: [Double] = []
    var exactTemperature: [Double] = []
    var exactRain: [Double] = []
    lazy var plotTwoData: [Double] = self.generateRandomData(self.numberOfItems, max: 80, shouldIncludeOutliers: false)
    
    var numberOfItems = 16
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        switch(plot.identifier) {
        case "one":
            if hideFlagTemp {
                return -10
            }
            return minIdealTemperature[pointIndex]
        case "two":
            if hideFlagTemp {
                return -10
            }
            return maxIdealTemperature[pointIndex]
        case "three":
            if hideFlagTemp {
                return -10
            }
            return exactTemperature[pointIndex]
        case "rainOne":
            if hideFlagRain {
                return -2000
            }
            return exactRain[pointIndex]
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return setCurrentTime(day: pointIndex)
    }
    
    func numberOfPoints() -> Int {
        return numberOfItems
    }
    
    func showTempGraph() {
        firstGraphView.rangeMax = rangeMaxValue
        firstGraphView.rangeMin = rangeMinValue
        setupGraph(graphView: firstGraphView)
    }
    
    var tempFlag = false
    var rainFlag = false
    
    @IBAction func segmentController(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            hideFlagTemp = false
            hideFlagRain = true
            //Hide and unhide the bars
            firstGraphView.isHidden = false
            secondGraph.isHidden = true
            subtitileLabel.text = "Between red lines is the feasible temperature range \n Green line is the predicted temperature"
            mainLabel.text = "The feasible range to grow \(specificCrop!.cropName) is between \(specificCrop!.minTemp)℃ - \(specificCrop!.maxTemp)℃.\nYou will also receive alerts if the actual temperature is beyond this range. "
            if tempFlag == false {
                showTempGraph()
                tempFlag = true
            }
        }else{
            hideFlagTemp = true
            hideFlagRain = false
            //Hide and unhide the bars
            firstGraphView.isHidden = true
            secondGraph.isHidden = false
            subtitileLabel.text = "Area represents the rainfall prediction"
            mainLabel.text = "The required rainfall to grow \(specificCrop!.cropName) is \(specificCrop!.Water_Needs).\nYou will also receive alerts if the actual rainfall(mm) is beyond this range. "
            if rainFlag == false {
                secondGraph.rangeMax = rangeRainMaxValue
                secondGraph.rangeMin = rangeRainMinValue
                setupRainfallGraph(graphView: secondGraph)
                rainFlag = true
            }
        }
    }
    
    func setCurrentTime(day: Int) -> String{
        formatter.dateFormat = "MMM d"
        let interval = TimeInterval(60 * 60 * 24 * day)
        let newDate = currentDateTime.addingTimeInterval(interval)
        return formatter.string(from: newDate)
    }
    
    func returnValuesFromAPI(valueFlag: Int, weatherData: [Weather]) -> [Double] {
        var valueArray = [Double]()
        
        if valueFlag == 1 {
            for item in weatherData {
                valueArray.append(item.maxtemp)
            }
        } else if valueFlag == 2 {
            for item in weatherData {
                valueArray.append(item.mintemp)
            }
        }else{
            for item in weatherData {
                valueArray.append(item.precipProb)
            }
        }
        return valueArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainLabel.font = FontHandler.getRegularFont()
        self.title = specificCrop?.cropName
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        weatherAPI = appDelegate.weatherAPI
        
        allWeather = weatherAPI!.weather
        let totalPredictedDays = allWeather.count
        
        mainLabel.text = "The feasible range to grow \(specificCrop!.cropName) is between \(specificCrop!.minTemp)℃ - \(specificCrop!.maxTemp)℃.\nYou will also receive alerts if the actual temperature is beyond this range. "
        
        if specificCrop != nil && totalPredictedDays > 10 {
            //set total values on the graph
            numberOfItems = totalPredictedDays
            
            minIdealTemperature = []
            maxIdealTemperature = []
            let minValue = (self.specificCrop?.minTemp as! NSString).doubleValue
            let maxValue = (self.specificCrop?.maxTemp as! NSString).doubleValue
            for i in 0..<totalPredictedDays {
                minIdealTemperature.insert(minValue, at: i)
                maxIdealTemperature.insert(maxValue, at: i)
            }
            //MARK:- set exact temperature
            exactTemperature = returnValuesFromAPI(valueFlag: 1, weatherData: allWeather)
            exactRain = returnValuesFromAPI(valueFlag: 3, weatherData: allWeather)
            
            let tempExactMax = exactTemperature.max() as! Double
            
            rangeMaxValue = max( tempExactMax, maxValue ) + 10
            rangeRainMaxValue = (exactRain.max() as! Double) * 1.2
        }else{
            //MARK:- Dummy values
            let minValue = (self.specificCrop?.minTemp as! NSString).doubleValue
            let maxValue = (self.specificCrop?.maxTemp as! NSString).doubleValue
            for i in 0..<16 {
                minIdealTemperature.insert(minValue, at: i)
                maxIdealTemperature.insert(maxValue, at: i)
            }
            //MARK:- set random values
            exactTemperature = self.generateRandomData(self.numberOfItems, max: 40, shouldIncludeOutliers: false)
            exactRain = self.generateRandomData(self.numberOfItems, max: 35, shouldIncludeOutliers: false)
            rangeMaxValue = 50
            rangeRainMaxValue = 80
        }
        
        firstGraphView.dataSource = self
        secondGraph.dataSource = self
        
        showTempGraph()
        tempFlag = true
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
        
        blueLinePlot.lineWidth = 2
        blueLinePlot.lineColor = UIColor.colorFromHex(hexString: "#ff7d78")
        blueLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        blueLinePlot.shouldFill = false
        blueLinePlot.fillType = ScrollableGraphViewFillType.solid
        blueLinePlot.fillColor = UIColor.colorFromHex(hexString: "#ff7d78").withAlphaComponent(0.5)
        
        blueLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the second line plot.
        let orangeLinePlot = LinePlot(identifier: "two")
        
        orangeLinePlot.lineWidth = 2
        orangeLinePlot.lineColor = UIColor.colorFromHex(hexString: "#ff7d78")
        orangeLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        orangeLinePlot.shouldFill = false
        orangeLinePlot.fillType = ScrollableGraphViewFillType.solid
        orangeLinePlot.fillColor = UIColor.colorFromHex(hexString: "#ff7d78").withAlphaComponent(0.5)
        
        orangeLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the third line plot.
        let currentTemp = LinePlot(identifier: "three")
        
        currentTemp.lineWidth = 5
        currentTemp.lineColor = UIColor.colorFromHex(hexString: "#447604")
        currentTemp.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        currentTemp.shouldFill = false
        currentTemp.fillType = ScrollableGraphViewFillType.solid
        currentTemp.fillColor = UIColor.colorFromHex(hexString: "#447604").withAlphaComponent(0.5)
        
        currentTemp.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
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
        graphView.addPlot(plot: currentTemp)
    }
    
    func setupRainfallGraph(graphView: ScrollableGraphView) {
        
        // Setup the first line plot.
        let linePlot = LinePlot(identifier: "rainOne")
        
        linePlot.lineWidth = 2
        linePlot.lineColor = UIColor.colorFromHex(hexString: "#345995") // - 777777
        linePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        linePlot.shouldFill = true
        linePlot.fillType = ScrollableGraphViewFillType.gradient
        linePlot.fillGradientType = ScrollableGraphViewGradientType.linear
        linePlot.fillGradientStartColor = UIColor.colorFromHex(hexString: "#16aafc")
        linePlot.fillGradientEndColor = UIColor.colorFromHex(hexString: "#CCDDE2") // -444444
        //        linePlot.fillColor = UIColor.colorFromHex(hexString: "#16aafc").withAlphaComponent(0.5)
        //
        linePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        
        //Second
        let dotPlot = DotPlot(identifier: "rainOne") // Add dots as well.
        dotPlot.dataPointSize = 2
        dotPlot.dataPointFillColor = UIColor.black
        
        dotPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
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
        graphView.rangeMax = rangeRainMaxValue
        graphView.rangeMin = rangeRainMinValue
        graphView.addPlot(plot: linePlot)
        graphView.addPlot(plot: dotPlot)
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
