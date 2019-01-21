//
//  ViewController.swift
//  IOS Development Ideas
//
//  Created by Work on 10/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import UIKit

protocol ColoredView {
    var controllerColor: UIColor { get set }
}

class ViewController: UIViewController {
    
    // MARK: @IBOutlets
    @IBAction func handleButtonOne(_ sender: UITapGestureRecognizer) {
        scrollViewController.setController(to: controllerOne, animated: true)
    }
    @IBAction func handleButtonTwo(_ sender: UITapGestureRecognizer) {
        scrollViewController.setController(to: controllerTwo, animated: true)
    }
    @IBAction func handleButtonThree(_ sender: UITapGestureRecognizer) {
        scrollViewController.setController(to: controllerThree, animated: true)
    }
    
    var scrollViewController: ScrollViewController!
    
    let controllerOne: ControllerOne = {
        let c = ControllerOne()
        return c
    }()
    
    let controllerTwo: ControllerTwo = {
        let c = ControllerTwo()
        return c
    }()
    
    let controllerThree: ControllerThree = {
        let c = ControllerThree()
        return c
    }()
    
    @IBOutlet var navigationView: NavView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ScrollViewController {
            scrollViewController = controller
            scrollViewController.delegate = self
        }
    }
}

extension ViewController: ScrollViewControllerDelegate {
    var initialViewController: UIViewController {
        return controllerTwo
    }
    var viewControllers: [UIViewController?] {
        return [controllerOne, controllerTwo, controllerThree]
    }
    func scrollViewDidScroll() {
        //calculate percentage for animation
        let min: CGFloat = 0
        let max: CGFloat = scrollViewController.pageSize.width
        let x = scrollViewController.scrollView.contentOffset.x
        let result = ((x - min) / (max - min)) - 1
        
        var controller: UIViewController?
        
        if scrollViewController.isControllerVisible(controllerOne) {
            controller = controllerOne
        } else if scrollViewController.isControllerVisible(controllerThree) {
            controller = controllerThree
        }
        
        navigationView.animate(to: controller, percent: result)
    }
}

