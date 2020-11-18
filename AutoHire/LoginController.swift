//
//  LoginController.swift
//  AutoHire
//
//  Created by ESPRIT on 11/18/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login.layer.cornerRadius=25.0
        Email.layer.cornerRadius=25.0
        Password.layer.cornerRadius=25.0
        // Do any additional setup after loading the view.
    }
    

}
