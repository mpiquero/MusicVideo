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
        
        reachabilityStatusChanged()
        
        //call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
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
        case NOACCESS : view.backgroundColor = UIColor.redColor()
        //displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
       // displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
        //displayLabel.text = "Reachable with Cellular"
        default : return
        }
    }
    
    // this is called just as the object is about to be deallocated
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
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

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        
        
        return cell
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
