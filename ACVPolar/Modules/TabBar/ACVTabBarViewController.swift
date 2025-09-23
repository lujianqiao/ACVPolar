//
//  ACVTabBarViewController.swift
//  ACVPolar
//  
//  Created by _.
//  Copyright © 2025/8/7 _. All rights reserved.
//

import UIKit

class ACVTabBarViewController: UITabBarController {

    lazy var customTabbar: ACVCustomTabBar = {
        let bar = ACVCustomTabBar()
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
