//
//  MenuCell.swift
//  youtube
//
//  Created by Fernando  Ledesma on 13/8/16.
//  Copyright © 2016 scorpio. All rights reserved.
//

import UIKit


class MenuCell : BaseCell {
    
    let imageView : UIImageView = {
        
        let imageView = UIImageView()
        return imageView
        
    }()
    
    override var highlighted: Bool {
        didSet{
            imageView.tintColor = highlighted ? UIColor.whiteColor() : UIColor.rgb(91, green: 14, blue: 13)
        }
    }
    
    override var selected: Bool{
        didSet{
            imageView.tintColor = selected ? UIColor.whiteColor() : UIColor.rgb(91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        addConstrainWithFormat("H:[v0(28)]", views: imageView)
        addConstrainWithFormat("V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterY ,relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
        
    }
}