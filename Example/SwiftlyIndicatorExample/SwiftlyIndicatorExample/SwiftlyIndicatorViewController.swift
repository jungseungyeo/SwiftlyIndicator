//
//  SwiftlyIndicator.swift
//  SwiftlyIndicatorExample
//
//  Created by 여정승 on 09/06/2019.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import Foundation
import SwiftlyIndicator

class SwiftlyIndicatorViewController: UIViewController {

    var type: IndicatorType = .defaultIndicator

    let images: [UIImage] = [#imageLiteral(resourceName: "drop"), #imageLiteral(resourceName: "rain.png"), #imageLiteral(resourceName: "sun.png")]
    let colorImages: [UIImage] = [#imageLiteral(resourceName: "snowColor"), #imageLiteral(resourceName: "sunColor"), #imageLiteral(resourceName: "snowColor")]

    static func instance() -> SwiftlyIndicatorViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SwiftlyIndicatorViewController") as? SwiftlyIndicatorViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        switch type {
        case .defaultIndicator:
            view.startSwiftlyIndicator()
        case .defaultRotation:
            view.rotationSwiftlyIndicator()
        case .imageIndicator:
            view.startImageSwitflyIndicator(images: colorImages, milliseconds: 200)
        case .imageRotation:
            view.rotationImageSiwftlyIndicator(images, .gray)
        }
    }
    @IBAction func stopIndicator(_ sender: Any) {
        view.stopSwiftlyIndicator()
    }
}
