//
//  ViewController.swift
//  SwiftlyIndicatorExample
//
//  Created by 여정승 on 09/06/2019.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit
import SwiftlyIndicator

class ViewController: UIViewController {

    private var isPlay: Bool = false

    private let swiftlyType: [SwiftlyIndicatorType] = [.basic,
                                                       .rotationBasic,
                                                       .circleBasic,
                                                       .image(images: [#imageLiteral(resourceName: "snowColor"), #imageLiteral(resourceName: "sunColor"), #imageLiteral(resourceName: "dropColor")],
                                                              chagedMilliseconds: 200),
                                                       .rotationImage(images: [#imageLiteral(resourceName: "drop"), #imageLiteral(resourceName: "rain.png"), #imageLiteral(resourceName: "sun.png")])]

    private let pickerTitle: [String] = ["basic",
                                         "rotationBasic",
                                         "circleBasic",
                                         "image",
                                         "rotationImage"]

    @IBOutlet weak var pickerView: UIPickerView!

    @IBAction func startBtn(_ sender: Any) {
        view.startWaiting()
        changedStatus()
    }

    @IBAction func stopBtn(_ sender: Any) {
        view.stopWaiting()
        changedStatus()
    }

    private func changedStatus() {
        isPlay = !isPlay
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self

        // defualt type basic
        view.startWaiting()
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        view.setupSwiftlyIndicator(type: swiftlyType[row] )

        if isPlay {
            view.stopWaiting()
            view.startWaiting()
        }
    }
}

extension ViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return swiftlyType.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerTitle[row]
    }
}
