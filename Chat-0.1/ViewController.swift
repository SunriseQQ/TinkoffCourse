//
//  ViewController.swift
//  Chat-0.1
//
//  Created by Sunrise on 13.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if doYouWannaHaveLogs {
            print("ViewController visible state moved from <Appearing> to <Appeared>: \(#function)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if doYouWannaHaveLogs {
            print("ViewController visible state moved from <Disappeared> to <Appearing>: \(#function)")
        }
     }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if doYouWannaHaveLogs {
            print("View will adjust the position of its subviews: \(#function)")
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if doYouWannaHaveLogs {
            print("View adjusted the position of its subviews: \(#function)")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if doYouWannaHaveLogs {
            print("ViewController visible state moved from <Disappearing> to <Disapeared>: \(#function)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if doYouWannaHaveLogs {
            print("ViewController visible state moved from <Appeared> to <Disappearing>: \(#function)")
        }
    }
}

