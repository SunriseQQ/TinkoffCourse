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
            print(#function)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if doYouWannaHaveLogs {
            print(#function)
        }
     }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if doYouWannaHaveLogs {
            print(#function)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if doYouWannaHaveLogs {
            print(#function)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if doYouWannaHaveLogs {
            print(#function)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if doYouWannaHaveLogs {
            print(#function)
        }
    }
}

