//
//  DogAPI.swift
//  network
//
//  Created by m.bui on 7/10/21.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint: String {
        case radomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"

        var url: URL {
            return URL(string: self.rawValue)!
        }
    }

    class func requestRandomImage(completionHandler: @escaping(DogImage?, Error?) -> Void) {
        let randomImageEndpoint = DogAPI.Endpoint.radomImageFromAllDogsCollection.url
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
