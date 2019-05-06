//
//  ViewController.swift
//  LNC Coach App
//
//  Created by John Slomka on 2018-12-03.
//  Copyright © 2018 John Slomka. All rights reserved.
//

import UIKit

class volunteerController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var experiencePicker: UIPickerView!
    @IBOutlet weak var namePicker: UIPickerView!
    
    var experiences: [String] = [String]()
    var names: [String] = [String]()
    
    // VIEW LOADED
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Picker set up
        self.experiencePicker.delegate = self
        self.experiencePicker.dataSource = self
        self.namePicker.delegate = self
        self.namePicker.dataSource = self
        experiences = ["3:30 pm","5:00 pm"]
        names = ["Chris Frey", "Anne Kleinhorseman", "Michaela Manahan","Lori Martin","Brandon Martin"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == experiencePicker {
            return experiences.count
        } else {
            return names.count
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == experiencePicker {
            return experiences[row]
        } else {
            return names[row]
        }
    }
    
    // Tells the view controller what to send when a segue happens
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // If the segue is to questionController
        if segue.destination is questionController
        {
            let vc = segue.destination as? questionController
            vc?.experience = experiences[experiencePicker.selectedRow(inComponent: 0)]
            vc?.name = names[namePicker.selectedRow(inComponent: 0)]
        }
    }
    
    // Begin Button Pressed
    @IBAction func beginPressed(_ sender: Any) {
    }
}

