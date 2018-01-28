//
//  ViewController.swift
//  CustomSEgmentedControl
//
//  Created by Leela Prasad on 18/01/18.
//  Copyright © 2018 Leela Prasad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {

    
    
  //  @IBOutlet weak var segmentedControl: CustomSegmentedContrl!
    
    
    private var pageController: UIPageViewController!
    private var arrVC:[UIViewController] = []
    private var currentPage: Int!
    
    
    
    /// Instantiate ViewControllers Here With Lazy Keyword
    
    // MARK: Order ViewController
    lazy var vc1: VC1 = {
        
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "VC1") as! VC1
        //self.addViewControllerAsChildViewController(childViewController: viewController)
        
        return viewController
    }()
    
    // MARK: MARKET ViewController
    
    lazy var vc2: VC2 = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "VC2") as! VC2
        //self.addViewControllerAsChildViewController(childViewController: viewController)
        
        return viewController
    }()
    
    // MARK: GRAPH ViewController
    
    lazy var vc3: VC3 = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "VC3") as! VC3
        //self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ssss()
        currentPage = 0
        createPageViewController()
        
        arrVC.append(vc1)
        arrVC.append(vc2)
        arrVC.append(vc3)
        

    }
    
    var segmentedControl: CustomSegmentedContrl!
    
    func ssss() {
        segmentedControl = CustomSegmentedContrl.init(frame: CGRect.init(x: 0, y: 25, width: self.view.frame.width, height: 45))
//        segmentedControl
        
        segmentedControl.backgroundColor = .white
        segmentedControl.commaSeperatedButtonTitles = "first, two, three"
        segmentedControl.addTarget(self, action: #selector(onChangeOfSegment(_:)), for: .valueChanged)
        
        self.view.addSubview(segmentedControl)
        
        
        
        
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        segmentedControl.selectedSegmentIndex = 2
//    }
    
    
    //MARK: - CreatePagination
    
    private func createPageViewController() {
        
        pageController = UIPageViewController.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
        
        pageController.view.backgroundColor = UIColor.clear
        pageController.delegate = self
        pageController.dataSource = self
        
        for svScroll in pageController.view.subviews as! [UIScrollView] {
            svScroll.delegate = self
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.pageController.view.frame = CGRect(x: 0, y: self.segmentedControl.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
        }
        
       // arrVC = [vc1, vc2, vc3]
        
        pageController.setViewControllers([vc1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        self.addChildViewController(pageController)
        self.view.addSubview(pageController.view)
        pageController.didMove(toParentViewController: self)
    }
    
    
    private func indexofviewController(viewCOntroller: UIViewController) -> Int {
        if(arrVC .contains(viewCOntroller)) {
            return arrVC.index(of: viewCOntroller)!
        }
        
        return -1
    }
    
    
    //MARK: - Pagination Delegate Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index - 1
        }
        
        if(index < 0) {
            return nil
        }
        else {
            return arrVC[index]
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index + 1
        }
        
        if(index >= arrVC.count) {
            return nil
        }
        else {
            return arrVC[index]
        }
        
    }
    
    func pageViewController(_ pageViewController1: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if(completed) {
            currentPage = arrVC.index(of: (pageViewController1.viewControllers?.last)!)
           // self.segmentedControl.selectedSegmentIndex = currentPage
            
            self.segmentedControl.updateSegmentedControlSegs(index: currentPage)
            
        }

    }
    
    
    /*
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        
        addChildViewController(childViewController)
        
        view.addSubview(childViewController.view)
        childViewController.view.frame = CGRect.init(x: 0, y: 120, width: self.view.frame.width, height: self.view.frame.height)
        
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        childViewController.didMove(toParentViewController: self)
        
    }
    
    private func removeViewControllerAsChildViewController(childViewController: UIViewController) {
        
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        
        childViewController.removeFromParentViewController()
        
    }
    
    */

    @objc func onChangeOfSegment(_ sender: CustomSegmentedContrl) {
        
        
        switch sender.selectedSegmentIndex {
        case 0:
            pageController.setViewControllers([arrVC[0]], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
            currentPage = 0
            
        case 1:
            if currentPage > 1{
                pageController.setViewControllers([arrVC[1]], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
                currentPage = 1
            }else{
                pageController.setViewControllers([arrVC[1]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
                currentPage = 1
                
            }
        case 2:
            if currentPage < 2 {
                pageController.setViewControllers([arrVC[2]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
                currentPage = 2
                
                
            }else{
                pageController.setViewControllers([arrVC[2]], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
                currentPage = 2
                
            }
        default:
            break
        }
        
        
    }
    
    
    
    
    
    

}

