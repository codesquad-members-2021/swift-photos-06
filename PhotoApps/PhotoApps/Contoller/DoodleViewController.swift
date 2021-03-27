//
//  DoodleViewController.swift
//  PhotoApps
//
//  Created by jinseo park on 3/24/21.
//

import UIKit

class DoodleViewController : UIViewController{
    
    private let imgManager = ImageManager(jsonTitle: "doodle")
    private let cellSize = CGSize(width: 110, height: 50)
    private let cellID = "imgCell"
    private var cellImage: UIImage?

    lazy private var doodlesCollectionView : UICollectionView = {
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

        view.addSubview(doodlesCollectionView)
        doodlesCollectionView.backgroundColor = .gray
        
        /*Delegate 설정*/
        doodlesCollectionView.delegate = self
        doodlesCollectionView.dataSource = self
        
        doodlesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        doodlesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        doodlesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        doodlesCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0).isActive = true
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didImageDownloadDone(_:)),
                                               name: ImageManager.NotiKeys.imageDownloadDone,
                                               object: imgManager)
        imgManager.startDownloadingAtBackground()
    }
    
    
    @objc func longTouchedImgViewCell(_ gesture: UILongPressGestureRecognizer) {        
        
        guard let gestureView = gesture.view else {
            return
        }
        
        let menuController = UIMenuController.shared
        
        guard !menuController.isMenuVisible, gestureView.canBecomeFirstResponder else {
            return
        }
        
        gestureView.becomeFirstResponder()
        
        let cell = gestureView as! ImgViewCell
        guard let cellImage = cell.bg.image else { return }
        self.cellImage = cellImage
        
        let save = UIMenuItem(title: "Save", action: #selector(saveImageAtCell))
        menuController.menuItems = [save]
        
        if let superView = gestureView.superview {
            menuController.showMenu(from: superView, rect: gestureView.frame)
        }
        
    }
    
    @objc func saveImageAtCell() {
        
        if let cellImage = cellImage {
            UIImageWriteToSavedPhotosAlbum(cellImage, self, #selector(imageSaveAlert(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
    }
    
    @objc func imageSaveAlert(_ image : UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer){
        if let error = error {
            let ac = UIAlertController(title: "저장 실패!", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "네", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "저장 성공!", message: "잘 하셨습니다.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "네", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    @IBAction func addTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didImageDownloadDone(_ notification: Notification) {
        if let targetIdx = notification.userInfo?["index"] as? Int {
            OperationQueue.main.addOperation {
                self.doodlesCollectionView.reloadItems(at: [IndexPath(item: targetIdx, section: 0)])
            }
        }
    }
}

extension DoodleViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
}

extension DoodleViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgManager.imageCounts()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImgViewCell
        
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(UILongPressGestureRecognizer.init(target: self, action: #selector(longTouchedImgViewCell(_:))))
        
        let image = imgManager.imageForIndex(indexPath.row)

        let renderer = UIGraphicsImageRenderer(size: cellSize)
        
        let scaledImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: cellSize))
        }

        cell.bg.image = scaledImage
        return cell
    }
}
