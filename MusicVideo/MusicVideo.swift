//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by MPiquero on 3/13/16.
//  Copyright © 2016 MPiquero. All rights reserved.
//

import Foundation

class Videos {
    ///Data Encapsulation
    
    private var _vName: String
    private var _vRights: String
    private var _vPrice: String
    private var _vImageUrl: String
    private var _vArtist: String
    private var _vVideoUrl: String
    private var _vImid: String
    private var _vGenre: String
    private var _vLinkToiTunes: String
    private var _vReleaseDte: String
    
    /// this variable gets from the UI
    var vImageData: NSData?
 
    ///Make a getter
    
    var vName: String {
        return _vName
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleasDte: String {
        return _vReleaseDte
    }
    
    init(data: JSONDictionary) {
        ///Video Name
        if let name = data["im:name"] as? JSONDictionary, vName = name["label"] as? String {
            self._vName = vName
        }
        else {
            // you may not always get data back from the JSON  you may want to display a message
            _vName = ""
        }
        
        ///Video rights
        if let rights = data["rights"] as? JSONDictionary, vRights = rights["label"] as? String {
            self._vRights = vRights
        }
        else {
            // you may not always get data back from the JSON  you may want to display a message
            _vRights = ""
        }
        
        ///Video Artist
        if let artist = data["im:artist"] as? JSONDictionary, vArtist = artist["label"] as? String {
            self._vArtist = vArtist
        }
        else {
            // you may not always get data back from the JSON  you may want to display a message
            _vArtist = ""
        }
        
        /// the video Image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
                _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            // you may not always get data back from the JSON  you may want to display a message
            _vImageUrl = ""
        }
        
        /// the video
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        } else {
            // you may not always get data back from the JSON  you may want to display a message
            _vVideoUrl = ""
        }
        
        ///Artist id
        if let imid = data["id"] as? JSONDictionary,
            vAtrib = imid["attributes"] as? JSONDictionary ,
            vImid = vAtrib["im:id"] as? String {
                self._vImid = vImid
        }
        else {
            // you may not always get data back from the JSON  you may want to display a message
            _vImid = ""
        }
        
        ///Video genre
        if let genre = data["category"] as? JSONDictionary,
            vAtrib = genre["attributes"] as? JSONDictionary ,
            vGenre = vAtrib["term"] as? String {
            self._vGenre = vGenre
        }
        else {
            // you may not always get data back from the JSON  you may want to display a message
            _vGenre = ""
        }
        
        ///Video price
        if let price = data["im:price"] as? JSONDictionary, vPrice = price["label"] as? String {
            self._vPrice = vPrice
        }
        else {
            // you may not always get data back from the JSON  you may want to display a message
            _vPrice = ""
        }
        
        ///Video link to itunes
        if let link = data["id"] as? JSONDictionary,
            vLinkToiTunes = link["label"] as? String {
                self._vLinkToiTunes = vLinkToiTunes
        }
        else {
            // you may not always get data back from the JSON  you may want to display a message
            _vLinkToiTunes = ""
        }
        
        ///Video release date
        if let date = data["im:releaseDate"] as? JSONDictionary,
            vAtrib = date["attributes"] as? JSONDictionary ,
            vReleasDte = vAtrib["label"] as? String {
                self._vReleaseDte = vReleasDte
        }
        else {
            // you may not always get data back from the JSON  you may want to display a message
            _vReleaseDte = ""
        }
    }
}