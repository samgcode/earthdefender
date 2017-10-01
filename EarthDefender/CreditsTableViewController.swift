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
        
        setupColors()

        self.title = "Credits and Info"
        
        let section1: [String: [String]] = ["Header": ["Music"], "Data": ["K100 - Riot"]]
        let section2: [String: [String]] = ["Header": ["Support"], "Data": ["Tap to send an email"]]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! SocialMediaTableViewCell
        
        cell.backgroundColor = UIColor.lightGray
        cell.InformationLabel?.textColor = UIColor.yellow
        cell.InformationLabel?.font = UIFont(name: "AmericanTypewriter", size: 20)
        
        cell.InformationSubTitleLable?.textColor = UIColor.yellow
        cell.InformationSubTitleLable?.font = UIFont(name: "AmericanTypewriter", size: 14)
        cell.InformationSubTitleLable?.text = ""
        
        if let row: [String: [String]] = tableData[indexPath.section] as? [String : [String]] {
            cell.InformationLabel?.text = "\(row["Data"]![indexPath.row])"
        }
        
        cell.LeftImageButton?.setTitle("", for: UIControlState.normal)
        cell.CenterImageButton?.setTitle("", for: UIControlState.normal)
        cell.RightImageButton?.setTitle("", for: UIControlState.normal)
        
        if(indexPath.section == 0 && indexPath.row == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.InformationSubTitleLable?.text = "View social details ->"
            
            cell.LeftImageButton?.setBackgroundImage(UIImage(named: "FacebookIcon"), for: UIControlState.normal)
            cell.LeftImageButton?.addTarget(self, action: #selector(self.k100FaceBookTapped), for: UIControlEvents.touchUpInside)
            
            cell.CenterImageButton?.setBackgroundImage(UIImage(named: "TwitterIcon"), for: UIControlState.normal)
            cell.CenterImageButton?.addTarget(self, action: #selector(self.k100TwitterTapped), for: UIControlEvents.touchUpInside)
            
            cell.RightImageButton?.setBackgroundImage(UIImage(named: "YoutubeIcon"), for: UIControlState.normal)
            cell.RightImageButton?.addTarget(self, action: #selector(self.k100YouTubeTapped), for: UIControlEvents.touchUpInside)
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
        if(indexPath.section == 1 && indexPath.row == 0) {
            if(canSendMail()){
                let mailController = MFMailComposeViewController()
                mailController.setToRecipients(["support@deangaudet.com"])
                mailController.setSubject("Support Request")
                mailController.mailComposeDelegate = self
                
                self.navigationController?.present(mailController, animated: true, completion: {})
            }
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont(name: "AmericanTypewriter", size: 18)
        header?.textLabel?.textColor = UIColor.blue
        header?.backgroundView?.backgroundColor = UIColor.green
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
    
    func setupColors(){
        self.tableView.backgroundColor = nil
        self.tableView.backgroundColor = UIColor.black
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        let attrs = [
            NSForegroundColorAttributeName: UIColor.red,
            NSFontAttributeName: UIFont(name: "AmericanTypewriter", size: 24)!
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attrs
    }
    
    func k100YouTubeTapped(sender: UIButton!){
        print("You tube tapped")
    }
    
    func k100FaceBookTapped(sender: UIButton!){
        print("facebook tapped")
    }
    
    func k100TwitterTapped(sender: UIButton!){
        print("twitter tapped")
    }
}
