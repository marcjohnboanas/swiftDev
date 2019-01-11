//
//  StretchyCollectionHeaderController.swift
//  IOS Development Ideas
//
//  Created by Work on 10/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import UIKit

fileprivate var cellReuseIdentifier = "cell"
fileprivate var headerReuseIdentifier = "header"
fileprivate var padding: CGFloat = 16

class StretchyCollectionHeaderController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        setupCollectionViewLayout()
    }
    
    fileprivate func collectionViewSetup() {
        collectionView.backgroundColor = .white
        
        //Ignores the notch at the top of the screen
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
    }
    
    fileprivate func setupCollectionViewLayout() {
        //customize collectionview layout
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    //MARK: UICollectioViewDelegate Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
    
    //MARK: HeaderView
    
    var headerView: HeaderView?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! HeaderView
        self.headerView = header
        return header
    }
    
    //MARK: UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width - 2 * padding
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = view.frame.width
        let height: CGFloat = 300
        return CGSize(width: width, height: height)
    }
    
    //MARK: UIScrollViewDelegate Methods
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let headerView = headerView {
            let contentOffsetY = scrollView.contentOffset.y
            
            if contentOffsetY > 0 {
                headerView.animator.fractionComplete = 0
                return
            }
            
            headerView.animator.fractionComplete = abs(contentOffsetY) / 150
        }
    }
}
