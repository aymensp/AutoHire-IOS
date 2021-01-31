

//  LoginController.swift
//  AutoHire


//  Created by ESPRIT on 11/18/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
class LoginController: UIViewController {

    
    @IBOutlet weak var loginn: UIButton!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Email: UITextField!
    var user : Dictionary<String,Any> = [:]
    let baseUrl = Common.Global.LOCAL + "/"
    var IsLoggedin : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginn.layer.cornerRadius=25.0
        Email.layer.cornerRadius=25.0
        Password.layer.cornerRadius=25.0
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        let idValue = defaults.string(forKey: "idUser")
       
        
    }
    
     
    
    
    @IBAction func login(_ sender: UIButton) {
        
        
        let userName = Email.text
        let password = Password.text
        let parameters: [String: Any] = [
            "username" : userName, 
            "password" : password
            
            
        ]
        
        
        
        AF.request(self.baseUrl+"auth/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString { response in
                             
                if response.value != nil
                {

                    
                    self.performSegue(withIdentifier: "auth", sender: self)
                          
                    let defaults = UserDefaults.standard
                    defaults.setValue(userName!, forKey: "usernameUser")
                    
                    self.IsLoggedin = true
                    let parameterss: [String: Any] = [
                        "username" : userName
                                                
                        
                    ]
                    AF.request(self.baseUrl+"user/me", method: .post, parameters: parameterss, encoding: JSONEncoding.default)
                        .responseJSON { response in
                                         
                            let statusCode = response.response?.statusCode
                          
                            
                            if statusCode == 200
                              {
                                
                                let item = response.value as! Dictionary<String,Any>
                                
                                let id = item["id"] as? Int
                                let email = item["email"] as? String
                                let defaults = UserDefaults.standard
                                defaults.setValue(id!, forKey: "idUser")
                                defaults.setValue(email!, forKey: "emailUser")
                                
                                
                              }
                              else {
                                
                                print("Username already exists")
                              }
                            }
                        
                    
                    }
                
                else {
                    
                    HUD.flash(.labeledError(title: "Error", subtitle: "Check Your Password and Username") , delay: 2.0)
                    
                    
                    
                    
                }
                    
                }
    
      
            
     
            
            
        }
        
                
                
                
    }
        
        
    

    
    
    

    
        
        
        
    
       
        
        
        
    
    
    


