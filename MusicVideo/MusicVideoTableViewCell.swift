//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by MPiquero on 3/15/16.
//  Copyright © 2016 MPiquero. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video: Videos? {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicTtitle: UILabel!
    @IBOutlet weak var rank: UILabel!
    
    func updateCell() {
        musicTtitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        rank.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        musicTtitle.text = video!.vName
        rank.text = ("\(video!.vRank)")
       // musicImage.image = UIImage(named: "sorry-image-not-available")
        
        if video!.vImageData != nil {
            musicImage.image = UIImage(data: video!.vImageData!)
        } else {
            GetVideoImage(video!, imageView: musicImage)
        }
        
        
    }
    
    func GetVideoImage(video: Videos, imageView : UIImageView) {
        //background thread
        // Dispatch_queue_priority_high Items dispatched to the queue will run at high priority, i.e., the queue will be scheduled for dispatch before any default priority or low priority queue.
        //
        // dispatch_queue_priority_default Items dispatched to the queue will run at the default priority, i.e., the queue will be scheduled for execution after all high priority queues have been scheduled, but before any low priority queues have been scheduled.
        //
        // Dispatch_queue_prioity_low
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            
            var image: UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            //move back to main queue
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    }
}
