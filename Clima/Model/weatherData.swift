//
//  weatherData.swift
//  Clima
//
//  Created by Rishabh Bhati on 09/07/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
//decodable protocol is type that can decode itself from an external representation.
struct weatherData:Decodable{
    let name: String
    let main: Main
    let weather: [Weather]
    
}
struct Main: Decodable{
    let temp: Double
}
struct Weather:Decodable{
    let description: String
    let id: Int
}
