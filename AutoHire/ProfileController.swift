//
//  ProfileController.swift
//  AutoHire
//
//  Created by Admin on 12/9/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire



class ProfileController : UIViewController {
   
    var user : Dictionary<String,Any> = [:]
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var skillsUser: UITextView!
    @IBOutlet weak var experienceUser: UITextView!
    @IBOutlet weak var educationUser: UITextView!
    @IBOutlet weak var addressUser: UILabel!
    @IBOutlet weak var posteUser: UILabel!
    @IBOutlet weak var NameUser: UILabel!
    @IBOutlet weak var adresss: UILabel!
    @IBOutlet weak var About: UIView!
    @IBOutlet weak var phoneUser: UITextView!
    @IBOutlet weak var emailUser: UILabel!
    var id : Int?
    @IBOutlet weak var contact: UIView!
    let baseUrl = Common.Global.LOCAL + "/"
 
     var urlKey = "file:///Users/ayman/Desktop/Mini/AutoHireBack/uploads/"

   

        
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        if let url = URL(string: urlKey){
                  
                  do {
                      let data = try Data(contentsOf: url)
                      self.imageUser.image = UIImage(data: data)
                      
                  }catch let err {
                      print(" Error : \(err.localizedDescription)")
                  }
                  
                  
              }
      
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       viewLoadSetup()

    }


     func viewLoadSetup(){
        About.isHidden = false
      
       
        getData()
        imageUser.layer.cornerRadius = 50.0
        imageUser.clipsToBounds = true
       
     }
    
  
    func getData() {
        let defaults = UserDefaults.standard
        let idValue = defaults.string(forKey: "usernameUser")
        self.urlKey = urlKey+idValue!+".jpeg"
        
        let parameters: [String: Any] = [
            "username" : idValue 
        ]
        AF.request(self.baseUrl+"user/me/"  , method: .post , parameters: parameters , encoding: JSONEncoding.default ).responseJSON { response in

            self.user  = response.value as! Dictionary < String, Any >
           
      
            self.id = self.user["id"] as? Int
            self.NameUser.text = self.user["username"] as? String
            self.skillsUser.text = self.user["skills"] as? String
            
            self.addressUser.text = self.user["address"] as? String
         
            self.adresss.text = self.user["address"] as? String
            let numero = self.user["phoneNumber"] as! Int
           
            self.phoneUser.text =  String(numero)
            self.emailUser.text = self.user["email"] as? String
            self.educationUser.text = self.user["education"] as? String
            self.experienceUser.text = self.user["experience"] as? String
            
            
            if self.experienceUser.text == "experience" {
                
                self.About.isHidden = true
            }
            
        }
        
    }
    
    @IBAction func upload(_ sender: Any) {
        
        performSegue(withIdentifier: "upload", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "upload"{
    
            
            if let destinationVC =  segue.destination as? UpdateProfileController{
                
                destinationVC.Id = self.id
                
                
                
            }
        }
        
    }
    
}
