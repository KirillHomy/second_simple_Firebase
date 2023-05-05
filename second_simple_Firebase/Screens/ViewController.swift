//
//  ViewController.swift
//  second_simple_Firebase
//
//  Created by Kirill Khomytsevych on 03.05.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Private IBOutlet
    @IBOutlet private weak var modelLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var carImage: UIImageView!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Private IBAction
    @IBAction private func aOneAction(_ sender: Any) {
        setupFirebaseModel(collectionChild: "cheapCar", imageName: "audi_a1")
    }

    @IBAction private func aFourAction(_ sender: Any) {
        setupFirebaseModel(collectionChild: "averageCar", imageName: "audi_a4")
    }

    @IBAction private func aSevenAction(_ sender: Any) {
        setupFirebaseModel(collectionChild: "expensiveCar", imageName: "audi_a7")
    }

}

private extension ViewController {

    func setupUI() {
        setupBackgroundColor()
    }

    func setupBackgroundColor() {
        let colorTop = UIColor(hex: "#516395").cgColor
        let colorBottom = UIColor(hex: "#614385").cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at:0)
    }

    func setupFirebaseModel(collectionChild: String, imageName: String) {
        APIManager().getPost(collection: "cars", docName: collectionChild) { [weak self] model in
            guard let model = model,
                  let sSelf = self else { return }
            sSelf.typeLabel.text = model.type
            sSelf.modelLabel.text = model.model
        }
        APIManager().getImage(picName: imageName) { [weak self] image in
            guard let sSelf = self else { return }
            sSelf.carImage.image = image
        }
    }

}

