//
//  F.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 23.10.2023.
//

import Foundation

public enum F {

    typealias ResultHandler<T> = (Result<T, Error>) -> ()
    typealias VoidFunc<T> = (T) -> ()
}
