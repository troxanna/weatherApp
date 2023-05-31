//
//  ViewController.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 30.05.2023.
//

import UIKit

class WeatherViewController: UIViewController {

    private let weatherView: WeatherView = {
        let view = WeatherView()
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.background.text)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            print(view.safeAreaInsets.top)
            make.top.equalTo(view.snp.top).inset(view.safeAreaInsets.top)
            make.bottom.equalTo(view.snp.bottom).inset(view.safeAreaInsets.bottom)
            make.trailing.equalTo(view.snp.trailing)
            make.leading.equalTo(view.snp.leading)
        }
    }
}

