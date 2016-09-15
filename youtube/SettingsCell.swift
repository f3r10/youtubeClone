//
//  SettingsCell.swift
//  youtube
//
//  Created by Fernando  Ledesma on 12/8/16.
//  Copyright © 2016 scorpio. All rights reserved.
//

import UIKit


class SettingsCell: BaseCell {
    
    override var highlighted: Bool {
        didSet {
            backgroundColor = highlighted ? UIColor.darkGrayColor() : UIColor.whiteColor()
            
            nameLabel.textColor = highlighted ? UIColor.whiteColor() : UIColor.blackColor()
            
            iconImageView.tintColor = highlighted ? UIColor.whiteColor() : UIColor.darkGrayColor()
            print(highlighted)
        }
    }
    
    

    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.imageWithRenderingMode(.AlwaysTemplate)
                iconImageView.tintColor = UIColor.darkGrayColor()
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFontOfSize(13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstrainWithFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        
        addConstrainWithFormat("V:|[v0]|", views: nameLabel)
        
        addConstrainWithFormat("V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
    }
}