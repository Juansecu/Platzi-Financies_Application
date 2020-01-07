//
//  OnBoardingContainerViewController.swift
//  Financies
//
//  Created by Juan on 12/17/19.
//  Copyright © 2019 Juan. All rights reserved.
//

import UIKit

class OnBoardingContainerViewController: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignIn" {
            UserDefaults.standard.set(true, forKey: "WatchedOnboarding")
            UserDefaults.standard.synchronize()
            return
        }
        
        guard segue.identifier == "openOnBoarding", let destination = segue.destination as? OnBoardingViewController else {
            return
        }
        
        destination.pageControl = pageControl
    }
}
