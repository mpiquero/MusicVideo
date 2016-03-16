//
//  ViewController.swift
//  MusicVideo
//
//  Created by MPiquero on 3/6/16.
//  Copyright © 2016 MPiquero. All rights reserved.
// Part - 17

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  tableView.dataSource = self
      //  tableView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        //call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didLoadData(videos: [Videos]) {
        self.videos = videos
        print(reachabilityStatus)
        for (index,item) in videos.enumerate() {
            print("\(index + 1): \(item.vName)")
        }
        
      //  tableView.reloadData()
    }
    
    func reachabilityStatusChanged(){
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.redColor()
      //      displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
     //   displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
     //   displayLabel.text = "Reachable with Cellular"
        default : return
        }
    }
    
    // this is called just as the object is about to be deallocated
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        //cell.imageView?.image = video.vImageData
        
        return cell
    }

}

