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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

