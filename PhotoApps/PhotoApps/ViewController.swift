//
//  ViewController.swift
//  PhotoApps
//
//  Created by jinseo park on 3/22/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let numberOfItems = 40
    private let cellSizeUnit: CGFloat = 80
    private var randomColorCollection = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomColorCollection = generateRandomColors(count: numberOfItems)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func generateRandomColors(count: Int) -> [UIColor] {
        var colorCollection = [UIColor]()
        
        for _ in 0..<count {
            let newColor = UIColor.init(red: CGFloat(drand48()),
                                        green: CGFloat(drand48()),
                                        blue: CGFloat(drand48()),
                                        alpha: 1)
            colorCollection.append(newColor)
        }
        return colorCollection
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSizeUnit, height: cellSizeUnit)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        newCell.backgroundColor = randomColorCollection[indexPath.row]
        return newCell
    }
}
