//
//  ImgViewCell.swift
//  PhotoApps
//
//  Created by jinseo park on 3/25/21.
//

import UIKit

//UICollectionViewCell도 하나의 뷰이다.

class ImgViewCell : UICollectionViewCell {
    
    let bg : UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 50))
        return iv
    }()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override init(frame : CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(bg)
        
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        /*셀에 추가하는 메소드*/
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer.init(target: self, action: #selector(longTouchedImgViewCell(_:))))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func longTouchedImgViewCell(_ gesture: UILongPressGestureRecognizer) {
        print("long touched!")
        
        guard let gestureView = gesture.view else {
            return
        }
        
        let menuController = UIMenuController.shared
        
        guard !menuController.isMenuVisible, gestureView.canBecomeFirstResponder else {
            print("can't become firstResponder \(gestureView.canBecomeFirstResponder)")
            return
        }
        
        gestureView.becomeFirstResponder()
        
        let save = UIMenuItem(title: "Save", action: #selector(saveImageAtCell))
        menuController.menuItems = [save]
        print("save: \(save)")
        print("menuItems: \(menuController.menuItems)")
        
        if let superView = gestureView.superview {
            menuController.showMenu(from: superView, rect: gestureView.frame)
            
            print("menuFrame: \(menuController.menuFrame)") //!!!
            print("gestureView.frame \(gestureView.frame)")
            
        }
        print("끝")
    }
    
    @objc func saveImageAtCell() {
        //이미지 SAVE 구현하기.
        print("버튼 눌림")
    }
    
}
//https://zeddios.tistory.com/607
