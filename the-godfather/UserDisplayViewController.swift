//
//  UserDisplayViewController.swift
//  the-godfather
//
//  Created by Marvin Allan Lu on 7/21/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import UIKit

class UserDisplayViewController: UIViewController {

    @IBOutlet var profilePicture: UIImageView!
    
    @IBOutlet var fullNameNick: UILabel!
    @IBOutlet var age: UILabel!
    @IBOutlet var fatherFullName: UILabel!
    @IBOutlet var motherFullName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.userInView
        
        self.fullNameNick?.text = user!.fullNameNick()
        self.age?.text = user!.ageDisplay()
        self.motherFullName?.text = user!.motherFullName()
        self.fatherFullName?.text = user!.fatherFullName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
