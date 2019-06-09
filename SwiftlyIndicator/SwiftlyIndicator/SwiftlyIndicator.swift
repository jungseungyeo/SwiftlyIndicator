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
    open func startSwiftlyIndicator() {
        DispatchQueue.main.async {
            SwiftlyIndicator.wait(self)
        }
    }

    open func startImageSwitflyIndicator(_ imageSize: CGSize = .zero , images: [UIImage], milliseconds: Int) {
        DispatchQueue.main.async {
            SwiftlyIndicator.imageWait(self, imageSize, images, milliseconds)
        }
    }

    open func rotationSwiftlyIndicator() {
        DispatchQueue.main.async {
            SwiftlyIndicator.rotationWait(self)
        }
    }

    open func rotationImageSiwftlyIndicator(_ images: [UIImage],_ bgColor: UIColor) {
        DispatchQueue.main.async {
            SwiftlyIndicator.rotationImageWait(self, images, bgColor)
        }
    }

    open func stopSwiftlyIndicator() {
        SwiftlyIndicator.stop()
    }
}

private class SwiftlyIndicator: NSObject {

    private static var rvWindow: UIWindow?
    private static var timer: DispatchSource!
    private static var timerTimes = 0

    fileprivate static var isLoop: Bool = true

    private struct Const {
        static let defaultFrame: CGRect = .init(x: 0, y: 0, width: 80, height: 80)

        static let activityIndicatorFrame: CGRect = .init(x: (Const.defaultFrame.width / 4),
                                                          y: (Const.defaultFrame.height / 4),
                                                          width: (Const.defaultFrame.width / 2),
                                                          height: (Const.defaultFrame.height / 2))
        static let activityIndicatorColor: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0.8)
    }

    @discardableResult
    static public func wait(_ rootView: UIView) -> UIWindow {
        let activityView = activityIndicatorView()
        activityView.alpha = 0.0
        let window = acitivityIndicatorWindow(rootView)
        window.addSubview(activityView)
        rvWindow = window

        UIView.animate(withDuration: 0.2, animations: {
            activityView.alpha = 1
        })

        return window
    }

    static func stop() {
        cancelPreviousPerformRequests(withTarget: self)
        if let _ = timer {
            timer.cancel()
            timer = nil
            timerTimes = 0
        }
        rvWindow = nil
    }
}

// MARK: - Default Wait
extension SwiftlyIndicator {

    private static func activityIndicatorView() -> UIView {
        let view = UIView(frame: Const.defaultFrame)
        view.layer.cornerRadius = 12
        view.backgroundColor = Const.activityIndicatorColor
        let activityindicator = UIActivityIndicatorView(style: .whiteLarge)
        activityindicator.frame = Const.activityIndicatorFrame
        activityindicator.startAnimating()
        view.addSubview(activityindicator)
        return view
    }

    private static func acitivityIndicatorWindow(_ rootView: UIView, _ customFrame: CGRect = Const.defaultFrame) -> UIWindow {
        let window = UIWindow(frame: customFrame)
        window.backgroundColor = UIColor.clear
        window.center = rootView.center
        window.windowLevel = .alert
        window.isHidden = false
        return window
    }

}

// MARK: - Image Wait
extension SwiftlyIndicator {
    static func imageWait(_ rootView: UIView, _ imageSize: CGSize, _ images: [UIImage], _ milliseconds: Int) {
        guard images.count > 0 else {
            wait(rootView)
            return
        }

        let ivFrame: CGRect = imageSize == .zero ? Const.defaultFrame : CGRect(x: 0,
                                                                               y: 0,
                                                                               width: imageSize.width,
                                                                               height: imageSize.height)

        let iv = UIImageView(frame: ivFrame)
        iv.image = images.first
        iv.contentMode = .scaleAspectFit

        let view = UIView(frame: ivFrame)
        view.addSubview(iv)

        timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)),
                                               queue: .main) as? DispatchSource

        timer.schedule(deadline: .now(),
                       repeating: .milliseconds(milliseconds))

        timer.setEventHandler(handler: {
            let name = images[timerTimes % images.count]
            iv.image = name
            timerTimes += 1
        })
        timer.resume()

        let window = acitivityIndicatorWindow(rootView, ivFrame)
        window.addSubview(view)
        rvWindow = window
    }
}

// MARK: - Rotation
extension SwiftlyIndicator {
    static func rotationWait(_ rootView: UIView) {
        let activityView = activityIndicatorView()
        activityView.alpha = 1.0
        let window = acitivityIndicatorWindow(rootView)
        window.addSubview(activityView)
        rvWindow = window
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            rvWindow?.transform = CGAffineTransform(rotationAngle: .pi / 2)
        }, completion: { finish in
            if finish {
                rotationWait(rootView)
            }
        })
    }
}

// MARK: - Rotation image
extension SwiftlyIndicator {
    static func rotationImageWait(_ rootView: UIView, _ images: [UIImage], _ bgColor: UIColor = .gray) {
        guard images.count > 0 else {
            wait(rootView)
            return
        }

        let iv = UIImageView(frame: Const.activityIndicatorFrame)
        iv.image = images.first
        iv.contentMode = .scaleAspectFit
        iv.image = images[timerTimes % images.count]

        let view = UIView(frame: Const.defaultFrame)
        view.layer.cornerRadius = 12
        view.backgroundColor = bgColor

        let window = acitivityIndicatorWindow(rootView)
        window.addSubview(view)
        window.addSubview(iv)
        rvWindow = window

        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform(rotationAngle: .pi / 2)
        }, completion: { finish in
            if finish {
                timerTimes += 1
                rotationImageWait(rootView, images, bgColor)
            }
        })
    }
}

