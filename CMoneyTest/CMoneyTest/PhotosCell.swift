//
//  PhotosCell.swift
//  CMoneyTest
//
//  Created by ada chen on 2020/3/30.
//  Copyright © 2020 ada chen. All rights reserved.
//

import UIKit

class PhotosCell : UICollectionViewCell{
    
    
    
    let thumbnailImageView:UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
//        iv.backgroundColor = .yellow
        return iv
    }()
    
    var isloding:Bool = false{
        willSet{
            if newValue{
                indicatorView.startAnimating()
            }else{
                indicatorView.stopAnimating()
            }
        }
        
    }
    
    
    
    var indicatorView:UIActivityIndicatorView = {
        let idv = UIActivityIndicatorView(style: .large)
        idv.translatesAutoresizingMaskIntoConstraints = false
        return idv
    }()
        
    
    
    let idLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
        lbl.textAlignment = .center
        lbl.sizeToFit()
        
        lbl.text = "id"
        return lbl
    }()
    
    
    let titleLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
        lbl.text = "title"
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
//        lbl.lineBreakMode =
        return lbl
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentView.addSubview(indicatorView)
        indicatorView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        indicatorView.widthAnchor.constraint(equalTo: indicatorView.heightAnchor, multiplier: 1).isActive = true
        
        indicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(idLabel)
        
        idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        idLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor,constant: -10).isActive = true

        
        
        contentView.addSubview(titleLabel)
        
        titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 6.5/15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
