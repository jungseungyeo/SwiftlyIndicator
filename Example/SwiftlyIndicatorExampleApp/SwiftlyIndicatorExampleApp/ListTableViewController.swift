//
//  ListTableViewController.swift
//  SwiftlyIndicatorExampleApp
//
//  Created by saenglin on 2019/12/06.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit
import SwiftlyIndicator

extension SwiftlyIndicatorType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .default:
            return "default"
        case .normal:
            return "normal"
        case .circle:
            return "circle"
        case .image:
            return "image"
        case .rotation:
            return "rotation"
        }
    }
}

class ListTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let types: [SwiftlyIndicatorType] = [.default,
                                                 .circle,
                                                 .normal,
                                                 .image(images: [UIImage(named: "dropColor")!,
                                                                 UIImage(named: "snowColor")!,
                                                                 UIImage(named: "sunColor")!], second: 0.3),
                                                 .rotation(images: [UIImage(named: "drop")!,
                                                                    UIImage(named: "rain")!,
                                                                    UIImage(named: "sun")!])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let activityVC = ActivityViewController(type: types[indexPath.row])
        self.navigationController?.pushViewController(activityVC, animated: true)
        
    }
}

extension ListTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCellID", for: indexPath)
        
        cell.textLabel?.text = "\(types[indexPath.row])"
        return cell
    }
}


