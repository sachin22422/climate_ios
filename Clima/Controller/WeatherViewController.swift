//
//  ViewController.swift
//  Clima


import UIKit
import CoreLocation
class WeatherViewController: UIViewController{

    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var searchTextField: UITextField!
    var weathermanager=weatherManager()
    var locationManager=CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate=self
        locationManager.requestLocation()

        weathermanager.delegate=self
        searchTextField.delegate = self
        
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }
        else{
            textField.placeholder="Type Something"
            return false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let city=searchTextField.text{
            weathermanager.fetchWeather(cityName: city)
            
        }
        searchTextField.text=""
    }
    
}

//MARK: - weatherManagerDelegate

extension WeatherViewController: weatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: weatherManager, weather: WeatherModel) {
        DispatchQueue.main.sync {
            temperatureLabel.text=weather.tempString
            conditionImageView.image=UIImage(systemName: weather.condition)
            cityLabel.text=weather.cityName
        }
        
        print(weather.temp)
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
//MARK: - CLLocationManager
extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location=locations.last{
            let lat=location.coordinate.latitude
            let lon=location.coordinate.longitude
            weathermanager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
