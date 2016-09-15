//
//  SubscriptionsCell.swift
//  youtube
//
//  Created by Fernando  Ledesma on 13/8/16.
//  Copyright © 2016 scorpio. All rights reserved.
//

import UIKit

class SubscriptionsCell: FeedCell {

    override func fetchVideos() {
        Api.sharedInstance.fetchSubscriptionFeed { (videos : [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
