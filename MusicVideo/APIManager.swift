//
//  APIManager.swift
//  MusicVideo
//
//  Created by MPiquero on 3/13/16.
//  Copyright © 2016 MPiquero. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion: (result: String) -> Void) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in

                if error != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                    completion(result: (error!.localizedDescription))
                    }
                } else {
                    //added for JSONSerialization
                    //print(data)
                    do {
                        /* .AllowFragments - top level object is not Array or Dictionary
                        Any type of string or value
                        NSJSONSerialization requires the Do / try/ catch
                        converts the NSData into a JSON object and cast it to a Dictionary */
                        
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                            as? JSONDictionary {
                                
                                print(json)
                            
                                let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                    dispatch_async(dispatch_get_main_queue()) {
                                    completion(result: "JSONSerialization Successful")
                                }
                            }
                        }
                    } catch {
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(result: "error in NSJSONSerialization")
                        }
                    }
                    //end of JSONSerialization
                }
            }
        
        task.resume()
    }
}