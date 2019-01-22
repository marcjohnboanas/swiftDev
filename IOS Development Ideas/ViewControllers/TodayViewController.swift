//
//  TodayViewController.swift
//  IOS Development Ideas
//
//  Created by Work on 10/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import Foundation
import UIKit

class TodayViewController: UIViewController {
    let tableView = UITableView()
    private let cardViewData: [CardViewModel] = CustomData().cardTiles
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(GenericTableViewCell<CardView>.self)
        
        view.addSubview(tableView)
        tableView.pinEdgesToSuperview()
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardViewData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cardCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<CardView>
        
        let cardViewModel = cardViewData[indexPath.row]
        
        guard let cellView = cardCell.cellView else {
            
            let appView = AppView(cardViewModel.app)
            if let appViewModel = cardViewModel.app {
                appView?.configure(with: appViewModel)
            }
            let cardView = CardView(cardModel: cardViewModel, appView: appView)
            cardCell.cellView = cardView
            
            return cardCell
        }
        
        cellView.configure(with: cardViewModel)
        cardCell.clipsToBounds = false
        cardCell.contentView.clipsToBounds = false
        cardCell.cellView?.clipsToBounds = false
        
        cardCell.layer.masksToBounds = false
        cardCell.contentView.layer.masksToBounds = false
        cardCell.cellView?.layer.masksToBounds = false
        
        return cardCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cardViewModel = cardViewData[indexPath.row]
        let detailViewController = DetailViewController(cardViewModel: cardViewModel)
        
        detailViewController.transitioningDelegate = transitionManager
        detailViewController.modalPresentationStyle = .overFullScreen
        
        present(detailViewController, animated: true, completion: nil)
        
        //To wake up the UI, Apple issue with cells with selectionStyle = .none
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
    }
    
    func selectedCellCardView() -> CardView? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        
        let cell = tableView.cellForRow(at: indexPath) as! GenericTableViewCell<CardView>
        guard let cardView = cell.cellView else { return nil }
        
        return cardView
    }
}

