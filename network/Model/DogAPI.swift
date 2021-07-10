//
//  DogAPI.swift
//  network
//
//  Created by m.bui on 7/10/21.
//

import Foundation

class DogAPI {
    enum Endpoint: String {
        case radomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"

        var url: URL {
            return URL (string: self.rawValue)!
        }
    }
}
