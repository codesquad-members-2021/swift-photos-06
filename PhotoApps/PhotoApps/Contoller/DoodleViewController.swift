//
//  DoodleViewController.swift
//  PhotoApps
//
//  Created by jinseo park on 3/24/21.
//

import UIKit

class DoodleViewController : ViewController {
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        self.navigationItem.title = "Doodles"
        self.view.backgroundColor = .gray
        
      
        /*Close Btn 생성하기*/
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(addTapped))
        
    }
    
    @IBAction func addTapped(){
        dismiss(animated: true, completion: nil)
    }
    
}
