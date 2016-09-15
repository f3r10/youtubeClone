//
//  TrendingCell.swift
//  youtube
//
//  Created by Fernando  Ledesma on 13/8/16.
//  Copyright © 2016 scorpio. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        Api.sharedInstance.fetchTrendingFeed { (videos : [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
