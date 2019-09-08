//
//  SecondTableViewCell.swift
//  Complex_Tableview
//
//  Created by Larry Bulen on 9/7/19.
//  Copyright © 2019 Larry Bulen. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    private lazy var numLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var numSquareLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.red
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private func arrangeConstraints() {
        let mainStackViewConstraints: [NSLayoutConstraint] = [
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            mainStackView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width),
            mainStackView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height)
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
 
    func config(_ item: SecondViewModel, at indexPath: IndexPath) {
        selectionStyle = .none
        accessoryType = .none
        
        mainStackView.addSubview(numLabel)
        mainStackView.addSubview(numSquareLabel)
        contentView.addSubview(mainStackView)

        numLabel.text = "\(item.num ?? 0)"
        numSquareLabel.text = "\(item.numSquare ?? 0)"
    }

}
