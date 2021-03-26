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
    
    override init(frame : CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(bg)

        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enableSaveMenu() {
        let save = UIMenuItem(title: "Save", action: #selector(longTouchedImgViewCell))
        UIMenuController.shared.menuItems = [save]
    }
    
    @objc func longTouchedImgViewCell(_ gesture: UILongPressGestureRecognizer) {
        print("long touched!")
    }
    
}

//https://stackoverflow.com/questions/45243947/uilabel-long-press-gesture-for-menu-item-of-uimenucontroller
//internal func handleLongPressed(_ gesture: UILongPressGestureRecognizer) {
//        guard let gestureView = gesture.view, let superView = gestureView.superview else {
//            return
//        }
//
//        let menuController = UIMenuController.shared
//
//        guard !menuController.isMenuVisible, gestureView.canBecomeFirstResponder else {
//            return
//        }
//
//        gestureView.becomeFirstResponder()
//
//        menuController.menuItems = [
//            UIMenuItem(
//                title: "Custom Item",
//                action: #selector(handleCustomAction(_:))
//            ),
//            UIMenuItem(
//                title: "Copy",
//                action: #selector(handleCopyAction(_:))
//            )
//        ]
//
//        menuController.setTargetRect(gestureView.frame, in: superView)
//        menuController.setMenuVisible(true, animated: true)
//    }
