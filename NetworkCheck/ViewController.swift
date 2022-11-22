//
//  ViewController.swift
//  NetworkCheck
//
//  Created by Shivaditya Kumar on 2022-11-22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var internetImage: UIImageView!
    @IBOutlet weak var wifiImage: UIImageView!
    @IBOutlet weak var mobileImage: UIImageView!
    let lostImage = UIImage(systemName: "xmark.circle.fill")!
    let activeImage = UIImage(systemName: "checkmark.circle.fill")!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI(image: self.internetImage, check: NetworkManager.shared.connectionActive.value ?? false)
        self.updateUI(image: self.wifiImage, check: NetworkManager.shared.wifiActive.value ?? false)
        self.updateUI(image: self.mobileImage, check: NetworkManager.shared.mobileDataActive.value ?? false)

        self.binding()
    }
    private func updateUI(image: UIImageView ,check: Bool) {
        image.image = check ? self.activeImage : self.lostImage
        image.tintColor = check ? .green : .red
    }
    private func binding() {
        let network = NetworkManager.shared
        network.connectionActive.bind { [weak self] lost in
            guard let self else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.updateUI(image: self.internetImage, check: lost ?? false)
            }
        }
        network.wifiActive.bind { [weak self] lost in
            guard let self else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.updateUI(image: self.wifiImage, check: lost ?? false)
            }
        }
        network.mobileDataActive.bind { [weak self] lost in
            guard let self else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.updateUI(image: self.mobileImage, check: lost ?? false)
            }
        }
    }

}

