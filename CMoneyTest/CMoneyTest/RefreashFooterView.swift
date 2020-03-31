//
//  RefreashFooterView.swift
//  CMoneyTest
//
//  Created by ada chen on 2020/3/30.
//  Copyright © 2020 ada chen. All rights reserved.
//

import UIKit


class RefreashFooterView:UICollectionReusableView{
    
    var indicatorView:UIActivityIndicatorView = {
        let idv = UIActivityIndicatorView(style: .medium)
//        let idv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        idv.translatesAutoresizingMaskIntoConstraints = false
        return idv
    }()
    
    var hintLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
        lbl.text = "loading photo data ..."
        lbl.sizeToFit()
        return lbl
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(hintLabel)
        hintLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        hintLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        hintLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
//        hintLabel.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        self.addSubview(indicatorView)
        indicatorView.rightAnchor.constraint(equalTo: hintLabel.leftAnchor, constant: 20).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: hintLabel.centerYAnchor).isActive = true
//        self.addSubview(indicatorView)
//        indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        indicatorView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        indicatorView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


