//
//  Constants.swift
//  ISS Location Now
//
//  Created by Saruululzii on 9/6/22.
//

import Foundation

enum Constants {
    static let API_URL: String = "http://api.open-notify.org/iss-now.json"
    static let annotationCustomImageName: String = "pin_satellite"
    
    static let fetchInterval = 3.0
    
    static let latitudinalMeters: Int = 500000
    static let longitudinalMeters: Int = 500000
}
