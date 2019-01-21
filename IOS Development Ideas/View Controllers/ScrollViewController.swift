//
//  ScrollViewController.swift
//  IOS Development Ideas
//
//  Created by Work on 19/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import UIKit

class ControllerOne: UIViewController, ColoredView {
    
    var controllerColor: UIColor = UIColor(red: 0.23, green: 0.66, blue: 0.96, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
}

class ControllerTwo: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
}

class ControllerThree: UIViewController, ColoredView {
    
    var controllerColor: UIColor = UIColor(red: 0.59, green: 0.23, blue: 0.96, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
}

protocol ScrollViewControllerDelegate {
    var viewControllers: [UIViewController?] { get }
    var initialViewController: UIViewController { get }
    func scrollViewDidScroll()
}

class ScrollViewController: UIViewController {
    
    var scrollView: UIScrollView {
        return view as! UIScrollView
    }
    
    var pageSize: CGSize {
        return scrollView.frame.size
    }
    
    var viewControllers: [UIViewController?]!
    var delegate: ScrollViewControllerDelegate?
    
    override func loadView() {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        view = scrollView
        view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewControllers = delegate?.viewControllers
        for (index, controller) in viewControllers.enumerated() {
            if let controller = controller {
                addChild(controller)
                controller.view.frame = frame(for: index)
                scrollView.addSubview(controller.view)
                controller.didMove(toParent: self)
            }
        }
        scrollView.contentSize = CGSize(width: pageSize.width * CGFloat(viewControllers.count), height: pageSize.height)
        if let controller = delegate?.initialViewController {
            setController(to: controller, animated: false)
        }
    }
}

fileprivate extension ScrollViewController {
    func frame(for index: Int) -> CGRect {
        return CGRect(x: CGFloat(index) * pageSize.width, y: 0, width: pageSize.width, height: pageSize.height)
    }
    func indexFor(controller: UIViewController?) -> Int? {
        return viewControllers.index(where: {$0 == controller })
    }
}

extension ScrollViewController {
    public func setController(to controller: UIViewController, animated: Bool) {
        guard let index = indexFor(controller: controller) else { return }
        let contentOffset = CGPoint(x: pageSize.width * CGFloat(index), y: 0)
        if animated {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.scrollView.setContentOffset(contentOffset, animated: false)
            }, completion: nil)
        } else {
            scrollView.setContentOffset(contentOffset, animated: animated)
        }
    }
    public func isControllerVisible(_ controller: UIViewController?) -> Bool {
        guard controller != nil else { return false }
        for i in 0..<viewControllers.count {
            if viewControllers[i] == controller {
                let controllerFrame = frame(for: i)
                return controllerFrame.intersects(scrollView.bounds)
            }
        }
        return false
    }
}

extension ScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll()
    }
}
