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
        DogAPI.requestRandomImage(completionHandler: self.handleRandomImageResponse(imageData: error:))
    }

    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        DogAPI.requestRandomImage { imageData, error in
            guard let imageUrl = URL(string: imageData?.message ?? "") else { return }
            DogAPI.downloadImageFile(url: imageUrl, completionHandler: self.handleImageFileResponse(image: error:))
        }
    }

    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
