//
//  ViewController.swift
//  youtube
//
//  Created by Fernando  Ledesma on 10/8/16.
//  Copyright © 2016 scorpio. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home "
        
        navigationController?.navigationBar.translucent = false
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        let titleLabel = UILabel(frame : CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        navigationItem.titleView = titleLabel
        
        
        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let height = ((view.frame.width - 16 - 16) * 9/16) + 16 + 68
        return CGSizeMake(view.frame.width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

}



