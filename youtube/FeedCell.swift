//
//  FeedCell.swift
//  youtube
//
//  Created by Fernando  Ledesma on 13/8/16.
//  Copyright © 2016 scorpio. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        
        collectionView.registerClass(VideoCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        addConstrainWithFormat("H:|[v0]|", views: collectionView)
        addConstrainWithFormat("V:|[v0]|", views: collectionView)

        
        
        
    }
    
    var videos : [Video]?
    
    let cellId = "cellId"
    
    func fetchVideos(){
        Api.sharedInstance.fetchVideos { (videos : [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let height = ((frame.width - 16 - 16) * 9/16) + 16 + 88
        return CGSizeMake(frame.width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
    


}
