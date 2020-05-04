//
//  WeatherAPI.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 4/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

public struct DailyWeather: Codable {
    
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: Date
    public let voteAverage: Double
    public let voteCount: Int
    public let adult: Bool
}

class WeatherAPI: NSObject {

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
    
    func apiCall()  {
        let session = URLSession.shared
        let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/daily?city=Raleigh,NC&key=b26f508726974d9cb185ca7bdfa3636c")!

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
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
    
    override init() {
        super.init()
      apiCall()
    }
    
}
