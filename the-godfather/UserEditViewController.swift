//
//  UserEditViewController.swift
//  the-godfather
//
//  Created by Marvin Allan Lu on 7/27/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import UIKit

class UserEditViewController: UIViewController {

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
                "first_name": fatherFirstNameField.text!,
                "last_name": fatherLastNameField.text!
            ]
        ]
        
        let u = User(id: self.user!.id!, object: user_dictionary)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.userInView = u
        
        
        let editUser: Void? = ref?.updateChildValues(user_dictionary)
        
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
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.user = appDelegate.userInView
        
        self.lastNameField?.text = user?.lastName
        self.firstNameField?.text = user?.firstName
        self.nicknameField?.text = user?.nickname
        self.birthdayField?.text = user?.birthDate
        
        let mom:Dictionary<String, AnyObject>? = user?.mother
        self.motherFirstNameField?.text = mom?["first_name"] as! String
        self.motherLastNameField?.text = mom?["last_name"] as! String
        
        let dad:Dictionary<String, AnyObject>? = user?.father
        self.fatherFirstNameField?.text = dad?["first_name"] as! String
        self.fatherLastNameField?.text = dad?["last_name"] as! String
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
