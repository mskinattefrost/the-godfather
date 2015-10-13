//
//  UserEditViewController.swift
//  the-godfather
//
//  Created by Marvin Allan Lu on 7/27/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import UIKit

class UserEditViewController: UIViewController, UITextFieldDelegate {

    var ref: Firebase?
    var user: User?
    
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var nicknameField: UITextField!
    @IBOutlet var birthdayField: UITextField!
    @IBOutlet var fatherLastNameField: UITextField!
    @IBOutlet var fatherFirstNameField: UITextField!
    @IBOutlet var motherLastNameField: UITextField!
    @IBOutlet var motherFirstNameField: UITextField!
    @IBOutlet var doneButton: UIBarButtonItem!
    
    @IBAction func donePressed(sender: AnyObject) {
        var userDictionary: Dictionary<String, AnyObject> = [:]
        userDictionary["first_name"] = firstNameField.text
        userDictionary["last_name"] = lastNameField.text
        userDictionary["nickname"] = nicknameField.text
        userDictionary["birthday"] = birthdayField.text
        userDictionary["mother"] = [
            "first_name": motherFirstNameField.text!,
            "last_name": motherLastNameField.text!
        ]
        userDictionary["father"] = [
            "first_name": fatherFirstNameField.text!,
            "last_name": fatherLastNameField.text!
        ]
        
        let u = User(id: self.user!.id!, object: userDictionary)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.userInView = u
        
        
        let editUser: Void? = ref?.updateChildValues(userDictionary)
        
        var alert = UIAlertController(title: "Yay!", message: "User saved.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
        self.resignFirstResponder()

    }
    
    @IBAction func lastNameChanged(sender: AnyObject) {
        if blankCheck(lastNameField.text!) {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true
        }
    
    }

    @IBAction func firstNameChanged(sender: AnyObject) {
        
        if blankCheck(firstNameField.text!) {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.motherLastNameField.delegate = self
        self.motherFirstNameField.delegate = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.user = appDelegate.userInView
        
        self.lastNameField?.text = user?.lastName
        self.firstNameField?.text = user?.firstName
        self.nicknameField?.text = user?.nickname
        self.birthdayField?.text = user?.birthDate
        
        let mom:Dictionary<String, AnyObject>? = user?.mother
        self.motherFirstNameField?.text = mom?["first_name"] as? String
        self.motherLastNameField?.text = mom?["last_name"] as? String
        
        let dad:Dictionary<String, AnyObject>? = user?.father
        self.fatherFirstNameField?.text = dad?["first_name"] as? String
        self.fatherLastNameField?.text = dad?["last_name"] as? String
        
        self.ref = Firebase(url: "https://the-godfather.firebaseio.com/users/\(user!.id!)")
        
        let datePicker: UIDatePicker = UIDatePicker()
        
        datePicker.addTarget(self, action: "datePickerAction:", forControlEvents: .ValueChanged)
        
        self.birthdayField.inputView = datePicker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func blankCheck(text: String) -> Bool {
        var result = false
        
        if text == "" {
            result = true
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
