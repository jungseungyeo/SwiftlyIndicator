//
//  SwiftlyIndicator.swift
//  SwiftlyIndicator
//
//  Created by Jung seoung Yeo on 09/06/2019.
//  Copyright © 2019 Jung seoung Yeo. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    public func startWaiting() {
        DispatchQueue.main.async {
            switch SwiftlyIndicator.shared.type {
            case .basic, .circleBasic:
                SwiftlyIndicator.shared.wait(self)
            case .rotationBasic:
                SwiftlyIndicator.shared.rotationWait(self)
            case .image:
                SwiftlyIndicator.shared.imageWait(self)
            case .rotationImage:
                SwiftlyIndicator.shared.rotationImageWait(self)
            }
        }
    }

    public func setupSwiftlyIndicator(type: SwiftlyIndicatorType) {
        SwiftlyIndicator.shared.setup(type)
    }

    public func stopWaiting() {
        DispatchQueue.main.async {
            SwiftlyIndicator.shared.stop()
        }
    }

}

public enum SwiftlyIndicatorType: Equatable {
    case basic
    case rotationBasic
    case circleBasic
    case image(images: [UIImage], chagedMilliseconds: Int)
    case rotationImage(images: [UIImage])
}

private class SwiftlyIndicator: NSObject {

    fileprivate static let shared = SwiftlyIndicator()

    private var indicatorWindow: UIWindow?
    private(set) var type: SwiftlyIndicatorType = .basic
    private var images: [UIImage]? = nil
    private var chagedMillisecondTime: Int = 200
    private var timerTimes = 0
    private var timer: DispatchSource!

    private override init() {
        super.init()
    }

    private struct Const {
        let defaultFrame: CGRect = .init(x: 0, y: 0, width: 80, height: 80)

        let activityIndicatorFrame: CGRect = .init(x: (80 / 4),
                                                   y: (80 / 4),
                                                   width: (80 / 2),
                                                   height: (80 / 2))
        let activityIndicatorColor: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0.8)
    }

    private let const = Const()

    fileprivate func setup(_ type: SwiftlyIndicatorType) {
        self.type = type
        switch type {
        case .basic, .rotationBasic, .circleBasic:
            images = nil
            chagedMillisecondTime = 200
        case .image(let images, let chagedMilliseconds):
            self.images = images
            self.chagedMillisecondTime = chagedMilliseconds
        case .rotationImage(let images):
            self.images = images
            self.chagedMillisecondTime = 200
        }
    }

    fileprivate func stop() {
        if let _ = timer {
            timer.cancel()
            timerTimes = 0
            timer = nil
        }
        indicatorWindow = nil
    }
}

// MARK: - Default Wait
extension SwiftlyIndicator {
    fileprivate func wait(_ rootView: UIView) {
        let radius: CGFloat = type == .circleBasic ? 40 : 12
        let activityView = activityIndicatorView(radius: radius)
        activityView.alpha = 0.0
        let window = acitivityIndicatorWindow(rootView)
        window.addSubview(activityView)
        indicatorWindow = window

        UIView.animate(withDuration: 0.2, animations: {
            activityView.alpha = 1
        })
    }

    private func activityIndicatorView(radius: CGFloat = 12) -> UIView {
        let view = UIView(frame: const.defaultFrame)
        view.layer.cornerRadius = radius
        view.backgroundColor = const.activityIndicatorColor
        let activityindicator = UIActivityIndicatorView(style: .whiteLarge)
        activityindicator.frame = const.activityIndicatorFrame
        activityindicator.startAnimating()
        view.addSubview(activityindicator)
        return view
    }

    private func acitivityIndicatorWindow(_ rootView: UIView) -> UIWindow {
        let window = UIWindow(frame: const.defaultFrame)
        window.backgroundColor = UIColor.clear
        window.center = rootView.center
        window.windowLevel = .alert
        window.isHidden = false
        return window
    }

}

// MARK: - Image Wait
extension SwiftlyIndicator {
    fileprivate func imageWait(_ rootView: UIView) {
        guard let images = images, images.count > 0 else {
            self.wait(rootView)
            return
        }

        let ivFrame: CGRect = const.defaultFrame

        let iv = UIImageView(frame: ivFrame)
        iv.image = images.first
        iv.contentMode = .scaleAspectFit

        let view = UIView(frame: ivFrame)
        view.addSubview(iv)

        timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)),
                                               queue: .main) as? DispatchSource

        timer.schedule(deadline: .now(),
                       repeating: .milliseconds(chagedMillisecondTime))

        timer.setEventHandler(handler: { [weak self] in
            guard let self = self else { return }
            let name = images[self.timerTimes % images.count]
            iv.image = name
            self.timerTimes += 1
        })
        timer.resume()

        let window = acitivityIndicatorWindow(rootView)
        window.addSubview(view)
        indicatorWindow = window
    }
}

// MARK: - Rotation
extension SwiftlyIndicator {
    fileprivate func rotationWait(_ rootView: UIView) {
        let activityView = activityIndicatorView()
        activityView.alpha = 1.0
        let window = acitivityIndicatorWindow(rootView)
        window.addSubview(activityView)
        indicatorWindow = window
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            self.indicatorWindow?.transform = CGAffineTransform(rotationAngle: .pi / 2)
            }, completion: { [weak self] finish in
                guard let self = self else { return }
                if finish {
                    self.rotationWait(rootView)
                }
        })
    }
}

// MARK: - Rotation image
extension SwiftlyIndicator {
    fileprivate func rotationImageWait(_ rootView: UIView) {
        guard let images = images, images.count > 0 else {
            self.wait(rootView)
            return
        }
        let iv = UIImageView(frame: const.activityIndicatorFrame)
        iv.image = images.first
        iv.contentMode = .scaleAspectFit
        iv.image = images[timerTimes % images.count]

        let view = UIView(frame: const.defaultFrame)
        view.layer.cornerRadius = 12
        view.backgroundColor = .gray

        let window = acitivityIndicatorWindow(rootView)
        window.addSubview(view)
        window.addSubview(iv)
        indicatorWindow = window

        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform(rotationAngle: .pi / 2)
        }, completion: { [weak self] finish in
            guard let self = self else { return }
            if finish {
                self.timerTimes += 1
                self.rotationImageWait(rootView)
            }
        })
    }
}

