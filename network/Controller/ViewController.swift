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

    var breeds: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        pickerView.dataSource = self
        pickerView.delegate = self

        DogAPI.requestListBreeds(completionHandler: self.handleBreedsListResponse(breeds: error:))
    }

    func handleBreedsListResponse(breeds: [String], error: Error?) {
        self.breeds = breeds
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }

    }

    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        guard let imageUrl = URL(string: imageData?.message ?? "") else { return }
        DogAPI.downloadImageFile(url: imageUrl, completionHandler: self.handleImageFileResponse(image: error:))
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
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: self.handleRandomImageResponse(imageData: error:))
    }
}
