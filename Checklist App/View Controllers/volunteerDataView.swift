
//
//  VolunteerDataView.swift
//  LNC Ministry App
//
//  Created by John Slomka on 2019-05-04.
//  Copyright © 2019 John Slomka. All rights reserved.
//

import UIKit

class volunteerDataView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var volunteer = [Volunteer]()
    var totalWeeks = [String]()
    var missedWeeks = [String]()
    var allQuestions = [String]()
    
    @IBOutlet weak var missedQuestionsView: UITableView!
    @IBOutlet weak var missedWeeksView: UITableView!
    
    
    
    @IBOutlet weak var missedWeeksLabel: UILabel!
    @IBOutlet weak var sundayAverageLabel: UILabel!
    @IBOutlet weak var monthlyAverageLabel: UILabel!
    @IBOutlet weak var titleName: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        titleName.text = volunteer[0].name
        missedQuestions()
        missedWeeksCalc()
        missedWeeksLabel.text = "Total missed weeks: \(missedWeeks.count)"
        
        let av = (sundayAverageCalc() * 100).rounded()
          sundayAverageLabel.text = "\(av)%"
        if av >= 80 {
            sundayAverageLabel.textColor = #colorLiteral(red: 0, green: 0.8154683709, blue: 0, alpha: 1)
        } else {
            sundayAverageLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        monthlyAverageLabel.text = ""
        self.missedQuestionsView.rowHeight = UITableView.automaticDimension
        self.missedQuestionsView.estimatedRowHeight = 300
        self.missedQuestionsView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var temp = allQuestions.count
        if tableView == self.missedWeeksView {
            temp = missedWeeks.count
        }
        return temp
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.missedWeeksView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "missedWeeks") as! missedWeeksCell
            cell.weekLabel.text = missedWeeks[indexPath.row]
            // NEED TO ADD REASON TO VOLUNTEER STRUCTURE
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "missedQuestions") as! missedQuestionsCell
        cell.missedQuestionText.text = allQuestions[indexPath.row]
        return cell
    }
    
    // ["question",count]?
    func missedQuestions() {
        //var count = 0
        for vol in volunteer {
            for question in vol.missedQuestions as! [Int] {
                allQuestions.append(getQuestion(for: vol.position!, number: question))
            }
        }
    }
    
    func missedWeeksCalc() {
        var vWeeks = String()
        // All of this volunteers served weeks
        for week in volunteer {
            vWeeks.append(convertDate(date: week.date!))
        }
        // Finds weeks that happened without volunteer
        for week in totalWeeks {
            if !vWeeks.contains(week) {
                missedWeeks.append(week)
            }
        }
    }
    
    func sundayAverageCalc() -> Double {
        var average = 0.0
        
        for vol in volunteer {
            average += vol.percentage
        }
        average /= Double(volunteer.count)
        
        return average
    }
    
}
