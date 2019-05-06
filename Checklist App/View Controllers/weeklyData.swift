//
//  coachTab.swift
//  LNC Coach App
//
//  Created by John Slomka on 2018-12-04.
//  Copyright © 2018 John Slomka. All rights reserved.
//

import Foundation
import UIKit



class coachDataTableController: UITableViewController{

    var data = [Volunteer]()
    var tempData = [Volunteer]()
    var date = String()
    
    @IBOutlet weak var dateHeader: UILabel!
    @IBOutlet weak var experienceSelection: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTempData()
        
        dateHeader.text = date
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "average") as! averageTableViewCell
        cell.averageLabel.text = "Test"
        
    }
    
    @IBAction func experienceChanged(_ sender: Any) {
        setTempData()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        if indexPath.row == 0 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "average") as? averageTableViewCell else {
                fatalError("Bad cell cast")
            }
            
            // Ensures label is active
            cell.averageLabel.isEnabled = true
            let av: Double = average() * 100
            // Check if 0
            if av == -100 {
                cell.averageLabel.text = "No volunteer data"
                cell.averageLabel.isEnabled = false
            } else {
            // Otherwise update label
                cell.averageLabel.text = "\(av.rounded())%"
                if av >= 80 {
                    cell.averageLabel.textColor = #colorLiteral(red: 0, green: 0.8154683709, blue: 0, alpha: 1)
                } else {
                    cell.averageLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                }
            }
            
            return cell
        } else {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "storyCell") as? coachTableViewCell else {
                fatalError("Bad cell cast")
            }
            let name = tempData[indexPath.row-1].name
            let position = tempData[indexPath.row-1].position
            let experience = tempData[indexPath.row-1].service!
            let percentage = tempData[indexPath.row-1].percentage * 100
            let questionsMissed = tempData[indexPath.row-1].missedQuestions as! [Int]
            
            cell.nameLabel.text = name
            let temp = "Achieved: \(percentage.rounded())%\nWas "
            let temp2 = (position?.lowercased())! + " at the " + experience + " experience"
            cell.volunteerView.text = temp + temp2
            var string = "Missed Questions:\n"
            for i in questionsMissed {
                string += "Question \(i + 1): " + getQuestion(for: position!, number: i) + "\n"
            }
            cell.questionsView.text = string
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempData.count + 1
    }
    
    
    func setTempData() {
        switch experienceSelection.selectedSegmentIndex {
        case 0:
            tempData = filterDataForExperience(at: "3:30 pm", from: data)
        case 1:
            tempData = filterDataForExperience(at: "5:00 pm", from: data)
        case 2:
            tempData = data
        default:
            print("Improper Service")
        }
    }
    
    func average() -> Double{
        var av: Double = 0.0
        if (tempData != []) {
            for v in tempData {
                av += v.percentage
            }
            av /= Double(tempData.count)
        } else {
            av = -1
        }
        return av
    }
    
    //        Debugging
    //        print("Data:")
    //        print(data[indexPath.row].name ?? "")
    //        print(data[indexPath.row].position ?? "")
    //        print(data[indexPath.row].service ?? "")
    //        print(data[indexPath.row].percentage)
    //        print(data[indexPath.row].missedQuestions)
}


