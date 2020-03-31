//
//  PhotosVC.swift
//  CMoneyTest
//
//  Created by ada chen on 2020/3/26.
//  Copyright © 2020 ada chen. All rights reserved.
//

import UIKit


struct PhotoInfo: Codable {
    let albumID, id: Int
    let thumbnailURL: String
    let title: String
    let url: String
    var thumbnailImg:UIImage?
    
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id
        case thumbnailURL = "thumbnailUrl"
        case title, url
    }
}


class PhotosVC:UIViewController{
    
    let collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.footerReferenceSize = CGSize(width: .zero, height:100)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.register(RefreashFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerView")
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PhotosCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    
    var photosData:[PhotoInfo] = []
    var refreashFooterView : RefreashFooterView?
    var footerView = RefreashFooterView()
    
    
    func downloadThumbnailImg(){
        
        
        if let footerView = refreashFooterView{
            let refreash = footerView.indicatorView
            if refreash.isAnimating == false{
                refreash.startAnimating()
                self.totalItem += 1
                
                
                
                print("downloadPhotos")
                let downloadGroup = DispatchGroup()
                for info in self.photosData[0..<self.totalItem*40]{
                    
                    if info.thumbnailImg != nil{
                        continue
                    }
                    
                    downloadGroup.enter()
                    DispatchQueue(label: "downloadThumbnailImg").async(group:downloadGroup) {
                        if let imgUrl = URL(string: info.thumbnailURL){
                            let img = try? UIImage(withContentsOfUrl: imgUrl)
                            self.photosData[info.id-1].thumbnailImg = img
                            if self.photosData.filter({$0.thumbnailImg != nil}).count % 10 == 0{
                                DispatchQueue.main.async {
                                    self.collectionView.reloadData()
                                }
                            }
                            downloadGroup.leave()
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                downloadGroup.notify(queue: .global()) {
                    DispatchQueue.main.async {
                        print(self.photosData.filter({$0.thumbnailImg != nil}).count,"main")
                        self.collectionView.reloadData()
                        refreash.stopAnimating()
                    }
                }
            }
        }
    }
    
    var thumbnailImgData = [Int:UIImage?]()
    var totalItem = 0
    
    override func viewDidLoad() {
        
        //        view.backgroundColor = .blue
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        super.viewDidAppear(animated)
        
        if footerView.indicatorView.isAnimating{
            footerView.indicatorView.stopAnimating()
        }
        //        }
        if photosData.filter({$0.thumbnailImg != nil}).count == 0{
            downloadThumbnailImg()
            
        }
        
        
    }
    
}




extension UIImage {
    convenience init?(withContentsOfUrl url:URL) throws {
        let imgData = try Data(contentsOf: url)
        self.init(data:imgData)
    }
    
}

extension PhotosVC:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.width/4)
        //        return CGSize(width: 150, height: 150)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! PhotosCell
        //        print(photosData[indexPath.row].id)
        let photoDetailVC = PhotoDetailVC()
        //
        if let id = selectedCell.idLabel.text{
            photoDetailVC.idText = id
            
        }
        if let title = selectedCell.titleLabel.text{
            photoDetailVC.titleText = title
            
        }
        if let  url = URL(string:photosData[indexPath.row].url){
            photoDetailVC.fullImageView.image = try? UIImage(withContentsOfUrl: url)
        }
        
        
        
        self.navigationController?.pushViewController(photoDetailVC, animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return photosData.count
        return photosData.filter({$0.thumbnailImg != nil}).count
        //        return numberOfItems
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter{
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerView", for: indexPath) as! RefreashFooterView
            refreashFooterView = footerView
            
            if photosData.filter({$0.thumbnailImg != nil}).count != 0{
                refreashFooterView?.hintLabel.text = "Pull up to load new photo data ..."
            }
            
            
            
            
            return footerView
        }
        fatalError()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotosCell
        
        guard photosData.count > indexPath.row else {
            
            return cell
        }
        
        
        let id = photosData[indexPath.row].id
        let title = photosData[indexPath.row].title
        
        cell.idLabel.text = String(id)
        cell.titleLabel.text = title
        
        
        if let img = photosData[indexPath.row].thumbnailImg{
            cell.isloding = false
            cell.thumbnailImageView.image = img
        }else{
            cell.isloding = true
        }
        
        
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let targetContentOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.frame.height
        
        if contentOffsetY >= targetContentOffsetY+100{
            downloadThumbnailImg()
            
        }
        
    }
    
    
}


