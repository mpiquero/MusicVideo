//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by MPiquero on 3/14/16.
//  Copyright © 2016 MPiquero. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
        preferredFontChanged()
        
    }
    
    func preferredFontChanged() {
        print("font changed")
    }
    
    func didLoadData(videos: [Videos]) {
        self.videos = videos
        print(reachabilityStatus)
        for (index,item) in videos.enumerate() {
            print("\(index + 1): \(item.vName)")
        }
        
        tableView.reloadData()
    }
    
    func reachabilityStatusChanged(){
        switch reachabilityStatus {
        case NOACCESS :
            //move back to the main queue
            dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default){ action -> () in print("Cancel")}
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive){ action -> () in print("Delete")}
            let okAction = UIAlertAction(title: "OK", style: .Default){ action -> () in print("OK")
                
                //do something if you want
                //alert.dismissViewControllerAnimated(true, completion: nil)
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            }
        default:
            if videos.count == 0 {
                runApi()
            } else {
                print("Do not run the API")
                }
            }
        }
    
    // this is called just as the object is about to be deallocated
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "preferredFontChanged", object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    private struct storyboard {
        static let cellReuseableIdentifier = "cell"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseableIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func runApi() {
        //call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
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
