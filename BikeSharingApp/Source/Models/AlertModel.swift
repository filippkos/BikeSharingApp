//
//  AlertModel.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 25.10.2023.
//

import UIKit

public struct AlertModel {
    
    let title: String
    let message: String
    let actions: [UIAlertAction]
    
    public init(title: String, message: String, actions: [UIAlertAction]) {
        self.title = title
        self.message = message
        self.actions = actions
    }
    
    public init(error: Error) {
        self.title = "Error"
        self.message = error.localizedDescription
        self.actions = []
    }
}
