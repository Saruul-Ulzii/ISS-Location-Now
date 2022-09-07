//
//  ISSPosition.swift
//  ISS Location Now
//
//  Created by Saruululzii on 9/6/22.
//

struct ISSPosition: Codable {
    var iss_position: Coordinates
}

struct Coordinates: Codable {
    var latitude: String
    var longitude: String
}
