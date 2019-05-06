//
//  coachViewController.swift
//  LNC Ministry App
//
//  Created by John Slomka on 2019-05-03.
//  Copyright © 2019 John Slomka. All rights reserved.
//

import UIKit

class coachViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = [Volunteer]()
    var date = String()
    var name = String()
    var volunteer = String()
    var month = String()
    var dates = [String]()
    var volunteers = [String]()
    var monthly = [String]()
    
    // TableView Indexing
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "smallCell") as! hubTableViewCell
        if (!weeklyButton.isEnabled) {
            date = dates[indexPath.row]
            cell.dateLabel.text = date
        } else if (!volunteerStats.isEnabled) {
            volunteer = volunteers[indexPath.row]
            cell.dateLabel.text = volunteer
        } else {
            month = monthly[indexPath.row]
            cell.dateLabel.text = month
        }
        return cell
    }
    
    // TableView # of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (!weeklyButton.isEnabled) {
            return dates.count
        } else if (!volunteerStats.isEnabled) {
            return volunteers.count
        } else {
            return monthly.count
        }
    }
    
   
    // Cell that is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        date = convertDate(date: data[indexPath.row].date!)
        if (!weeklyButton.isEnabled) {
             performSegue(withIdentifier: "showWeeklyStats", sender: self)
        } else if (!volunteerStats.isEnabled) {
            name = data[indexPath.row].name!
            performSegue(withIdentifier: "showVolunteerStats", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        data = retrieveData()
        oneOfEachWeek()
        oneOfEachVolunteer()
        oneOfEachMonth()
        self.tableView.reloadData()
    }
    
    // BUTTONS
    @IBOutlet weak var buttonHeader: UILabel!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var volunteerStats: UIButton!
    @IBOutlet weak var monthlyStats: UIButton!
    
    
    @IBAction func weeklyStatsPressed(_ sender: Any) {
        // Enabled States
        weeklyButton.isEnabled = false
        volunteerStats.isEnabled = true
        monthlyStats.isEnabled = true
        buttonHeader.text = "Weekly Stats"
        self.tableView.reloadData()
        
    }
    
    @IBAction func volunteerStatsPressed(_ sender: Any) {
        // Enabled States
        weeklyButton.isEnabled = true
        volunteerStats.isEnabled = false
        monthlyStats.isEnabled = true
        buttonHeader.text = "Volunteer Stats"
        self.tableView.reloadData()
        
    }
    
    @IBAction func monthlyStatsPressed(_ sender: Any) {
        // Enabled States
        weeklyButton.isEnabled = true
        volunteerStats.isEnabled = true
        monthlyStats.isEnabled = false
        buttonHeader.text = "Monthly Stats"
        self.tableView.reloadData()
        
    }
    
    

    // Segue preperation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // If the segue is to questionController
        if segue.destination is coachDataTableController
        {
            let vc = segue.destination as? coachDataTableController
//            print("Date before segue: \(date)")
            vc?.data = filterDataForDate(date: date)
            vc?.date = date
        }
        if segue.destination is volunteerDataView
        {
            let vc = segue.destination as? volunteerDataView
            vc?.volunteer = filterDataForName(with: name)
            vc?.totalWeeks = dates
        }
    }
    
    
    // Functions
    
    // Find one of each week
    private func oneOfEachWeek() {
        for volunteer in data {
            let date = convertDate(date: volunteer.date!)
            if !(dates.contains(date)) {
                dates.append(date)
            }
        }
    }
    
    // Find one of each volunteer
    private func oneOfEachVolunteer() {
        for volunteer in data {
            let name = volunteer.name!
            if !(volunteers.contains(name)) {
                volunteers.append(name)
            }
        }
    }
    
    // Find one of each month
    private func oneOfEachMonth() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM YYYY"
        for volunteer in data {
            let month = dateFormatter.string(from: volunteer.date! as Date)
            if !(monthly.contains(month)) {
                monthly.append(month)
            }
        }
    }
    
    
}
