//
//  weatherManager.swift
//  Clima
//
//  Created by Rishabh Bhati on 30/06/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol weatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: weatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct weatherManager{
    var delegate: weatherManagerDelegate?
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?&appid=fa298e1fb3ea17a12316fd1b6ca45fd8&units=metric"
    
    func fetchWeather(cityName:String){
        let urlString="\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func fetchWeather(latitude:Double, longitude: Double){
        let urlString="\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        // 1. create URL
        if let url=URL(string: urlString){
            //2. Create URL Session
            let session=URLSession(configuration: .default)
            
            //3. give URL session some task
            let task = session.dataTask(with: url) { (data, reponse, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData=data{
                    //we will have to use "self" keyword as we are under a closure and in closeure it little bit hard for xcode to findout if we are under the same structure or not
                    if let weather = self.parseJSON(safeData){
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            //4. Start the Task
            task.resume()
        }
    }
    
    func parseJSON(
        _ weatherdata: Data)->WeatherModel?{
        let decoder=JSONDecoder()
        do{
            let decodedData=try decoder.decode(weatherData.self, from: weatherdata)
            let id=decodedData.weather[0].id
            let name=decodedData.name
            let temp=decodedData.main.temp
            
            let weather = WeatherModel(id: id, cityName: name, temp: temp)
            return weather
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
