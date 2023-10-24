//
//  UViewController+ViewCast.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 23.10.2023.
//

import UIKit

protocol RootViewGettable: UIViewController {
    
    associatedtype RootView: UIView
    var rootView: RootView? { get }
}

extension RootViewGettable {
    var rootView: RootView? {
        self.view as? RootView
    }
}
