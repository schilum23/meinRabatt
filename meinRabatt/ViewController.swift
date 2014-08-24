//
//  ViewController.swift
//  meinRabatt
//
//  Created by Oliver Rosner on 24.08.14.
//  Copyright (c) 2014 Schilum23. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image:UIImage = UIImage(named: "meinRabatt")
        let imageView:UIImageView = UIImageView(image: image)
        self.navigationItem.titleView = imageView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

