//
//  Functions.swift
//  LNC Coach App
//
//  Created by John Slomka on 2018-12-06.
//  Copyright © 2018 John Slomka. All rights reserved.
//

import Foundation
import UIKit

// 0 - Greeting
// 1 - Ushering
// 2 - Hospitality
func getPosition(for position: String) -> Int {
    var result = -1
    
    switch position {
    case "Greeting":
        result = 0
    case "Ushering":
        result = 1
    case "Hospitality":
        result = 2
    default:
        print("Position does not match cases")
    }
    
    return result
}

// Questions and getter functions
// 0 - Greeting
// 1 - Ushering
// 2 - Hospitality
 var questions: [[String]] = [
    ["Wear my host team t-shirt?","I was at my post the whole time I was serving?","Open the door for guests?","Made sure my post area was clean?","Did I follow the 10-4 rule?","Evaluate social comfort levels? “Handshake, hugs or just a hello”?","Greet people how they want to be greeted?","Refrain from eating and drinking while serving?","Put other peoples needs ahead of my own?","Think of my team members ahead of myself?","Refrain from using my cell phone while serving?","Check in with my coach after the experience for further instructions?"],
    
    ["Wear my host team t-shirt?","Greet guests asking and using their name?","Show guests to their seats using the flashlight?","Connect new guests to a staff member?","Take the offering to the host huddle area?","Put the offering in the bank bag?","Did a $20 get taken?","Count everyone in the experience room?","Sign the usher sheet?","Refrain from eating and drinking?","Put others needs ahead of my own?","Refrain from using my phone while serving?","Put my team members ahead of myself?","3:30 I filled the buckets for the 5:00 usher?"],
                              
    ["Wear my host team t-shirt?","Everything clean and looking excellent in my area?","Levels were full at all times? cream, milk, sugar. etc","I was at my post the whole time I was serving?","Greet people asking and using their name? ","Refrain from eating, drinking when serving?","Put out full carafes of Hot water & coffee before leaving my post once the message has started?","Leave milk & cream out at all times. Make sure all levels are full before leaving my post after the message has started?","Snack bins & apple bowl were full at all times?","Put other people’s needs ahead of my own?","Refrain from using my phone while serving?","Think of my team members ahead of myself?","Inventory and fill in the supplies sheet? Every other week.","Did I use the grey cart to bring out and take back water dispensers? Hot and cold."]
]

func getQuestion(for position: String, number: Int) -> String {
    return questions[ getPosition(for:position)][number]
}

func getQuestionCount(for position:String) -> Int {
    return questions[ getPosition(for: position) ].count
}

// Core Data Variables
private let appDelegate = UIApplication.shared.delegate as! AppDelegate
private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

// Return array of entries
func retrieveData() -> [Volunteer] {
    var data = [Volunteer]()
    do {
        data = try context.fetch(Volunteer.fetchRequest())
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    return data
}

func convertDate(date: NSDate) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM, d, YYYY"
    let string = dateFormatter.string(from: date as Date)
    return string
}

func filterDataForDate(date: String) -> [Volunteer] {
    let unfilteredData = retrieveData()
    var data = [Volunteer]()
    for volunteer in unfilteredData {
        if (date == convertDate(date: volunteer.date!)) {
            data.append(volunteer)
        }
    }
    return data
}

func filterDataForExperience(at experience: String, from data: [Volunteer]) -> [Volunteer] {
    var rData = [Volunteer]()
    
    for volunteer in data {
        if (experience == volunteer.service) {
            rData.append(volunteer)
        }
    }
    return rData
}

func filterDataForName(with name: String) ->[Volunteer] {
    let unfilteredData = retrieveData()
    var data = [Volunteer]()
    for volunteer in unfilteredData {
        if (name == volunteer.name) {
            data.append(volunteer)
        }
    }
    return data
}
