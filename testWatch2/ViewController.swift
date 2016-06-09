//
//  ViewController.swift
//  testWatch2
//
//  Created by Adriana Pineda on 5/30/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func update(sender: AnyObject) {

        var tokens: [TokenDTO] = []
        
        let token1 = TokenDTO(withName: "a", logo: "c", secretSeed: "a")
        let token2 = TokenDTO(withName: "b", logo: "d", secretSeed: "a")

        tokens.append(token1)
        tokens.append(token2)

        if #available(iOS 9.0, *) {
            WatchSessionManager.sharedManager.sendTokens(tokens)
        } else {
            // Fallback on earlier versions
        }
    }

}

