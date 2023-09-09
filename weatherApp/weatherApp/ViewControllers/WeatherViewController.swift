//
//  ViewController.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 30.05.2023.
//

import UIKit

class WeatherViewController: UIViewController {

    lazy private var loader: UIAlertController = {
        let alert = UIAlertController(title: nil, message: "please wait...", preferredStyle: .alert)
        return alert
    }()
    
    lazy private var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.style = .large
        return indicator
    }()
    
    lazy private var weatherView: WeatherView = {
        let view = WeatherView()
        view.searchCityButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        view.activateLocationButton.addTarget(self, action: #selector(activateLocationButtonPressed), for: .touchUpInside)
        return view
    }()
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.background.text)
        return imageView
    }()
    
    private var cityName: String? = nil
    
    var onCompletion: (() throws -> CurrentWeather) -> () = {_ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnCompletion()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startLoader()
        if currentReachabilityStatus == .notReachable {
            self.handlerError(for: ErrorType.networkError)
        } else {
            LocationManager.shared.getUsersLocation { [weak self] location in
                guard let self = self else { return }
                do {
                    guard let locations = location else { throw ErrorType.locationDisabled }
                    let latitude = locations.coordinate.latitude
                    let longitude = locations.coordinate.longitude
                    
                    APIManager.shared.getCurrentWeather(for: ApiType.getWeatherByCoordinate(latitude: latitude, longitude: longitude), completion: self.onCompletion)
                } catch {
                    self.handlerError(for: ErrorType.locationDisabled)
                    DispatchQueue.main.async {
                        self.stopLoader()
                        self.weatherView.isHidden = false
                    }
                }
                
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
        weatherView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(view.safeAreaInsets.top)
            make.bottom.equalTo(view.snp.bottom).inset(view.safeAreaInsets.bottom)
            make.trailing.equalTo(view.snp.trailing)
            make.leading.equalTo(view.snp.leading)
        }
        loader.view.addSubview(indicator)
    }
    
    @objc func searchButtonPressed() {
        presentSearchAlertController { [weak self] cityName in
            guard let self = self else { return }
            self.cityName = cityName
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
        }
    }
    
    func setupOnCompletion() {
        onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            do {
                let data = try currentWeather()
                self.updateInterfaceWith(weather: data)
            }
            catch ErrorType.cityNotFound {
                self.handlerError(for: ErrorType.cityNotFound(cityName))
            }
            catch {
                self.handlerError(for: ErrorType.internalServerError)
            }
            DispatchQueue.main.async {
                self.stopLoader()
                self.weatherView.isHidden = false
            }
        }
    }
    
}

//MARK: HandlerError
private extension WeatherViewController {
    func handlerError(for type: ErrorType) {
        DispatchQueue.main.async {
            self.weatherView.showInfoForError(type: type)
        }
    }
    
    @objc func activateLocationButtonPressed() {
        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
    }
}

//MARK: Loader
private extension WeatherViewController {
    func startLoader() {
        indicator.startAnimating()
        self.present(loader, animated: true)
    }
    
    func stopLoader() {
        indicator.stopAnimating()
        self.loader.dismiss(animated: true)
    }
}
