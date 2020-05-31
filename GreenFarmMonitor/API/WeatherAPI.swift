//
//  WeatherAPI.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 4/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

//public struct DailyWeather: Codable {
//
//    public let id: Int
//    public let title: String
//    public let overview: String
//    public let releaseDate: Date
//    public let voteAverage: Double
//    public let voteCount: Int
//    public let adult: Bool
//}




//MARK:-  This method contains the calls for the Crop Recommendation API and weather API
class WeatherAPI: NSObject, APIProtocol {
    
    
    
    //    func fetchFilms(completionHandler: @escaping ([DailyWeather]) -> Void) {
    //      let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/daily?city=Raleigh,NC&key=b26f508726974d9cb185ca7bdfa3636c")!
    //
    //      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
    //        if let error = error {
    //          print("Error with fetching films: \(error)")
    //          return
    //        }
    //
    //        guard let httpResponse = response as? HTTPURLResponse,
    //              (200...299).contains(httpResponse.statusCode) else {
    //          print("Error with the response, unexpected status code: \(response)")
    //          return
    //        }
    //
    ////        if let data = data,
    ////          let filmSummary = try? JSONDecoder().decode(FilmSummary.self, from: data) {
    ////          completionHandler(filmSummary.results ?? [])
    ////        }
    //      })
    //      task.resume()
    //    }
    var weather = [Weather]()
    var recomendedCrops = [String]()
    var lat = ""
    var long = ""
    var todaysForecast = [Weather]()
    
    /// This method calls the API which is responsible for returning the data of all the recommended crops
    /// - Parameters:
    ///   - lat: <#lat description#>
    ///   - long: <#long description#>
    func apiRecommendedCrop(lat: String, long: String) -> [String]
    {
        
        var minTemp = 18.2
        var maxTemp = 25.5
        if weather.count > 0 {
            minTemp = weather[0].mintemp
            maxTemp = weather[0].maxtemp
        }else{
            todaysForecast = apiCall(lat: lat, long: long)
            minTemp = 15
            maxTemp = 18
            print("********wait")
        }
        
        let session = URLSession.shared
        //MARK:-Backup values
        self.recomendedCrops = "Broccoli,Brussels Sprouts,Cauliflower,Garlic,Kale,Kohlrabi,Onion,Celery,Lettuce,Kohlrabi,Mustard Greens".components(separatedBy: ",")
        //        let url = URL(string: "https://secure-shelf-88213.herokuapp.com/suggestions?tempLow=10&tempHigh=12&long=-192.55&lat=15.2")!
        let url = URL(string: "https://whispering-wildwood-58870.herokuapp.com/suggestions?tempLow=\(minTemp)&tempHigh=\(maxTemp)&long=\(long)&lat=\(long)")!
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: [])as? [String: Any]
                let suggestedCrops = json!["crops"] as! String
                let cropArray = suggestedCrops.components(separatedBy: ",")
                
                if cropArray.count > 0{
                    self.recomendedCrops = cropArray
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
                
            }
        }
        task.resume()
        
        return self.recomendedCrops
    }
    
    /// This method calls the API which is responsible for returning the data of the weather according to the location
    func apiCall(lat: String, long: String) -> [Weather]
    {
        let para = "lat=\(lat)&lon=\(long)"
        let session = URLSession.shared
        let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/daily?\(para)&key=b26f508726974d9cb185ca7bdfa3636c")!
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: [])as? [String: Any]
                print(json)
                let lat = json!["lat"]as! Double
                let long = json!["lon"]as! Double
                print(lat)
                print(long)
                let jsonP = json!["data"] as! NSArray
                
                for dailydata in jsonP
                {
                    let maxtemp = (dailydata as AnyObject).value(forKey: "max_temp") as! Double
                    let mintemp = (dailydata as AnyObject).value(forKey: "min_temp") as! Double
                    let date = (dailydata as AnyObject).value(forKey: "datetime") as! String
                    let precip = (dailydata as AnyObject).value(forKey: "precip") as! Double
                    let precipProb = (dailydata as AnyObject).value(forKey: "pop") as! Double
                    
                    
                    
                    self.weather.append(Weather(maxtemp: maxtemp, mintemp: mintemp, date: date, precip: precip,  precipProb: precipProb, lat: String(lat) , long: String(long)))
                    
                    
                    
                }
                
                
                
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        }
        
        task.resume()
        
        return weather
    }
    
    override init() {
        super.init()
        
        
    }
    
}
