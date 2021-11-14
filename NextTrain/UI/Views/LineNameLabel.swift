//
//  LineNameLabel.swift
//  NextTrain
//
//  Created by Joey on 8/11/21.
//

import Foundation
import UIKit

class LineNameLabel: UILabel {

    var widthConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.boldSystemFont(ofSize: 24)
        textColor = .white
        layer.cornerRadius = 14
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        textAlignment = .center
    }

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        guard let text = text, text.count > 1 else {
            return originalSize
        }
        // Adding extra padding for labels with more than 1 character to compensate for rounded border.
        return CGSize(width: originalSize.width + 16, height: originalSize.height)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if widthConstraint == nil {
            widthConstraint = widthAnchor.constraint(equalToConstant: 28)
        }
        if let text = text, text.count > 1 {
            widthConstraint?.constant = intrinsicContentSize.width
            widthConstraint?.isActive = true
        } else {
            widthConstraint?.constant = 28
            widthConstraint?.isActive = true
        }
    }

}
