//
//  MainViewController.swift
//  Complex_Tableview
//
//  Created by Larry Bulen on 9/7/19.
//  Copyright © 2019 Larry Bulen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak var headerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
//    var firstModels: [FirstViewModel]?
    var firstModels: [FirstViewModel]? = [
        FirstViewModel(num: 1, letter: "A"),
        FirstViewModel(num: 2, letter: "B"),
        FirstViewModel(num: 3, letter: "C"),
        FirstViewModel(num: 4, letter: "D"),
        FirstViewModel(num: 5, letter: "E"),
        FirstViewModel(num: 6, letter: "F"),
        FirstViewModel(num: 7, letter: "G"),
        FirstViewModel(num: 8, letter: "H"),
        FirstViewModel(num: 9, letter: "I"),
        FirstViewModel(num: 10, letter: "J"),
        FirstViewModel(num: 11, letter: "K"),
        FirstViewModel(num: 12, letter: "L"),
        FirstViewModel(num: 13, letter: "M"),
        FirstViewModel(num: 14, letter: "N"),
        FirstViewModel(num: 15, letter: "O"),
        FirstViewModel(num: 16, letter: "P"),
        FirstViewModel(num: 17, letter: "Q"),
        FirstViewModel(num: 18, letter: "R"),
        FirstViewModel(num: 19, letter: "S"),
        FirstViewModel(num: 20, letter: "T"),
        FirstViewModel(num: 21, letter: "U"),
        FirstViewModel(num: 22, letter: "V"),
        FirstViewModel(num: 23, letter: "W"),
        FirstViewModel(num: 24, letter: "X"),
        FirstViewModel(num: 25, letter: "Y"),
        FirstViewModel(num: 26, letter: "Z"),
    ]
//    var secondModels: [SecondViewModel]?
    var secondModels: [SecondViewModel]? = [
        SecondViewModel(num: 1, numSquare: 1),
        SecondViewModel(num: 2, numSquare: 4),
        SecondViewModel(num: 3, numSquare: 9),
        SecondViewModel(num: 4, numSquare: 16),
        SecondViewModel(num: 5, numSquare: 25),
        SecondViewModel(num: 6, numSquare: 36),
        SecondViewModel(num: 7, numSquare: 49),
        SecondViewModel(num: 8, numSquare: 64),
        SecondViewModel(num: 9, numSquare: 81),
        SecondViewModel(num: 10, numSquare: 100),
        SecondViewModel(num: 11, numSquare: 121),
        SecondViewModel(num: 12, numSquare: 144),
        SecondViewModel(num: 13, numSquare: 169),
        SecondViewModel(num: 14, numSquare: 196),
        SecondViewModel(num: 15, numSquare: 225),
        SecondViewModel(num: 16, numSquare: 256),
        SecondViewModel(num: 17, numSquare: 289),
        SecondViewModel(num: 18, numSquare: 324),
        SecondViewModel(num: 19, numSquare: 361),
        SecondViewModel(num: 20, numSquare: 400),
    ]
//    var thirdModels: [ThirdViewModel]?
    var thirdModels: [ThirdViewModel]? = [
        ThirdViewModel(letters: "A"),
        ThirdViewModel(letters: "BB"),
        ThirdViewModel(letters: "CCC"),
        ThirdViewModel(letters: "DDDD"),
        ThirdViewModel(letters: "EEEEE"),
        ThirdViewModel(letters: "FFFFFF"),
        ThirdViewModel(letters: "GGGGGGG"),
        ThirdViewModel(letters: "HHHHHHHH"),
        ThirdViewModel(letters: "IIIIIIIII"),
        ThirdViewModel(letters: "JJJJJJJJJJ"),
        ThirdViewModel(letters: "KKKKKKKKKKK"),
        ThirdViewModel(letters: "LLLLLLLLLLLL"),
        ThirdViewModel(letters: "MMMMMMMMMMMMM"),
        ThirdViewModel(letters: "NNNNNNNNNNNNNN"),
        ThirdViewModel(letters: "OOOOOOOOOOOOOOO"),
        ThirdViewModel(letters: "PPPPPPPPPPPPPPPP"),
        ThirdViewModel(letters: "QQQQQQQQQQQQQQQQQ"),
        ThirdViewModel(letters: "RRRRRRRRRRRRRRRRRR"),
        ThirdViewModel(letters: "SSSSSSSSSSSSSSSSSSS"),
        ThirdViewModel(letters: "TTTTTTTTTTTTTTTTTTTT"),
        ThirdViewModel(letters: "UUUUUUUUUUUUUUUUUUUUU"),
        ThirdViewModel(letters: "VVVVVVVVVVVVVVVVVVVVVV"),
        ThirdViewModel(letters: "WWWWWWWWWWWWWWWWWWWWWWW"),
        ThirdViewModel(letters: "XXXXXXXXXXXXXXXXXXXXXXXX"),
        ThirdViewModel(letters: "YYYYYYYYYYYYYYYYYYYYYYYYY"),
        ThirdViewModel(letters: "ZZZZZZZZZZZZZZZZZZZZZZZZZZ"),
    ]

    func setupViewModels() {
        for index in 0..<26 {
            let u = UnicodeScalar.init(index + 65)
            let char = Character.init(u!)
            self.firstModels?.append(FirstViewModel(num: index + 1, letter: char))
        }
        for index in 0..<20 {
            let num: Int = index + 1
            self.secondModels?.append(SecondViewModel(num: num, numSquare: num * num))
        }
        for index in 0..<25 {
            let u = UnicodeScalar.init(index + 65)
            let char = Character.init(u!)
            var letterString: String = ""
            for _ in -1..<index {
                letterString = letterString + String(char)
            }
            self.thirdModels?.append(ThirdViewModel(letters: letterString))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = FirstTableViewCell.estimatedSize.height
        self.segmentedControl.setupSegment()

        let left = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe))
        left.direction = .left
        self.tableView.addGestureRecognizer(left)

        let right = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe))
        right.direction = .right
        self.tableView.addGestureRecognizer(right)
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
        self.segmentedControl.setupSegment()
    }

    @objc
    func leftSwipe() {
        if (self.segmentedControl.selectedSegmentIndex < 2) {
            self.segmentedControl.selectedSegmentIndex = self.segmentedControl.selectedSegmentIndex + 1
            self.tableView.reloadData()
            self.segmentedControl.setupSegment()
        }
    }

    @objc
    func rightSwipe() {
        if (self.segmentedControl.selectedSegmentIndex > 0) {
            self.segmentedControl.selectedSegmentIndex = self.segmentedControl.selectedSegmentIndex - 1
            self.tableView.reloadData()
            self.segmentedControl.setupSegment()
        }
    }

    // Delegate = UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfRows: Int = 0
        switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            numOfRows = self.firstModels!.count
        case 1:
            numOfRows = self.secondModels!.count
        default:
            numOfRows = self.thirdModels!.count
        }
        return numOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: "FirstTableViewCell") as?
                FirstTableViewCell else {
                    return FirstTableViewCell()
            }
            cell.config(firstModels![indexPath.row], at: indexPath)
            return cell
        case 1:
            guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "SecondTableViewCell") as?
                SecondTableViewCell else {
                    return SecondTableViewCell()
            }
            cell.config(secondModels![indexPath.row], at: indexPath)
            return cell
        default:
            guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "ThirdTableViewCell") as?
                ThirdTableViewCell else {
                    return ThirdTableViewCell()
            }
            cell.config(thirdModels![indexPath.row], at: indexPath)
            return cell
        }
    }

    // Delegate = UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if(offset > 60){
            self.headerViewConstraint.constant = 0
            self.headerView.isHidden = true
        }else{
            self.headerViewConstraint.constant = 60
            self.headerView.isHidden = false
        }
    }

}

/***** https://stackoverflow.com/questions/42755590/how-to-display-only-bottom-border-for-selected-item-in-uisegmentedcontrol
*****/

extension UISegmentedControl {
    
    func removeBorder(){
        
        self.tintColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor : UIColor.orange], for: .selected)
        self.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor : UIColor.gray], for: .normal)
        
    }
    
    func setupSegment() {
        self.removeBorder()
        let segmentUnderlineWidth: CGFloat = self.bounds.width
        let segmentUnderlineHeight: CGFloat = 2.0
        let segmentUnderlineXPosition = self.bounds.minX
        let segmentUnderLineYPosition = self.bounds.size.height - 1.0
        let segmentUnderlineFrame = CGRect(x: segmentUnderlineXPosition, y: segmentUnderLineYPosition, width: segmentUnderlineWidth, height: segmentUnderlineHeight)
        let segmentUnderline = UIView(frame: segmentUnderlineFrame)
        segmentUnderline.backgroundColor = UIColor.gray
        
        self.addSubview(segmentUnderline)
        self.addUnderlineForSelectedSegment()
        
    }
    func addUnderlineForSelectedSegment(){
        
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor.orange
        underline.tag = 1
        self.addSubview(underline)
    }
    
    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        underline.frame.origin.x = underlineFinalXPosition
        
    }
}
