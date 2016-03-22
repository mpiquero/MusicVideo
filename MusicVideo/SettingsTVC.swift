//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by MPiquero on 3/16/16.
//  Copyright © 2016 MPiquero. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var feedBackDisplay: UILabel!
    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var imageQualityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    @IBOutlet weak var quantityDisplay: UILabel!
    @IBOutlet weak var sliderCount: UISlider!
    @IBOutlet weak var numberOfVideoDisplay: UILabel!
    @IBOutlet weak var dragTheSliderDisplay: UILabel!
    
    @IBAction func touchIDSec(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchID.on {
            defaults.setBool(touchID.on, forKey: "SecSetting")
        }
        else {
            defaults.setBool(false, forKey: "SecSetting")
        }
    }
    
    @IBAction func valueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCount.value), forKey: "quantityDisplay")
        quantityDisplay.text = ("\(Int(sliderCount.value))")
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        tableView.alwaysBounceVertical = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("quantityDisplay") != nil) {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("quantityDisplay") as! Int
            quantityDisplay.text = "\(theValue)"
            sliderCount.value = Float(theValue)
        } else {
            sliderCount.value = 10.0
            quantityDisplay.text = ("\(Int(sliderCount.value))")
        }
    }
    
    func preferredFontChanged() {
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        quantityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        imageQualityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        numberOfVideoDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        dragTheSliderDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated:  true, completion:  nil)
            } else
            {
                //no mail account setup on phone
                mailAlert()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func configureMail() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["mrP@hvv.rr.com"])
        mailComposeVC.setSubject("Music Video App Feedback")
        mailComposeVC.setMessageBody("Hi Manny, \n\nI would like to share the following feedback...\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailAlert() {
        
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No email Account setup for phone", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            // do something here
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue: print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue: print("Mail saved")
        case MFMailComposeResultSent.rawValue: print("Mail sent")
        case MFMailComposeResultFailed.rawValue: print("Mail failed")
        default: print("Unknown Issue")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "about" {
//            if indexPath.section == 0 && indexPath.row == 0 {
//                print("hello")
//                let dvc = segue.destinationViewController as! AboutVC
        
//            }
            
            
//        }
    }


}
