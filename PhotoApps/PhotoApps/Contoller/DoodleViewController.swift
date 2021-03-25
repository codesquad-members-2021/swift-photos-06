//
//  DoodleViewController.swift
//  PhotoApps
//
//  Created by jinseo park on 3/24/21.
//

import UIKit
let cellID = "imgCell"
class DoodleViewController : UIViewController{
    

    let imgManager = ImageManager(jsonTitle: "doodle")
    
    fileprivate let doodlesCollectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ImgViewCell.self, forCellWithReuseIdentifier: cellID)
        
        return cv
    }()
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.navigationItem.title = "Doodles"
        
        /*Close Btn 생성하기*/
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(addTapped))
        
//        self.view = view
        view.addSubview(doodlesCollectionView)
        doodlesCollectionView.backgroundColor = .gray
        
        /*Delegate 설정*/
        
        doodlesCollectionView.delegate = self
        doodlesCollectionView.dataSource = self
        
        doodlesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        doodlesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        doodlesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        doodlesCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: view.frame.height/2).isActive = true
    }
    
    @IBAction func addTapped(){
        dismiss(animated: true, completion: nil)
    }
 
    
}

extension DoodleViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
}

extension DoodleViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("imgManager.imageCounts()",imgManager.imageCounts())//103개
        return imgManager.imageCounts()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImgViewCell
        let photoIdxToShow = imgManager.imageCounts() - indexPath.row - 1 //최신 항목부터 표시
        cell.bg.image = imgManager.imageForIndex(photoIdxToShow)
        
        return cell
        
    }
    
    
}
