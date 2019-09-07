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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            numOfRows = 26
        case 1:
            numOfRows = 20
        default:
            numOfRows = 25
        }
        return numOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = "\(indexPath.row + 1)"
            let u = UnicodeScalar.init(indexPath.row + 65)
            let char = Character.init(u!)
            cell.detailTextLabel?.text = "\(char)"
            //        cell.contentView.layoutIfNeeded()
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            let num: Int = 10 - indexPath.row
            cell.textLabel?.text = "\(num)"
            cell.detailTextLabel?.text = "\(num)^2 = \(num * num)"
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            let u = UnicodeScalar.init(indexPath.row + 65)
            let char = Character.init(u!)
            var localString: String = ""
            for _ in -1..<indexPath.row {
                localString = localString + String(char)
            }
            cell.textLabel?.text = localString
            cell.detailTextLabel?.text = ""
        }
        return cell
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
