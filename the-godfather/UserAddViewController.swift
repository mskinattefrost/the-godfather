//
//  UserAddViewController.swift
//  the-godfather
//
//  Created by Marvin Allan Lu on 7/27/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import UIKit

class UserAddViewController: UIViewController {
    
    var ref: Firebase?
    
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var nicknameField: UITextField!
    @IBOutlet var birthdayField: UITextField!
    @IBOutlet var fatherLastNameField: UITextField!
    @IBOutlet var fatherFirstNameField: UITextField!
    @IBOutlet var motherLastNameField: UITextField!
    @IBOutlet var motherFirstNameField: UITextField!
    @IBOutlet var doneButton: UIBarButtonItem!

    @IBAction func lastNameChanged(sender: AnyObject) {
        if blankCheck(lastNameField.text) && blankCheck(firstNameField.text){
            doneButton.enabled = true
        } else {
            doneButton.enabled = false
        }
    }

    @IBAction func firstNameChanged(sender: AnyObject) {
        if blankCheck(lastNameField.text) && blankCheck(firstNameField.text) {
            doneButton.enabled = true
        } else {
            doneButton.enabled = false
        }
    }
    
    
    @IBAction func donePressed(sender: AnyObject) {
        let user_dictionary: Dictionary<String, AnyObject>  = [
            "first_name": firstNameField.text,
            "last_name": lastNameField.text,
            "nickname": nicknameField.text,
            "birthday": birthdayField.text,
            "mother": [
                "first_name": motherFirstNameField.text,
                "last_name": motherLastNameField.text
            ],
            "father": [
                "first_name": fatherFirstNameField.text,
                "last_name": fatherLastNameField.text
            ]
        ]
        
        let newUser = ref?.childByAutoId()
        newUser!.setValue(user_dictionary)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Firebase(url: "https://the-godfather.firebaseio.com/users/")
        
        self.doneButton.enabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func blankCheck(text: String) -> Bool {
        var result = true
        
        println("\(text)")
        
        if text == "" {
            result = false
        }
        
        return result
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
