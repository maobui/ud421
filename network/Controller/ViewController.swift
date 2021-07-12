//
//  ViewController.swift
//  network
//
//  Created by m.bui on 7/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!

    let breeds: [String] = ["greyhound", "poodle"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        pickerView.dataSource = self
        pickerView.delegate = self
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

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        breeds[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(completionHandler: self.handleRandomImageResponse(imageData: error:))
    }
}
