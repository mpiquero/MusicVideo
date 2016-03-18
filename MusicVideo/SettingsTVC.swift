//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by MPiquero on 3/16/16.
//  Copyright © 2016 MPiquero. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    @IBOutlet weak var feedBackDisplay: UILabel!
    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var imageQualityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    @IBOutlet weak var quantityDisplay: UILabel!
    @IBOutlet weak var sliderCount: UISlider!
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
        }
        
        
    }
    
    func preferredFontChanged() {
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        quantityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        imageQualityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "about" {
            if tableView.indexPathForSelectedRow == 0 {
                print("hello")
                let dvc = segue.destinationViewController as! AboutVC
                
            }
            
            
        }
    }


}
