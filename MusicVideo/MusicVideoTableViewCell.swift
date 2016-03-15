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
        musicTtitle.text = video!.vName
        rank.text = ("\(video!.vRank)")
        musicImage.image = UIImage(named: "sorry-image-not-available")
    }
}
