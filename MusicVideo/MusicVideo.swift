//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by MPiquero on 3/13/16.
//  Copyright © 2016 MPiquero. All rights reserved.
//

import Foundation

class Videos {
    //Data Encapsulation
    
    private var _vName: String
    private var _vImageUrl: String
    private var _vVideoUrl: String
    
    //Make a getter
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    init(data: JSONDictionary) {
        //Video Name
        if let name = data["im:name"] as? JSONDictionary, vName = name["label"] as? String {
            self._vName = vName
        }
        else {
            // you may not always get data back from the JSON  you may want to display a message
            _vName = ""
        }
        
        // the video Image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
                _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            // you may not always get data back from the JSON  you may want to display a message
            _vImageUrl = ""
        }
        
        // the video
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        } else {
            // you may not always get data back from the JSON  you may want to display a message
            _vVideoUrl = ""
        }
        
    }
}