//
//  ApplicantDetailController.swift
//  AutoHire
//
//  Created by Aymen Smati on 11/1/2021.
//  Copyright © 2021 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import MessageUI

class ApplicantDetailController : UIViewController , MFMailComposeViewControllerDelegate{
    
    var username : String?
    var user : Dictionary<String,Any> = [:]
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var skillsUser: UITextView!
    @IBOutlet weak var experienceUser: UITextView!
    @IBOutlet weak var educationUser: UITextView!
    @IBOutlet weak var addressUser: UILabel!
    @IBOutlet weak var posteUser: UILabel!
    @IBOutlet weak var NameUser: UILabel!
   
    @IBOutlet weak var About: UIView!
    let baseUrl = Common.Global.LOCAL + "/"
    var id : Int?
    var email : String?
    var numero : Int?
 
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
       
   
       
        getData()
        
       
     }
    
    @IBAction func callApp(_ sender: Any) {
        
    
        guard let number = URL(string: "tel://" + String(self.numero!)) else { return }

            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        

    }
    
    @IBAction func emailApp(_ sender: Any) {
        let recipientEmail = self.email!
                    let subject = "Multi client email support"
                    let body = "This code supports sending email via multiple different email apps on iOS! :)"
         
                    // Show default mail composer
                    if MFMailComposeViewController.canSendMail() {
                        let mail = MFMailComposeViewController()
                        mail.mailComposeDelegate = self
                        mail.setToRecipients([recipientEmail])
                        mail.setSubject(subject)
                        mail.setMessageBody(body, isHTML: false)
         
                        present(mail, animated: true)
         
                    // Show third party email composer if default Mail app is not present
                    } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
                        UIApplication.shared.open(emailUrl)
                    }
    }
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
               let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
               let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    
               let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
               let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
               let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
               let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
               let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
    
               if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
                   return gmailUrl
               } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
                   return outlookUrl
               } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
                   return yahooMail
               } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
                   return sparkUrl
               }
    
               return defaultUrl
           }
    internal func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       switch result {
       case .cancelled:
           print("Mail cancelled")
       case .saved:
           print("Mail saved")
       case .sent:
           print("Mail sent")
       case .failed:
           print("Mail sent failure")
       default:
           break
       }
       self.dismiss(animated: true, completion: nil)
        
   }
    func getData() {
        let defaults = UserDefaults.standard
        let idValue = defaults.string(forKey: "usernameUser")
        self.urlKey = urlKey+idValue!+".jpeg"
        
        let parameters: [String: Any] = [
            "username" : self.username!
        ]
        AF.request(self.baseUrl+"user/me/"  , method: .post , parameters: parameters , encoding: JSONEncoding.default ).responseJSON { response in

            self.user  = response.value as! Dictionary < String, Any >
           
      
            self.id = self.user["id"] as? Int
            self.NameUser.text = self.user["username"] as? String
            self.skillsUser.text = self.user["skills"] as? String
            
            self.addressUser.text = self.user["address"] as? String
          
           
            self.numero = self.user["phoneNumber"] as! Int
            self.email = self.user["email"] as? String
            
           
            self.educationUser.text = self.user["education"] as? String
            self.experienceUser.text = self.user["experience"] as? String
            
            
            if self.experienceUser.text == "experience" {
                
                self.About.isHidden = true
            }
            
        }
        
    }
    
  
        
    }


