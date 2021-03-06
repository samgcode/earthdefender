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
    
    let font = ThemeService.getfont()
    
    private var tableData: NSMutableArray = []
    private var socialMediaIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    private var iconsIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    private var mailIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupColors()

        self.title = "Credits and Info"
        
        socialMediaIndexPath = IndexPath(row: 0, section: 0)
        iconsIndexPath = IndexPath(row: 0, section: 1)
        mailIndexPath = IndexPath(row: 0, section: 2)
        let section1: [String: [String]] = ["Header": ["Music"], "Data": ["K100 - Riot"]]
        let section2: [String: [String]] = ["Header": ["Icons"], "Data": ["Icons8 - Social Media Icons"]]
        let section3: [String: [String]] = ["Header": ["Support"], "Data": ["Tap to contact support"]]
        let section4: [String: [String]] = ["Header": ["Version"], "Data": [DeviceService.applicationVersion()]]
        self.tableData = [section1, section2, section3, section4]
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
        cell.InformationLabel?.font = UIFont(name: font, size: 20)
        
        cell.InformationSubTitleLable?.textColor = UIColor.yellow
        cell.InformationSubTitleLable?.font = UIFont(name: font, size: 13)
        cell.InformationSubTitleLable?.text = ""
        
        if let row: [String: [String]] = tableData[indexPath.section] as? [String : [String]] {
            cell.InformationLabel?.text = "\(row["Data"]![indexPath.row])"
        }
        
        cell.LeftImageButton?.setTitle("", for: UIControlState.normal)
        cell.CenterImageButton?.setTitle("", for: UIControlState.normal)
        cell.RightImageButton?.setTitle("", for: UIControlState.normal)
        
        if(indexPath.section == socialMediaIndexPath.section && indexPath.row == socialMediaIndexPath.row) {
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.InformationSubTitleLable?.text = "View social media details->"
            
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
        if(indexPath.section == iconsIndexPath.section && indexPath.row == iconsIndexPath.row) {
            let url = URL(string: "https://icons8.com")
            loadUrl(url: url!)
        }
        if(indexPath.section == mailIndexPath.section && indexPath.row == mailIndexPath.row) {
            if(canSendMail()){
                let mailController = MFMailComposeViewController()
                mailController.setToRecipients(["support@planet-defender.com"])
                mailController.setSubject("Support Request")
                mailController.setMessageBody("\n\n\n\n\n\n\nEmail generated from App Version:\(DeviceService.applicationVersion())", isHTML: false)
                mailController.mailComposeDelegate = self
                
                self.navigationController?.present(mailController, animated: true, completion: {})
            }
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont(name: font, size: 18)
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
            NSFontAttributeName: UIFont(name: font, size: 24)!
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attrs
    }
    
    func k100YouTubeTapped(sender: UIButton!){
        let url = URL(string: "http://youtube.com/watch?v=4ZHTb5RxQZo")
        loadUrl(url: url!)
    }
    
    func k100FaceBookTapped(sender: UIButton!){
        let url = URL(string: "http://fb.royaltrax.com")
        loadUrl(url: url!)
    }
    
    func k100TwitterTapped(sender: UIButton!){
        let url = URL(string: "http://twitter.royaltrax.com")
        loadUrl(url: url!)
    }
    
    func loadUrl(url: URL){
        let applicationName = DeviceService.applicationName()
        if(UIApplication.shared.canOpenURL(url)){
            let alert = UIAlertController.init(title: "Load page", message: "Do you want to leave \(applicationName) and load this page in browser?", preferredStyle: UIAlertControllerStyle.alert)
            let defaultAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default) { action in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            
            let cancelAction = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { action in }
            alert.addAction(defaultAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: {})
        }
    }
}
