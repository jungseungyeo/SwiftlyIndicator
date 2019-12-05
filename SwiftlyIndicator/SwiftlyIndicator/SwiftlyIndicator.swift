//
//  SwiftlyIndicator.swift
//  SwiftlyIndicator
//
//  Created by 여정승 on 2019/11/20.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit
import Foundation

public enum SwiftlyIndicatorType {
    case `default`
    case normal
    case circle
    case image(images: [UIImage], second: TimeInterval)
    case rotation(images: [UIImage])
}

public class SwiftlyIndicator: NSObject {

    public private(set) var currentType: SwiftlyIndicatorType = .default

    public private(set) lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        indicator.color = .label
        return indicator
    }()

    public private(set) lazy var indicatorBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGray
        view.frame.size = const.indicatorBackgroundSize
        view.layer.cornerRadius = const.indicatorBackgroundRadius
        view.isHidden = true
        return view
    }()

    public private(set) lazy var imageIndicatorView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFit
        iv.frame.size = const.indicatorBackgroundSize
        return iv
    }()

    private lazy var indicatorImages: [UIImage] = []
    private lazy var changedSecond: TimeInterval = TimeInterval(const.rotationSecond)
    private var timer: Timer?
    private lazy var changedCount: Int = 0
    private lazy var isStop: Bool = true
    private lazy var rotaionSecond: TimeInterval = TimeInterval(const.rotationSecond)

    private var activityView: UIView!

    private struct Const {
        let indicatorBackgroundSize: CGSize = .init(width: 100, height: 100)
        let indicatorBackgroundRadius: CGFloat = 10
        let rotationBackgroundSize: CGSize = .init(width: 100, height: 100)
        let rotationImageSize: CGSize = .init(width: 40, height: 40)
        let rotationSecond: CGFloat = 0.5
    }

    private let const = Const()

    public convenience init(_ view: UIView) {
        self.init()
        self.activityView = view
        self.setupDefault()
    }
    private override init() { super.init() }
}

// start Indicator
public extension SwiftlyIndicator {

    func start() {
        switch self.currentType {
        case .default, .circle:
            indicatorBackground.isHidden = false
            indicator.startAnimating()
        case .normal:
            indicator.startAnimating()
        case .image:
            guard timer == nil else { return }
            imageIndicatorView.isHidden = false
            indicatorBackground.isHidden = true
            timer?.invalidate()
            imageChanged()
            timer = Timer.scheduledTimer(timeInterval: changedSecond, target: self, selector: #selector(imageChanged), userInfo: nil, repeats: true)
        case .rotation:
            guard isStop else { return }
            isStop = false
            imageIndicatorView.isHidden = false
            indicatorBackground.isHidden = false
            rotaionBackgorund()
        }
    }

    @objc
    private func imageChanged() {
        guard let image = indicatorImages[safe: changedCount % indicatorImages.count] else {
            imageIndicatorStop()
            return
        }

        imageIndicatorView.image = image
        changedCount += 1
    }

    @objc
    private func rotaionBackgorund() {
        guard !isStop else {
            rotaionStop()
            return
        }
        imageChanged()

        UIView.animate(withDuration: rotaionSecond, animations: { [weak self] in
            guard let self = self else { return }
            self.indicatorBackground.transform = CGAffineTransform(rotationAngle: (.pi / 2))
            }, completion: { [weak self] finish in
                guard let self = self else { return }
                self.indicatorBackground.transform = .identity
                self.rotaionBackgorund()
        })
    }
}

// stop Indicator
public extension SwiftlyIndicator {
    func stop() {
        switch self.currentType {
        case .default, .normal, .circle:
            indicatorBackground.isHidden = true
            indicator.stopAnimating()
        case .image:
            imageIndicatorStop()
        case .rotation:
            rotaionStop()
        }
    }

    private func imageIndicatorStop() {
        timer?.invalidate()
        timer = nil
        imageIndicatorView.isHidden = true
        changedCount = 0
    }

    private func rotaionStop() {
        isStop = true
        indicatorBackground.isHidden = true
        imageIndicatorView.isHidden = true
    }
}

// update Indicator
public extension SwiftlyIndicator {

    func updateType(type: SwiftlyIndicatorType) {
        self.currentType = type

        switch self.currentType {
        case .default:
            indicatorBackground.layer.cornerRadius = const.indicatorBackgroundRadius
        case .normal:
            indicatorBackground.isHidden = true
            indicator.style = .medium
        case .circle:
            indicatorBackground.layer.cornerRadius = const.indicatorBackgroundSize.height / 2
        case .image(let images, let second):
            setupImageIndicator(images: images, second: second)
        case .rotation(let images):
            setupRotationImage(images: images)
        }
    }

    func updateImageSize(size: CGSize) {
        imageIndicatorView.frame.size = size
        imageIndicatorView.center = activityView.center
    }

    func updateBackgroundSzie(size: CGSize) {
        indicatorBackground.frame.size = size
        indicatorBackground.center = activityView.center
    }

    func updateRadius(radius: CGFloat) {
        indicatorBackground.layer.cornerRadius = radius
    }

    func updateRotaionSecond(second: TimeInterval) {
        rotaionSecond = second
    }
}

// setup Indicator
private extension SwiftlyIndicator {

    func setupDefault() {
        activityView.addSubview(indicatorBackground)
        activityView.addSubview(indicator)
        activityView.addSubview(imageIndicatorView)

        indicatorBackground.center = activityView.center
        indicator.center = activityView.center
        imageIndicatorView.center = activityView.center
    }

    func setupImageIndicator(images: [UIImage], second: TimeInterval) {
        indicatorImages = images
        changedSecond = second
    }

    func setupRotationImage(images: [UIImage]) {
        indicatorImages = images

        imageIndicatorView.frame.size = const.rotationImageSize
        indicatorBackground.frame.size = const.rotationBackgroundSize

        imageIndicatorView.center = activityView.center
        indicatorBackground.center = activityView.center
    }

}

private extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
