//
//  UserAddViewController.swift
//  the-godfather
//
//  Created by Marvin Allan Lu on 7/27/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import UIKit

class UserAddViewController: UIViewController, UITextFieldDelegate {
    
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
        if blankCheck(lastNameField.text!) && blankCheck(firstNameField.text!){
            doneButton.enabled = true
        } else {
            doneButton.enabled = false
        }
    }

    @IBAction func firstNameChanged(sender: AnyObject) {
        if blankCheck(lastNameField.text!) && blankCheck(firstNameField.text!) {
            doneButton.enabled = true
        } else {
            doneButton.enabled = false
        }
    }
    
    
    @IBAction func donePressed(sender: AnyObject) {
        var user_dictionary: Dictionary<String, AnyObject> = [:]
        user_dictionary["first_name"] = firstNameField.text
        user_dictionary["last_name"] = lastNameField.text
        user_dictionary["nickname"] = nicknameField.text
        user_dictionary["birthday"] = birthdayField.text
        user_dictionary["mother"] = [
            "first_name": motherFirstNameField.text!,
            "last_name": motherLastNameField.text!
        ]
        user_dictionary["father"] = [
            "first_name": fatherFirstNameField.text!,
            "last_name": fatherLastNameField.text!
        ]
        
        let newUser = ref?.childByAutoId()
        newUser!.setValue(user_dictionary)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.motherLastNameField.delegate = self
        self.motherFirstNameField.delegate = self
        
        self.ref = Firebase(url: "https://the-godfather.firebaseio.com/users/")
        
        self.doneButton.enabled = false
        // Do any additional setup after loading the view.
        
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.addTarget(self, action: "datePickerAction:", forControlEvents: .ValueChanged)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        self.birthdayField.text = dateFormatter.stringFromDate(NSDate())
        self.birthdayField.inputView = datePicker

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func blankCheck(text: String) -> Bool {
        var result = true
        
        if text == "" {
            result = false
        }
        
        return result
    }
    
    func datePickerAction(sender: AnyObject) {
        if let picker = sender as? UIDatePicker {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            self.birthdayField.text = dateFormatter.stringFromDate(picker.date)

        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for textField in view.subviews {
            if textField.becomeFirstResponder() {
                textField.resignFirstResponder()
            }
        }

    }
    
    func textFieldDidBeginEditing(textField: UITextField) { // became first responder
        //move textfields up
        let myScreenRect: CGRect = UIScreen.mainScreen().bounds
        let keyboardHeight : CGFloat = 240
        
        UIView.beginAnimations( "animateView", context: nil)
        var needToMove: CGFloat = 0
        
        var frame : CGRect = self.view.frame
        if (textField.frame.origin.y + textField.frame.size.height + /*self.navigationController.navigationBar.frame.size.height + */UIApplication.sharedApplication().statusBarFrame.size.height > (myScreenRect.size.height - keyboardHeight)) {
            needToMove = (textField.frame.origin.y + textField.frame.size.height + /*self.navigationController.navigationBar.frame.size.height +*/ UIApplication.sharedApplication().statusBarFrame.size.height) - (myScreenRect.size.height - keyboardHeight);
        }
        
        frame.origin.y = -needToMove
        self.view.frame = frame
        UIView.commitAnimations()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //move textfields back down
        UIView.beginAnimations( "animateView", context: nil)
        var frame : CGRect = self.view.frame
        frame.origin.y = 0
        self.view.frame = frame
        UIView.commitAnimations()
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
