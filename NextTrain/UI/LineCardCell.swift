//
//  LineCardCell.swift
//  NextTrain
//
//  Created by Joey on 5/11/21.
//

import Foundation
import UIKit

class LineCardCell: UITableViewCell {

    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        return view
    }()

    let lineNameLabel: LineNameLabel = {
        let label = LineNameLabel()
        return label
    }()

    let stationNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()

    let leftStationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    let rightStationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    let rightStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        return label
    }()

    let leftStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        return label
    }()

    let leftStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()

    let rightStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        selectionStyle = .none
        backgroundColor = .clear

        let overlay = UIView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.backgroundColor = .white
        overlay.alpha = 0.8
        overlay.layer.cornerRadius = 16
        overlay.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .black
        separator.alpha = 0.1

        let infoStack = UIStackView(arrangedSubviews: [leftStack, rightStack])
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.axis = .horizontal
        infoStack.distribution = .fillEqually
        infoStack.spacing = 16

        let headerView = makeHeaderView()

        contentView.addSubview(cardView)
        cardView.addSubview(overlay)
        cardView.addSubview(headerView)
        cardView.addSubview(infoStack)
        cardView.addSubview(separator)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            headerView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            headerView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            infoStack.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            infoStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            infoStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            infoStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8),
            overlay.topAnchor.constraint(equalTo: lineNameLabel.bottomAnchor, constant: 8),
            overlay.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            overlay.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            separator.widthAnchor.constraint(equalToConstant: 1),
            separator.heightAnchor.constraint(equalTo: infoStack.heightAnchor),
            separator.centerXAnchor.constraint(equalTo: infoStack.centerXAnchor),
            separator.centerYAnchor.constraint(equalTo: infoStack.centerYAnchor),
            leftStatusLabel.heightAnchor.constraint(equalToConstant: 60),
            rightStatusLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func makeHeaderView() -> UIView {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false

        let leftArrowImage = UIImageView()
        leftArrowImage.translatesAutoresizingMaskIntoConstraints = false
        leftArrowImage.alpha = 0.5
        leftArrowImage.image = UIImage(systemName: "chevron.left.2")
        leftArrowImage.tintColor = .white
        leftArrowImage.contentMode = .center
        leftArrowImage.setContentHuggingPriority(.defaultLow, for: .horizontal)

        let rightArrowImage = UIImageView()
        rightArrowImage.translatesAutoresizingMaskIntoConstraints = false
        rightArrowImage.alpha = 0.5
        rightArrowImage.image = UIImage(systemName: "chevron.right.2")
        rightArrowImage.tintColor = .white
        rightArrowImage.contentMode = .center

        let titleStack = UIStackView(arrangedSubviews: [lineNameLabel, stationNameLabel])
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        titleStack.axis = .horizontal
        titleStack.spacing = 4
        titleStack.alignment = .center

        headerView.addSubview(leftStationLabel)
        headerView.addSubview(leftArrowImage)
        headerView.addSubview(titleStack)
        headerView.addSubview(rightArrowImage)
        headerView.addSubview(rightStationLabel)

        NSLayoutConstraint.activate([
            titleStack.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleStack.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleStack.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            leftStationLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            leftStationLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftArrowImage.leadingAnchor.constraint(equalTo: leftStationLabel.trailingAnchor),
            leftArrowImage.trailingAnchor.constraint(equalTo: titleStack.leadingAnchor),
            leftArrowImage.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightStationLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            rightStationLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightArrowImage.leadingAnchor.constraint(equalTo: titleStack.trailingAnchor),
            rightArrowImage.trailingAnchor.constraint(equalTo: rightStationLabel.leadingAnchor),
            rightArrowImage.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            lineNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 28),
            lineNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 28),
            rightArrowImage.heightAnchor.constraint(equalToConstant: 28),
            leftArrowImage.heightAnchor.constraint(equalToConstant: 28),
            rightArrowImage.widthAnchor.constraint(equalToConstant: 64),
            leftArrowImage.widthAnchor.constraint(equalToConstant: 64),
        ])

        return headerView
    }

    func configure(with model: LineCardViewModel) {
        cardView.backgroundColor = model.lineColor
        leftStationLabel.text = model.previousStation
        rightStationLabel.text = model.nextStation
        lineNameLabel.text = model.lineName
        lineNameLabel.font = model.lineName.count > 1 ? UIFont.boldSystemFont(ofSize: 14) : UIFont.boldSystemFont(ofSize: 24)
        stationNameLabel.text = model.stationName

        rightStatusLabel.text = model.arrivals.filter{ $0.heading == .right }.first?.message
        leftStatusLabel.text = model.arrivals.filter{ $0.heading == .left }.first?.message

        rightStack.subviews.forEach{ $0.removeFromSuperview() }
        leftStack.subviews.forEach{ $0.removeFromSuperview() }

        rightStack.addArrangedSubview(leftStatusLabel)
        leftStack.addArrangedSubview(rightStatusLabel)

        model.arrivals.filter{ $0.heading == .left }.forEach {
            rightStack.addArrangedSubview(ArrivalInfoView(viewModel: $0))
        }
        model.arrivals.filter{ $0.heading == .right }.forEach {
            leftStack.addArrangedSubview(ArrivalInfoView(viewModel: $0))
        }

        rightStack.addArrangedSubview(UIView())
        leftStack.addArrangedSubview(UIView())
    }

}
