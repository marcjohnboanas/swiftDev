//
//  LoginController.swift
//  IOS Development Ideas
//
//  Created by Work on 10/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import UIKit

let cellReuseIdentifier: String = "cell"
let loginCellReuseIdentifier: String = "login"

protocol LoginControllerDelegate: class {
    func finishLoggingIn()
}

class LoginController: UIViewController {
    
    //MARK: Properties
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor.themeColor
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return cv
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor.themeColor, for: .normal)
        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor.themeColor, for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()
    
    //MARK: Action Methods
    
    @objc fileprivate func skip() {
        pageControl.currentPage = pages.count - 1
        nextPage()
    }
    
    @objc fileprivate func nextPage() {
        
        //are we on the last page?
        if pageControl.currentPage == pages.count {
            return
        }
        
        //second last page?
        if pageControl.currentPage == pages.count - 1 {
            moveControlConstraintsOffScreen()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        //let nextItemIndex = Int((collectionView.contentOffset.x / view.frame.width) + 1)
        let nextItemIndex = pageControl.currentPage + 1
        let nextPageIndexPath = IndexPath(item: nextItemIndex, section: 0)
        collectionView.scrollToItem(at: nextPageIndexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotifications()
        
        setupCollectionView()
        setupCollectionViewLayout()
        setupPageControl()
        setupNavigationButtons()
    }
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -200 : -100
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc fileprivate func keyboardHidden() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    fileprivate func setupNavigationButtons() {
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        skipButton.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0), size: CGSize(width: 80, height: 50))
        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        skipButtonTopAnchor?.isActive = true
        
        nextButton.anchor(top: nil, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0), size: CGSize(width: 80, height: 50))
        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        nextButtonTopAnchor?.isActive = true
    }
    
    fileprivate func setupPageControl() {
        view.addSubview(pageControl)
        pageControl.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 40))
        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        pageControlBottomAnchor?.isActive = true
    }
    
    fileprivate func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(BaseCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellReuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
    }
    
    let pages: [Page] = {
        let firstPage = Page(title: "Welcome to After School Clubs.", message: "Find fun activities and clubs for children and families to enjoy.", imageName: "cell_image")
        let secondPage = Page(title: "Search around you.", message: "Using your current location we can show you the best clubs and activities local to you.", imageName: "cell_image")
        let thirdPage = Page(title: "Filter search results.", message: "Filter by type, distance, cost", imageName: "cell_image")
        return [firstPage, secondPage, thirdPage]
    }()
    
    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}

//MARK: UICollectioViewDelegate / Datasource Methods

extension LoginController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellReuseIdentifier, for: indexPath) as! LoginCell
            loginCell.delegate = self
            return loginCell
        } else {
            let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! BaseCell
            let page = pages[indexPath.item]
            pageCell.page = page
            return pageCell
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
    }
    
    //MARK: UIScrollViewDelegate Methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentPageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = currentPageNumber
        
        if currentPageNumber == pages.count {
            moveControlConstraintsOffScreen()
        } else {
            self.pageControlBottomAnchor?.constant = 0
            self.nextButtonTopAnchor?.constant = 0
            self.skipButtonTopAnchor?.constant = 0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func moveControlConstraintsOffScreen() {
        self.pageControlBottomAnchor?.constant = 40
        self.nextButtonTopAnchor?.constant = -66
        self.skipButtonTopAnchor?.constant = -66
    }
}

//MARK: UICollectionViewDelegateFlowLayout Methods

extension LoginController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension UIColor {
    static let themeColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
}

extension LoginController: LoginControllerDelegate {

    func finishLoggingIn() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        mainNavigationController.viewControllers = [HomeController()]
        
        UserDefaults.standard.setIsLoggedIn(value: true)
        
        dismiss(animated: true) {}
    }
}
