//
//  WeatherView.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 31.05.2023.
//

import UIKit
import SnapKit

class WeatherView: UIView {

    lazy private var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Images.WeatherIcons.none.text)
        imageView.tintColor = UIColor(named: Colors.infoColor.text)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy private var stackViewCity: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    lazy private var stackViewWeather: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    lazy private var stackViewDegrees: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    lazy private var stackViewFeelsLike: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    lazy private var stackViewDegreesAndFeelsLike: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    lazy private var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.textColor = UIColor(named: Colors.infoColor.text)
        return label
    }()
    
    lazy private var valueDegreesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 70, weight: .black)
        label.textColor = UIColor(named: Colors.infoColor.text)
        return label
    }()
    
    lazy private var unitDegreesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 70, weight: .regular)
        label.text = "°C"
        label.textColor = UIColor(named: Colors.infoColor.text)
        return label
    }()
    
    lazy private var feelsLikeTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels like"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: Colors.infoColor.text)
        return label
    }()
    
    lazy private var feelsLikeDegreesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: Colors.infoColor.text)
        return label
    }()
    
    lazy private var errorMessage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: Colors.infoColor.text)
        label.isHidden = true
        return label
    }()
    
    let searchCityButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: Images.search.text), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = UIColor(named: Colors.infoColor.text)
        return button
    }()
    
    let activateLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Включить геолокацию", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = UIColor(named: Colors.infoColor.text)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    init() {
        super.init(frame: .zero)
        setup()
        self.isHidden = true
        activateLocationButton.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: private functions
private extension WeatherView {
    func setup() {
        backgroundColor = .clear
        
        searchCityButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        stackViewCity.addArrangedSubview(cityLabel)
        stackViewCity.addArrangedSubview(searchCityButton)
        
        self.addSubview(stackViewCity)
        stackViewCity.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).inset(20)
            make.trailing.equalTo(self.snp.trailing).inset(16)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.width.equalTo(170)
            make.height.equalTo(170)
        }
        
        stackViewFeelsLike.addArrangedSubview(feelsLikeTextLabel)
        stackViewFeelsLike.addArrangedSubview(feelsLikeDegreesLabel)
        
        stackViewDegrees.addArrangedSubview(valueDegreesLabel)
        stackViewDegrees.addArrangedSubview(unitDegreesLabel)
        
        stackViewDegreesAndFeelsLike.addArrangedSubview(stackViewDegrees)
        stackViewDegreesAndFeelsLike.addArrangedSubview(stackViewFeelsLike)

        stackViewWeather.addArrangedSubview(weatherImageView)
        stackViewWeather.addArrangedSubview(stackViewDegreesAndFeelsLike)

        self.addSubview(stackViewWeather)
        
        stackViewWeather.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).inset(20)
        }
        
        self.addSubview(activateLocationButton)
        activateLocationButton.snp.makeConstraints { make in
            make.top.equalTo(stackViewWeather.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(stackViewWeather.snp.width)
        }
        
        self.addSubview(errorMessage)
        errorMessage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherImageView.snp.bottom).offset(20)
        }
    }
}

//MARK: public functions
extension WeatherView {
    func insertData(currentWeather: CurrentWeather) {
        cityLabel.text = currentWeather.cityName
        valueDegreesLabel.text = currentWeather.temperatureString
        feelsLikeDegreesLabel.text = currentWeather.feelsLikeTemperatureString
        weatherImageView.image = UIImage(systemName: currentWeather.systemIconNameString)
        
        stackViewDegreesAndFeelsLike.isHidden = false
        errorMessage.isHidden = true
        activateLocationButton.isHidden = true
    }
    
    func showInfoForError(type: ErrorType) {
        errorMessage.text = type.message
        weatherImageView.image = UIImage(systemName: Images.WeatherIcons.none.text)
        
        stackViewDegreesAndFeelsLike.isHidden = true
        errorMessage.isHidden = false
        activateLocationButton.isHidden = true
        
        
        switch type {
        case ErrorType.locationDisabled:
            activateLocationButton.isHidden = false
        default:
            return
        }
    }
}
