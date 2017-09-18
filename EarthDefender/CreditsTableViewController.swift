//
//  CreditsTableViewController.swift
//  EarthDefender
//
//  Created by Dean on 2017-09-17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit
import MessageUI

class CreditsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    private var tableData: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Credits and Info"
        
        let section1: [String: [String]] = ["Header": ["Music"], "Data": ["K100 - Riot", "http://facebook.com/k100music"]]
        let section2: [String: [String]] = ["Header": ["Support"], "Data": ["Click to email"]]
        self.tableData = [section1, section2]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let row: [String: [String]] = tableData[section] as! [String : [String]]
        return row["Data"]!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let row: [String: [String]] = tableData[indexPath.section] as! [String : [String]]
        cell.textLabel?.text = "\(row["Data"]![indexPath.row])"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       let row: [String: [String]] = tableData[section] as! [String : [String]]
        return "\(row["Header"]![0])"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(canSendMail()){
            let mailController = MFMailComposeViewController()
            //mailController.delegate = self
            mailController.setToRecipients(["support@deangaudet.com"])
            mailController.setSubject("Support Request")
            
            self.navigationController?.present(mailController, animated: true, completion: {})
        }
    }
    
    func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.navigationController?.dismiss(animated: true, completion: {})
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
