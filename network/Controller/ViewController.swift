//
//  ViewController.swift
//  network
//
//  Created by m.bui on 7/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let randomImageEndpoint = DogAPI.Endpoint.radomImageFromAllDogsCollection.url
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else {
                print("No data")
                return
            }

            let decoder = JSONDecoder()
            let imgageData = try! decoder.decode(DogImage.self, from: data)

            guard let imageUrl = URL(string: imgageData.message) else { return }
            let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data else { return }
                let imageDownloaded = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageView.image = imageDownloaded
                }
            }
            task.resume()

        }
        task.resume()
    }
}

