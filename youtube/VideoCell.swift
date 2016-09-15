//
//  VideoCell.swift
//  youtube
//
//  Created by Fernando  Ledesma on 10/8/16.
//  Copyright © 2016 scorpio. All rights reserved.
//

import UIKit


class VideoCell: BaseCell {
    
    var video : Video? {
        didSet{
            titleLabel.text = video?.title
            setupThumbnailImage()
            setupChannelProfileImage()
            
            
            if let channelName = video?.channel?.name, numberOfViews = video?.numberOfViews {
                
                let numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = .DecimalStyle
                
                let subtitleText = "\(channelName) • \(numberFormatter.stringFromNumber(numberOfViews)!) • 2 years ago "
                subtitleTextView.text = subtitleText
            }
            
            //measure title text
            if let title = video?.title {
                let size = CGSizeMake(frame.width - 16 - 44 - 8 - 16, 1000)
                let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                }else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            
                
            
        }
    }
    
    func setupChannelProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(profileImageUrl)
        }
    }
    
    func setupThumbnailImage(){
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString(thumbnailImageUrl)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named : "taylor_swift_blank_space")
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named : "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Taylor SwiftVEVO - 1,604,648,607 views - 2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGrayColor()
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        
        addConstrainWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstrainWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
        
        addConstrainWithFormat("V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView ,separatorView)
        
        addConstrainWithFormat("H:|[v0]|", views: separatorView)
        
        //top constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 4))
        
        //left constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Left , relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right , multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Left , relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right , multiplier: 1, constant: 8))
        
        
        //right constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Right , relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right , multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Right , relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right , multiplier: 1, constant: 0))
        
        //height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height , relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 20)
        addConstraint(titleLabelHeightConstraint!)
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Height , relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 30))
        
    }
    
}


