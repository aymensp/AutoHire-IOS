//
//  ViewController.swift
//  AutoHire
//
//  Created by ESPRIT on 11/17/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var login: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login.layer.cornerRadius = 25.0
        let defaults = UserDefaults.standard
        let idValue = defaults.string(forKey: "idUser")
        
        if !(idValue == nil) {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let NavViewController = storyBoard.instantiateViewController(withIdentifier: "TT") as! TabBarController
                            self.present(NavViewController, animated: true, completion: nil)
                        }
        }
 
        // Do any additional setup after loading the view.
    }
}

