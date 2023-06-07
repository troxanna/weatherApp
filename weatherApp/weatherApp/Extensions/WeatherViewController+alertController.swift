//
//  ViewController+alertController.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 03.06.2023.
//

import Foundation
import UIKit

extension WeatherViewController {
    func presentSearchAlertController(completion: @escaping (String) -> Void) {
        let ac = UIAlertController(title: AlertControllerData.search.title, message: AlertControllerData.search.message, preferredStyle: .alert)
        ac.addTextField { tf in
            tf.placeholder = AlertControllerData.TextFieldData.city.placeholder
        }
        
        let search = UIAlertAction(title: AlertControllerData.AlertActionData.search.title, style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            let city = cityName.split(separator: " ").joined(separator: "%20")
            completion(city)
        }
        let cancel = UIAlertAction(title: AlertControllerData.AlertActionData.cancel.title, style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)

        present(ac, animated: true)
    }
}
