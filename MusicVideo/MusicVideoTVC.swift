//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by MPiquero on 3/14/16.
//  Copyright © 2016 MPiquero. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController, UISearchResultsUpdating {

    var videos = [Videos]()
    
    var filterSearch = [Videos]()
    let resultSearchController = UISearchController(searchResultsController: nil)
    
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        title = "The iTunes Top \(limit) Music Videos"
        
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
        //print(reachabilityStatus)
        //for (index,item) in videos.enumerate() {
         //   print("\(index + 1): \(item.vName)")
        //}
        
        // setup the search controller
        resultSearchController.searchResultsUpdater = self
        
        definesPresentationContext = true
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search for Artist"
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        
        // add the searchbar to the tableview
        tableView.tableHeaderView = resultSearchController.searchBar
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
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.active {
            return filterSearch.count
        }
        return videos.count
    }

    private struct storyboard {
        static let cellReuseableIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseableIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        
        if resultSearchController.active {
            cell.video = filterSearch[indexPath.row]
        } else {
            cell.video = videos[indexPath.row]
        }
        
        
        return cell
    }
    
    
    @IBAction func refresh(sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        
        if resultSearchController.active {
            refreshControl?.attributedTitle = NSAttributedString(string: "No Refresh allowed in Search")
        } else {
        runApi()
        }
    }
    
    
    func getAPICount() {
        if (NSUserDefaults.standardUserDefaults().objectForKey("quantityDisplay") != nil) {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("quantityDisplay") as! Int
            limit = theValue
        }
        title = "The iTunes Top \(limit) Music Videos"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDte = formatter.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDte)")
    }
    
    func runApi() {
        getAPICount()
        
        //call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == storyboard.segueIdentifier {
            let video: Videos
            if let indexpath = tableView.indexPathForSelectedRow {
                
                if resultSearchController.active {
                    video = filterSearch[indexpath.row]
                } else {
                 video = videos[indexpath.row]
                }
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                dvc.videos = video
            }
           
            
        }
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text!.lowercaseString
        filterSearch(searchController.searchBar.text!)
    }

    func filterSearch(searchText: String){
        filterSearch = videos.filter { videos in
            return videos.vArtist.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }
}
