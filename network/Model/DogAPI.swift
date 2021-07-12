//
//  DogAPI.swift
//  network
//
//  Created by m.bui on 7/10/21.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint {
        case radomImageFromAllDogsCollection
        case radomImageForBreed(String)
        case listAllBreeds

        var url: URL {
            return URL(string: self.stringValue)!
        }

        var stringValue: String {
            switch self {
            case .radomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .radomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }

    class func requestListBreeds(completionHandler: @escaping([String], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) { data, _, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({ $0 })
            completionHandler(breeds, nil)
        }
        task.resume()
    }

    class func requestRandomImage(breed: String, completionHandler: @escaping(DogImage?, Error?) -> Void) {
        let randomImageEndpoint = DogAPI.Endpoint.radomImageForBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, _, error) in
            guard let data = data else {
                print("No data")
                completionHandler(nil, error)
                return
            }

            let decoder = JSONDecoder()
            let imgageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imgageData, nil)
        }
        task.resume()
    }

    class func downloadImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        }
        task.resume()
    }
}
