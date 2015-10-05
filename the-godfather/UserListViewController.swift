//
//  UserListViewController.swift
//  the-godfather
//
//  Created by Marvin Allan Lu on 7/21/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var userList: UITableView!
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref = Firebase(url: "https://the-godfather.firebaseio.com/users")
        ref.observeEventType(.Value) { snapshot in
            self.onDataReceive(snapshot)
        }
    }
    
    func onDataReceive(snapshot: FDataSnapshot) {
        self.users = [User]()
        
        
        if let vals = snapshot.value as? Dictionary<String, AnyObject> {
            for (id, values) in vals {
                let u = User(id: id, object: values as! Dictionary<String, AnyObject>)
                self.users.append(u)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.userList.reloadData()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = self.users[indexPath.row]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("user")
        let user = self.users[indexPath.row]
        
        cell!.textLabel?.text = user.reverseFullName()
        cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell!
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell {
            let indexPath = userList.indexPathForCell(cell)
            let user = self.users[indexPath!.row]
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.userInView = user
        }

    }


}
