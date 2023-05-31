//
//  WeatherView.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 31.05.2023.
//

import UIKit
import SnapKit

class WeatherView: UIView {

    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Images.cloudRain.text)
        imageView.tintColor = UIColor(named: Colors.infoColor.text)
        return imageView
    }()
    
    private let stackViewCity: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let stackViewWeather: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    private let stackViewDegrees: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let stackViewFeelsLike: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let stackViewDegreesAndFeelsLike: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "City"
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.textColor = UIColor(named: Colors.infoColor.text)
        return label
    }()
    
    private let searchCityButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: Images.search.text), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = UIColor(named: Colors.infoColor.text)
        return button
    }()
    
    private let valueDegreesLabel: UILabel = {
        let label = UILabel()
        label.text = "26"
        label.font = UIFont.systemFont(ofSize: 70, weight: .black)
        label.textColor = UIColor(named: Colors.infoColor.text)
        return label
    }()
    
    private let unitDegreesLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.font = UIFont.systemFont(ofSize: 70, weight: .regular)
        label.textColor = UIColor(named: Colors.infoColor.text)
        return label
    }()
    
    private let feelsLikeTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels like"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: Colors.infoColor.text)
        return label
    }()
    
    private let feelsLikeDegreesLabel: UILabel = {
        let label = UILabel()
        label.text = "23 °C"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: Colors.infoColor.text)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: private functions
private extension WeatherView {
    func setup() {
        backgroundColor = .clear
        
        searchCityButton.snp.makeConstraints({ make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        })
        stackViewCity.addArrangedSubview(cityLabel)
        stackViewCity.addArrangedSubview(searchCityButton)
        
        self.addSubview(stackViewCity)
        stackViewCity.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).inset(20)
            make.trailing.equalTo(self.snp.trailing).inset(16)
        }
        
        weatherImageView.snp.makeConstraints({ make in
            make.width.equalTo(170)
            make.height.equalTo(170)
        })
        
        stackViewFeelsLike.addArrangedSubview(feelsLikeTextLabel)
        stackViewFeelsLike.addArrangedSubview(feelsLikeDegreesLabel)
        
        stackViewDegrees.addArrangedSubview(valueDegreesLabel)
        stackViewDegrees.addArrangedSubview(unitDegreesLabel)
        
        stackViewDegreesAndFeelsLike.addArrangedSubview(stackViewDegrees)
        stackViewDegreesAndFeelsLike.addArrangedSubview(stackViewFeelsLike)

        stackViewWeather.addArrangedSubview(weatherImageView)
        stackViewWeather.addArrangedSubview(stackViewDegreesAndFeelsLike)

        self.addSubview(stackViewWeather)
        
        stackViewWeather.snp.makeConstraints({ make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).inset(20)
        })


    }
}
