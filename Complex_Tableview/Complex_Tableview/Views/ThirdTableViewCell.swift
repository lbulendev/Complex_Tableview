//
//  ThirdTableViewCell.swift
//  Complex_Tableview
//
//  Created by Larry Bulen on 9/7/19.
//  Copyright © 2019 Larry Bulen. All rights reserved.
//

import UIKit
/*
 let letters: String?
*/
class ThirdTableViewCell: UITableViewCell {
    private lazy var lettersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
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
    
    func config(_ item: ThirdViewModel, at indexPath: IndexPath) {
        selectionStyle = .none
        accessoryType = .none
        
        mainStackView.addSubview(lettersLabel)
        contentView.addSubview(mainStackView)

        lettersLabel.text = "\(item.letters ?? "AAA")"
    }
    
}
