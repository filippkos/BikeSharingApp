//
//  Coordinator+PresentAlert.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 25.10.2023.
//

import UIKit

extension Coordinator {
    
    // MARK: -
    // MARK: Public
    
    public func presentAlert(alertModel: AlertModel, controller: UIViewController? = nil) {
        let presenter = controller ?? self.navigationViewController
        let alert = UIAlertController(title: alertModel.title, message: alertModel.message, preferredStyle: .alert)
        if !alertModel.actions.isEmpty {
            alertModel.actions.forEach {
                alert.addAction($0)
            }
        } else {
            alert.addAction(UIAlertAction(title: "ок", style: .cancel))
        }
        
        presenter.present(alert, animated: true)
    }
}
