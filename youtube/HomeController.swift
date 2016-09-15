//
//  ViewController.swift
//  youtube
//
//  Created by Fernando  Ledesma on 10/8/16.
//  Copyright © 2016 scorpio. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    

    let cellId = "cellId"
    let trendingId = "trendingId"
    let subscriptionsId = "subscriptionsId"
    
    let titlesViewPager = ["Home", "Trending", "Subscriptions", "Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.translucent = false
        
        
        let titleLabel = UILabel(frame : CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        navigationItem.titleView = titleLabel
        
        setupMenuBar()
        setupCollectionView()
        
        setupNavBarButtons()
    }
    
    func setupCollectionView(){
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .Horizontal
            flowLayout.minimumLineSpacing = 0
            
        }
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.registerClass(TrendingCell.self, forCellWithReuseIdentifier: trendingId)
        collectionView?.registerClass(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionsId)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.pagingEnabled = true
    }
    
    private func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.imageWithRenderingMode(.AlwaysOriginal)
        let searchButtonItem = UIBarButtonItem(image: searchImage, style: .Plain, target: self, action: #selector(handleSearch))
        
        
        let moreImage = UIImage(named: "nav_more_icon")?.imageWithRenderingMode(.AlwaysOriginal)
        let moreButtonItem = UIBarButtonItem(image: moreImage, style: .Plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButtonItem, searchButtonItem]
    }
    
    func handleSearch(){
        scrollToMenuIndex(2)
    }
    
    func scrollToMenuIndex(menuIndex : Int) {
        let indexPath = NSIndexPath(forItem: menuIndex, inSection: 0)
        collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
        
        changeTitleMenuBar(menuIndex)
    }
    lazy var settingsLauncher : SettingsLauncher = {
        let settings = SettingsLauncher()
        settings.homeController = self
        return settings
    }()
    
    func handleMore(){
        settingsLauncher.showSettings()
    }
    
    func navigateSettingsController(setting : Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.whiteColor()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    
    
    private func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstrainWithFormat("H:|[v0]|", views: redView)
        view.addConstrainWithFormat("V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstrainWithFormat("H:|[v0]|", views: menuBar)
        view.addConstrainWithFormat("V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(getCorrespondIdOfCell(indexPath.item), forIndexPath: indexPath)
        let colors: [UIColor] = [UIColor.blueColor(), UIColor.redColor(), UIColor.grayColor(), UIColor.purpleColor()]
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    private func getCorrespondIdOfCell(index : Int) -> String {
        
        if index == 1 {
            return trendingId
        } else if index == 2 {
            return subscriptionsId
        }
        return cellId
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, view.frame.height - 50 )
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.memory.x / view.frame.width
        let indexPath = NSIndexPath(forItem: Int(index), inSection: 0)
        menuBar.collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        changeTitleMenuBar(Int(index))
        
    }
    
    func changeTitleMenuBar(index : Int){
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titlesViewPager[index])"
        }
    }
    

}



