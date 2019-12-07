//
//  ActivityViewController.swift
//  SwiftlyIndicatorExampleApp
//
//  Created by saenglin on 2019/12/07.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit
import SwiftlyIndicator

class ActivityViewController: UIViewController {
    
    lazy var swiftlyIndicator: SwiftlyIndicator = SwiftlyIndicator(view)
    
    convenience init(type: SwiftlyIndicatorType) {
        self.init(nibName: "ActivityViewController", bundle: nil)
        swiftlyIndicator.updateType(type: type)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func start(_ sender: Any) {
        swiftlyIndicator.start()
    }
    
    @IBAction func stop(_ sender: Any) {
        swiftlyIndicator.stop()
    }
}
