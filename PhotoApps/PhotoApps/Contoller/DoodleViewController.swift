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
        doodlesCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0).isActive = true
    }
    
    @IBAction func addTapped(){
        dismiss(animated: true, completion: nil)
    }
 
    
}

extension DoodleViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 110, height: 50)
    }
}

extension DoodleViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgManager.imageCounts()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImgViewCell
        cell.bg.image = imgManager.imageForIndex(indexPath.row)
        cell.backgroundColor = .red
        
        return cell
        
    }
    
    
}
