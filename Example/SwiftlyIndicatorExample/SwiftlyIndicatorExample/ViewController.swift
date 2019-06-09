//
//  ViewController.swift
//  SwiftlyIndicatorExample
//
//  Created by 여정승 on 09/06/2019.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit
import SwiftlyIndicator

enum IndicatorType: Int, CustomStringConvertible {
    case defaultIndicator
    case defaultRotation
    case imageIndicator
    case imageRotation

    var description: String {
        switch self {
        case .defaultIndicator:
            return "defualt"
        case .defaultRotation:
            return "defaultRotation"
        case .imageIndicator:
            return "imageIndicator"
        case .imageRotation:
            return "imageRotation"
        }
    }

}

class ViewController: UIViewController {

    let items: [IndicatorType] = [.defaultIndicator, .defaultRotation, .imageIndicator, .imageRotation]

    lazy var tableView: UITableView = {
        let tableview = UITableView(frame: self.view.bounds)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .white
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedType = IndicatorType(rawValue: indexPath.row) else {
            return
        }

        if let vc = SwiftlyIndicatorViewController.instance() {
            vc.type = selectedType
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row])"
        return cell
    }


}

