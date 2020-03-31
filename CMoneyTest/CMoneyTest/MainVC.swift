//
//  ViewController.swift
//  CMoneyTest
//
//  Created by ada chen on 2020/3/26.
//  Copyright © 2020 ada chen. All rights reserved.
//

import UIKit
//UINavigationControllerDelegate
class MainVC: UIViewController {
    
    var jsonTextLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = "JSON Placeholder"
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
//        lbl.sizeToFit()
        return lbl
    }()
    
    
    var requestBtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("Request API", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.clipsToBounds = true
        btn.contentMode = .center
        btn.isEnabled = false
        btn.setTitleColor(.gray, for: .disabled)
//        btn.isHidden = true
        return btn
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        downloadPhotosData()
        
        
        
//        let jsonLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.height*1/4, width: self.view.frame.width, height: 30))
        view.addSubview(jsonTextLabel)
//        jsonTextLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 1/4).isActive = true
//        jsonTextLabel.topAnchor.const
        
        jsonTextLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        jsonTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        jsonTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        jsonTextLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        
        
//        let requestBtn = UIButton(frame: CGRect(x: 0, y: self.view.frame.height*1/2, width: self.view.frame.width, height: 30))
        view.addSubview(requestBtn)
        
//        requestBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*1/2).isActive = true
        requestBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        requestBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        requestBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        requestBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        requestBtn.addTarget(self, action: #selector(toPhotosVC), for: .touchUpInside)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    

    
    var photosData:[PhotoInfo] = []{
        willSet{
            if newValue.count != 0{
                DispatchQueue.main.async {
                    self.requestBtn.isEnabled = true
                    self.requestBtn.setTitleColor(.systemBlue, for: .normal)
                    //
                }
                
            }
        }
        
    }
    
    func downloadPhotosData(){

        let urlString = "https://jsonplaceholder.typicode.com/photos"
        if let url = URL(string: urlString){
         URLSession.shared.dataTask(with: url){ data,res,err in
             if let data = data{

                 let decoder = JSONDecoder()
                 if let json = try? decoder.decode([PhotoInfo].self, from: data){

                    self.photosData = json
                    self.photosVC.photosData = self.photosData
//                    DispatchQueue.main.async {
//                        self.photosVC.collectionView.reloadData()
//                    }
                    
                    }

                 }else{
                     print("err")
                 }
            }.resume()
        
         }
    }
    

    

    
    
    
    
    let photosVC = PhotosVC()
    @objc func toPhotosVC(){
        
        self.navigationController?.pushViewController(photosVC, animated: true)
    }
    

}

