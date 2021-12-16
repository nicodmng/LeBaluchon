//
//  WeatherViewController.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 17/11/2021.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - IBOutlets & IBActions
    @IBOutlet weak var GeCityTempLabel: UILabel!
    @IBOutlet weak var NyCityTempLabel: UILabel!
    @IBOutlet weak var conditionGeLabel: UILabel!
    @IBOutlet weak var conditionNyLabel: UILabel!
    
    @IBOutlet weak var loadingWeatherIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var iconGeView: UIImageView!
    @IBOutlet weak var iconNyView: UIImageView!
    
    // MARK: - Let & Var
    var serviceWeather = WeatherService()

    var temperatureGE: Double? {
        didSet {
            if let tempGE = temperatureGE {
                let numberFormatter = NumberFormatter()
                numberFormatter.maximumFractionDigits = 0
                let GeTemp = numberFormatter.string(for: tempGE)
                GeCityTempLabel.text = GeTemp ?? "--" + "°"
                GeCityTempLabel.isHidden = false
                loadingWeatherIndicator.isHidden = true
            }
        }
    }
    
    var temperatureNY: Double? {
        didSet {
            if let tempNY = temperatureNY {
                let numberFormatter = NumberFormatter()
                numberFormatter.maximumFractionDigits = 0
                let NyTemp = numberFormatter.string(for: tempNY)
                NyCityTempLabel.text = NyTemp
                NyCityTempLabel.isHidden = false
            }
        }
    }
    
    var conditionWeatherGE: String? {
        didSet {
            if let conditionGE = conditionWeatherGE {
                conditionGeLabel.text = conditionGE
            }
        }
    }
    
    var conditionWeatherNY: String? {
        didSet {
            if let conditionNY = conditionWeatherNY {
                conditionNyLabel.text = conditionNY
            }
        }
    }
    
    var conditionGeID: Int = 0
    var conditionGeName: String {
        switch conditionGeID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
    var conditionNyID: Int = 0
    var conditionNyName: String {
        switch conditionNyID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
    // MARK: - Override
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.GeCityTempLabel.isHidden = true
        self.NyCityTempLabel.isHidden = true
        self.loadingWeatherIndicator.isHidden = false
        self.loadingWeatherIndicator.startAnimating()
        getDataWeather()
    }
    
    // MARK: - Functions
    func getDataWeather() {
        self.serviceWeather.getWeather() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.temperatureGE = weather.list[0].main.temp
                    self.conditionWeatherGE = weather.list[0].weather[0].main
                    self.temperatureNY = weather.list[1].main.temp
                    self.conditionWeatherNY = weather.list[1].weather[0].main
                    self.conditionGeID = weather.list[0].weather[0].id
                    self.conditionNyID = weather.list[1].weather[0].id
                    self.iconGeView.image = UIImage(systemName: self.conditionGeName)
                    self.iconNyView.image = UIImage(systemName: self.conditionNyName)
                case .failure(let error):
                    self.showAlert(message: error.description)
                }
            }
        }
    }
}
// End of class

// MARK: - Extensions
extension UIView {
  @IBInspectable var cornerRadius: CGFloat {
   get{
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
        layer.masksToBounds = newValue > 0
    }
  }
}
