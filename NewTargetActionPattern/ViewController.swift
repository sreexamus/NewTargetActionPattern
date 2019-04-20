//
//  ViewController.swift
//  NewTargetActionPattern
//
//  Created by Iragam Reddy, Sreekanth Reddy on 3/31/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var newBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
     
        newBtn.setAction(ControlAction.touchUpInside { _ in
            print("Insde touchupinside")
            }
        )
        
        newBtn.setAction(      ControlAction.touchUpInside { _ in
                   print("touch up inside")
            } + ControlAction.touchDown({ _ in
                print("touch down")
            }))
        
  
    }
    


}

