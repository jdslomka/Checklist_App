//
//  questionViewController.swift
//  LNC Coach App
//
//  Created by John Slomka on 2018-12-05.
//  Copyright © 2018 John Slomka. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class questionController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Connections
    @IBOutlet weak var positionPicker: UIPickerView!
    @IBOutlet weak var qTextBox: UITextView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // 0 - Greeting
    // 1 - Ushering
    // 2 - Hospitality
    var positions: [String] = [String]()
    var experience: String = ""
    var name: String = ""
    var position = "Greeting"
    var yesCount: Int = 0
    var noCount: Int = 0
    var qCount: Int = 0
    var missedQuestions: [Int] = [Int]()
    
    // Core Data Variables
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.positionPicker.delegate = self
        self.positionPicker.dataSource = self
        positions = ["Greeting","Ushering", "Hospitality"]
        qTextBox.text = questions[0][0]
        qTextBox.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    // PICKER FUNCTIONS
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return positions.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return positions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        position = positions[row]
        let positionInt = getPosition(for: position)
        // Reset counts when new position is selected
        qCount = 0
        noCount = 0
        yesCount = 0
        // Update Progress Bar
        updateProgress()
        // Update qtextBox
        if positionInt != -1 {
            qTextBox.text = questions[positionInt][qCount]
        }
        
    }
    
    
    // BUTTONS
    // No button pressed
    @IBAction func noPressed(_ sender: Any) {
        let questionsLen = getQuestionCount(for: position);
        
        if noCount < questionsLen {
            noCount += 1
        }
        missedQuestions.append(qCount)
        qCount += 1
        if qCount < questionsLen {
            qTextBox.text = getQuestion(for: position, number: qCount)
            updateProgress()
        } else {
            updateProgress()
            showDisplayBox()
        }
    }
    // Yes Button Pressed
   @IBAction func yesPressed(_ sender: Any) {
        let questionsLen = getQuestionCount(for: position)
        qCount += 1
        if qCount < questionsLen {
            qTextBox.text = getQuestion(for: position, number: qCount)
            updateProgress()
        } else {
            updateProgress()
            showDisplayBox()
        }
    }
    // Update Progress Bar
    private func updateProgress() {
        let progress: Float = Float(qCount) / Float(getQuestionCount(for: position) + 1)
        progressBar.progress = progress
    }
    
    // Private Functions
    
    private func showDisplayBox() {
        // Variables
        let when = DispatchTime.now() + 4.5
        let numOfQuestions = questions[getPosition(for: position)].count
        let yesCount = numOfQuestions - noCount
        var percentage: Double = Double(yesCount) / Double(numOfQuestions)
        
        // Saves Volunteer Object
        let volunteer = Volunteer(entity: Volunteer.entity(), insertInto: context)
        // Set values
        volunteer.name = name
        volunteer.date = NSDate()
        volunteer.service = experience
        volunteer.percentage = percentage
        volunteer.position = position
        volunteer.missedQuestions = missedQuestions as NSObject
        appDelegate.saveContext()
        
        // Round
        percentage = (percentage*100).rounded()
        
        // Launches Alert Box based on percentage achieved
        if percentage >= 80 {
            
            // Formatted Strings
            let attributedStringColor = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.8154683709, blue: 0, alpha: 1)];
            let goodAlert = NSAttributedString(string: "Acheived \(percentage)%", attributes: attributedStringColor)
            
            // Output
            let alertController = UIAlertController(title: "", message:
                "Thank you for upholding our best practices!", preferredStyle: UIAlertController.Style.alert)
            alertController.setValue(goodAlert, forKey: "attributedTitle")
            self.present(alertController, animated: true, completion: nil)
            
            // Close after delay
            DispatchQueue.main.asyncAfter(deadline: when) {
                alertController.dismiss(animated: true, completion: nil)
            }
        } else {
            // Formatted Strings
            let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor.red];
            let badAlert = NSAttributedString(string: "Acheived \(percentage)%", attributes: attributedStringColor)
            
            // Output
            let alertController = UIAlertController(title: "", message:
                "Remember that excellence honours God and inspires people!", preferredStyle: UIAlertController.Style.alert)
            alertController.setValue(badAlert, forKey: "attributedTitle")
            self.present(alertController, animated: true, completion: nil)
            
            // Close after delay
            DispatchQueue.main.asyncAfter(deadline: when){
                alertController.dismiss(animated: true, completion: nil)
            }
        }
        
        // Holds here until display box is gone
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.8) {
                self.performSegue(withIdentifier: "unwindToRoot", sender: self)
            }
    }
    
    
    
}



