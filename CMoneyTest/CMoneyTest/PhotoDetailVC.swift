//
//  PhotoDetailVCViewController.swift
//  CMoneyTest
//
//  Created by ada chen on 2020/3/30.
//  Copyright © 2020 ada chen. All rights reserved.
//

import UIKit

class PhotoDetailVC: UIViewController {
    let fullImageView:UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
//        iv.backgroundColor = .blue
        return iv
    }()
    
    
    let idLabel:UILabel = {
       let lbl = UILabel()
        lbl.text = "id"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
        return lbl
        }()
    
    
    var idText:String = ""{
        willSet{
            idLabel.text = "id : \(newValue)"
        }
    }
    
    var titleText:String = ""{
           willSet{
               titleLabel.text = "title : \(newValue)"
           }
       }
    
    
    let titleLabel:UILabel = {
       let lbl = UILabel()
        lbl.text = "title"
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.clipsToBounds = true
        return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(fullImageView)
        
        
        
//        var yAnchor = fullImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
//        if let navbar = self.navigationController?.navigationBar.bottomAnchor{
//            yAnchor = fullImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
//        }
        fullImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        fullImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fullImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fullImageView.heightAnchor.constraint(equalTo: fullImageView.widthAnchor, multiplier: 1).isActive = true
        view.addSubview(idLabel)
        idLabel.topAnchor.constraint(equalTo: fullImageView.bottomAnchor,constant: 50).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let navBar = self.navigationController?.navigationBar{
//
//            fullImageView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
//            fullImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//            fullImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//            fullImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
//
//        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
