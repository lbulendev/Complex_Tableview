//
//  FirstTableViewCell.swift
//  Complex_Tableview
//
//  Created by Larry Bulen on 9/7/19.
//  Copyright © 2019 Larry Bulen. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    private lazy var numLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        return label
    }()

    private lazy var letterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        return label
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()

    static var estimatedSize: CGSize {
        return CGSize(width: 200, height: 80)
    }

    static func size(_ item: FirstViewModel, at indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 80)
    }

    struct Constants {
        static let padding = UIEdgeInsets(top: 16, left: 16, bottom: -16, right: 16)
    }

    private func arrangeConstraints() {
        let mainStackViewConstraints: [NSLayoutConstraint] = [
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding.top),
            mainStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.padding.left),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.padding.bottom),
            mainStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.padding.right),
        ]
        NSLayoutConstraint.activate(mainStackViewConstraints)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    func config(_ item: FirstViewModel, at indexPath: IndexPath) {
        selectionStyle = .none
        accessoryType = .none
        numLabel.text = "\(item.num ?? 0)"
        letterLabel.text = "\(item.letter?.uppercased() ?? "A")"

        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(numLabel)
        mainStackView.addArrangedSubview(letterLabel)
        self.arrangeConstraints()
    }

}
