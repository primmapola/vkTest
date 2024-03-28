//
//  ServiceCell.swift
//  vkTestApp
//
//  Created by Grigory Don on 26.03.2024.
//

import UIKit

final class ShimmerView: UIView {

    let gradientLayer = CAGradientLayer()
    var startLocations: [NSNumber] = [-1.0, -0.5, 0.0]
    var endLocations: [NSNumber] = [1.0, 1.5, 2.0]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientLayer()
    }

    func setupGradientLayer() {
        gradientLayer.colors = [
            UIColor.lightGray.withAlphaComponent(0.05).cgColor,
            UIColor.lightGray.withAlphaComponent(0.8).cgColor,
            UIColor.lightGray.withAlphaComponent(0.05).cgColor,
        ]
        
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.locations = startLocations
        self.layer.addSublayer(gradientLayer)
    }

    func startShimmeringEffect() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = startLocations
        animation.toValue = endLocations
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: GifShimmerConstants.keyAnimation)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }

    func stopShimmeringEffect() {
        gradientLayer.removeAnimation(forKey: GifShimmerConstants.keyAnimation)
    }
}

private enum GifShimmerConstants {
    static let keyAnimation = "shimmeringEffect"
}
