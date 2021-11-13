//
//  ArrrivalInfoView.swift
//  NextTrain
//
//  Created by Joey on 13/11/21.
//

import Foundation
import UIKit

class ArrivalInfoView: UIStackView {

    let timeDirectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor(white: 0, alpha: 0.6)
        label.font = .systemFont(ofSize: 12)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()

    let viewModel: ArrivalCardViewModel!

    init(viewModel: ArrivalCardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        axis = .horizontal
        spacing = 8
        addArrangedSubview(timeDirectionLabel)
        addArrangedSubview(messageLabel)

        let time = viewModel.timeOfArrival?.hourMinuteFormattedString() ?? ""
        timeDirectionLabel.text = "\(time) \(viewModel.baseStation)"
        messageLabel.text = viewModel.message
        messageLabel.textColor = viewModel.lineColor
    }

}
