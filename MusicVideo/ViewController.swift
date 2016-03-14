//
//  ViewController.swift
//  MusicVideo
//
//  Created by MPiquero on 3/6/16.
//  Copyright © 2016 MPiquero. All rights reserved.
// Part - 6

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didLoadData(videos: [Videos]) {
        for (index,item) in videos.enumerate() {
            print("\(index + 1): \(item.vName)")
        }
    }
    

}

