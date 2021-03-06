//
//  Api.swift
//  youtube
//
//  Created by Fernando  Ledesma on 13/8/16.
//  Copyright © 2016 scorpio. All rights reserved.
//

import UIKit

class Api: NSObject {
    
    static let sharedInstance = Api()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(urlString: String, completion: ([Video]) -> ()) {
        let url = NSURL(string: urlString)
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                
                var videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                      video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    videos.append(video)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    completion(videos)
                })
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            
            }.resume()
    }

}
