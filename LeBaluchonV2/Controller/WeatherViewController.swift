//
//  WeatherViewController.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 17/11/2021.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var geCityTempLabel: UILabel!
    @IBOutlet weak var nyCityTempLabel: UILabel!
    @IBOutlet weak var conditionGeLabel: UILabel!
    @IBOutlet weak var conditionNyLabel: UILabel!
    
    @IBOutlet weak var loadingWeatherIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var iconGeView: UIImageView!
    @IBOutlet weak var iconNyView: UIImageView!
    
    // MARK: - Let & Var
    
    private let serviceWeather = WeatherService()

    private var temperatureGE: Double? {
        didSet {
            if let tempGE = temperatureGE {
                let numberFormatter = NumberFormatter()
                numberFormatter.maximumFractionDigits = 0
                let GeTemp = numberFormatter.string(for: tempGE)
                geCityTempLabel.text = (GeTemp ?? "") + "°"
                geCityTempLabel.isHidden = false
                loadingWeatherIndicator.isHidden = true
            }
        }
    }
    
    private var temperatureNY: Double? {
        didSet {
            if let tempNY = temperatureNY {
                let numberFormatter = NumberFormatter()
                numberFormatter.maximumFractionDigits = 0
                let NyTemp = numberFormatter.string(for: tempNY)
                nyCityTempLabel.text = (NyTemp ?? "") + "°"
                nyCityTempLabel.isHidden = false
            }
        }
    }
    
    private var conditionGeID: Int = 0
    private var conditionGeName: String {
        switch conditionGeID {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud.fill"
        }
    }
    
    private var conditionNyID: Int = 0
    private var conditionNyName: String {
        switch conditionNyID {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud.fill"
        }
    }
    
    // MARK: - Override
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.geCityTempLabel.isHidden = true
        self.nyCityTempLabel.isHidden = true
        self.loadingWeatherIndicator.isHidden = false
        self.loadingWeatherIndicator.startAnimating()
        getDataWeather()
    }
    
    // MARK: - Functions
    
    private func getDataWeather() {
        self.serviceWeather.getWeather() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.temperatureGE = weather.list[0].main.temp
                    self?.temperatureNY = weather.list[1].main.temp
                    
                    self?.conditionGeLabel.text = weather.list[0].weather[0].main
                    self?.conditionNyLabel.text = weather.list[1].weather[0].main
                    
                    self?.conditionGeID = weather.list[0].weather[0].id
                    self?.conditionNyID = weather.list[1].weather[0].id
                    
                    self?.iconGeView.image = UIImage(systemName: self!.conditionGeName)
                    self?.iconNyView.image = UIImage(systemName: self!.conditionNyName)
                    
                case .failure(let error):
                    self?.showAlert(message: error.description)
                }
            }
        }
    }
}
// End of class
