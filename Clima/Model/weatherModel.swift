//
//  weatherModel.swift
//  Clima
//
//  Created by Rishabh Bhati on 09/07/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel{
    let id: Int
    let cityName: String
    let temp: Double
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
    //computing property
    // var property: Int{
    //    return 2+5
    //}
    // similarly we will define condition property on the basis of the result of id range
    var condition: String{
        switch id {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    }
    
}

