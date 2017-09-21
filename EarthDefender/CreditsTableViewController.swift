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
        let row: [String: [String]] = tableData[section] as! [String : [String]]
        if let data = row["Data"] {
            return data.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        if let row: [String: [String]] = tableData[indexPath.section] as? [String : [String]] {
            cell.textLabel?.text = "\(row["Data"]![indexPath.row])"
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let row: [String: [String]] = tableData[section] as? [String : [String]] {
            return "\(row["Header"]![0])"
        }
        return ""
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(canSendMail()){
            let mailController = MFMailComposeViewController()
            mailController.setToRecipients(["support@deangaudet.com"])
            mailController.setSubject("Support Request")
            mailController.mailComposeDelegate = self
            
            self.navigationController?.present(mailController, animated: true, completion: {})
        }
    }
    
    func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.navigationController?.dismiss(animated: true, completion: {
            if result == MFMailComposeResult.failed {
                self.showSendMailErrorAlert()
            }
        })
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        sendMailErrorAlert.addAction(alertAction)
        self.present(sendMailErrorAlert, animated: true, completion: {})
    }
}
