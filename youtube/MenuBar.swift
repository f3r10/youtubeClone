//
//  MenuBar.swift
//  youtube
//
//  Created by Fernando  Ledesma on 11/8/16.
//  Copyright © 2016 scorpio. All rights reserved.
//

import UIKit


class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    
    var homeController : HomeController?
    
    let imagesNames = ["home", "account", "subscriptions", "trending" ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMenu()
        setupHorizontalFrame()
    }
    
    var horizontalBarLeftAnchorConstraint : NSLayoutConstraint?
    
    func setupHorizontalFrame() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        //x position
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraintEqualToAnchor(self.leftAnchor)
        horizontalBarLeftAnchorConstraint!.active = true
        
        //y position
        horizontalBarView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        
        //widht
        horizontalBarView.widthAnchor.constraintEqualToAnchor(self.widthAnchor, multiplier: 1/4).active = true
        
        //height
        horizontalBarView.heightAnchor.constraintEqualToConstant(4).active = true
        
        
        
        
    }
    
    func setUpMenu() {
        
        collectionView.registerClass(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstrainWithFormat("H:|[v0]|", views: collectionView)
        addConstrainWithFormat("V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = NSIndexPath(forItem: 0, inSection: 0)
        collectionView.selectItemAtIndexPath(selectedIndexPath, animated: false, scrollPosition: .None)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! MenuCell
        
        cell.imageView.image = UIImage(named : imagesNames[indexPath.item])?.imageWithRenderingMode(.AlwaysTemplate)
        cell.tintColor = UIColor.rgb(91, green: 14, blue: 13)
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(frame.width / 4, frame.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0 
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let x = CGFloat(indexPath.item) * frame.width / 4
        horizontalBarLeftAnchorConstraint?.constant = x
        
//        UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { 
//            self.layoutIfNeeded()
//            }, completion: nil)
        
        
        homeController!.scrollToMenuIndex(indexPath.item)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


