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
    
    var firstModels: [FirstViewModel]? = [
        FirstViewModel(num: 1, letter: "Q")
    ]
    var secondModels: [SecondViewModel]? = [
        SecondViewModel(num: 4, numSquare: 16)
    ]
    var thirdModels: [ThirdViewModel]? = [
        ThirdViewModel(letters: "QQQ")
    ]

//    func setupViewModels() {
//        for index in 0..<26 {
//            let u = UnicodeScalar.init(index + 65)
//            let char = Character.init(u!)
//            self.firstModels?.append(FirstViewModel(num: index + 1, letter: char))
//        }
//        for index in 0..<20 {
//            let num: Int = index + 1
//            self.secondModels?.append(SecondViewModel(num: num, numSquare: num * num))
//        }
//        for index in 0..<25 {
//            let u = UnicodeScalar.init(index + 65)
//            let char = Character.init(u!)
//            var letterString: String = ""
//            for _ in -1..<index {
//                letterString = letterString + String(char)
//            }
//            self.thirdModels?.append(ThirdViewModel(letters: letterString))
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setupViewModels()
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 88
        self.segmentedControl.setupSegment()

        let left = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe))
        left.direction = .left
        self.tableView.addGestureRecognizer(left)

        let right = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe))
        right.direction = .right
        self.tableView.addGestureRecognizer(right)
    }

    @IBAction func segmentedControlValueChanged(_ sender: Any) {
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
//            numOfRows = 26
            numOfRows = self.firstModels!.count
        case 1:
//            numOfRows = 20
            numOfRows = self.secondModels!.count
        default:
//            numOfRows = 25
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
//            cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
//            cell.textLabel?.text = "\(indexPath.row + 1)"
//            let u = UnicodeScalar.init(indexPath.row + 65)
//            let char = Character.init(u!)
//            cell.detailTextLabel?.text = "\(char)"
            //        cell.contentView.layoutIfNeeded()
        case 1:
            guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "SecondTableViewCell") as?
                SecondTableViewCell else {
                    return SecondTableViewCell()
            }
            cell.config(secondModels![indexPath.row], at: indexPath)
            return cell
//            cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
//            let num: Int = 10 - indexPath.row
//            cell.textLabel?.text = "\(num)"
//            cell.detailTextLabel?.text = "\(num)^2 = \(num * num)"
        default:
            guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "ThirdTableViewCell") as?
                ThirdTableViewCell else {
                    return ThirdTableViewCell()
            }
            cell.config(thirdModels![indexPath.row], at: indexPath)
            return cell
//            cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", for: indexPath) as! ThirdTableViewCell
//            let u = UnicodeScalar.init(indexPath.row + 65)
//            let char = Character.init(u!)
//            var localString: String = ""
//            for _ in -1..<indexPath.row {
//                localString = localString + String(char)
//            }
//            cell.textLabel?.text = localString
//            cell.detailTextLabel?.text = ""
        }
//        return cell!
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
