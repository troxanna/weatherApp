//
//  ViewController.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 30.05.2023.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    private let weatherView: WeatherView = {
        let view = WeatherView()
        view.searchCityButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.background.text)
        return imageView
    }()
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    var onCompletion: (() throws -> CurrentWeather) -> () = {_ in }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if currentReachabilityStatus == .notReachable {
            self.handlerError(for: ErrorType.networkError)
        } else {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.requestLocation()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            do {
                let data = try currentWeather()
                self.updateInterfaceWith(weather: data)
            } catch ErrorType.cityNotFound {
                self.handlerError(for: ErrorType.cityNotFound)
            } catch {
                self.handlerError(for: ErrorType.internalServerError)
            }
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        setup()
    }
}

//MARK: private functions
private extension WeatherViewController {
    func setup() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
        
        view.addSubview(weatherView)
        weatherView.isHidden = true
        weatherView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(view.safeAreaInsets.top)
            make.bottom.equalTo(view.snp.bottom).inset(view.safeAreaInsets.bottom)
            make.trailing.equalTo(view.snp.trailing)
            make.leading.equalTo(view.snp.leading)
        }
    }
    
    @objc func searchButtonPressed() {
        presentSearchAlertController { [weak self] cityName in
            guard let self = self else { return }
            if self.currentReachabilityStatus == .notReachable {
                self.handlerError(for: ErrorType.networkError)
            } else {
                APIManager.shared.getCurrentWeather(for: ApiType.getWeatherByCityName(city: cityName), completion: self.onCompletion)
            }
        }
    }
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.weatherView.insertData(currentWeather: weather)
            self.weatherView.isHidden = false
        }
    }
}

//MARK: CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        APIManager.shared.getCurrentWeather(for: ApiType.getWeatherByCoordinate(latitude: latitude, longitude: longitude), completion: onCompletion)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.handlerError(for: ErrorType.locationDisabled)
        }
    }
}

//MARK: HandlerError
private extension WeatherViewController {
    func handlerError(for type: ErrorType) {
        DispatchQueue.main.async {
            self.weatherView.showInfoForError(type: type)
            self.weatherView.isHidden = false
        }
    }
}

