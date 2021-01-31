//
//  UpdateProfileController.swift
//  AutoHire
//
//  Created by Admin on 12/10/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import PKHUD
import MobileCoreServices
class UpdateProfileController : UIViewController {
    
    
   
      
     
      
    let baseUrl = Common.Global.LOCAL + "/"
    
    
   
    @IBOutlet weak var about: UIView!
    @IBOutlet weak var browse: UIImageView!
   
    @IBOutlet weak var skills: UITextView!
    
    @IBOutlet weak var education: UITextView!
    
    @IBOutlet weak var experience: UITextView!
    @IBOutlet weak var docText: UITextView!
    var userValue : String?
    var Id : Int?
      override func viewDidLoad() {
          super.viewDidLoad()
          
          browse.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upload)))
          browse.isUserInteractionEnabled = true
        
           
        
        
        
        
          // Do any additional setup after loading the view.
      }
    

      @objc func upload(){
          
         let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
         importMenu.delegate = self
         importMenu.modalPresentationStyle = .formSheet
         self.present(importMenu, animated: true, completion: nil)
          
      }
      
      func Doc(url: String, docData: Data?, parameters: [String : String], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil, fileName: String){
       
           let headers: HTTPHeaders = [
               "Content-type": "multipart/form-data",
            
           ]
        
           
           print("Headers => \(headers)")
           
           print("Server Url => \(url)")
           
      
        
           AF.upload(multipartFormData: { (multipartFormData) in
               if let data = docData{
                   multipartFormData.append(data, withName: "upl", fileName: fileName, mimeType: "application/pdf")
               }
               
               for (key, value) in parameters {
                   multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key as String)
                print("PARAMS => \(multipartFormData)")
               }
               
           }, to: url, method: .post, headers: headers).response { resp in
            switch resp.result{
            case .failure(let error):
                HUD.flash(.labeledError(title: "Error", subtitle: "Something Goes wrong on Upload") , delay: 2.0)
            case.success( _):
            print("🥶🥶Response after upload Img: ")
                
                self.getData()
            }
          
           }
       }

    
    func getData() {
        
        
        let defaults = UserDefaults.standard
        self.userValue = defaults.string(forKey: "usernameUser")
       
     
        
        AF.request(self.baseUrl+"user/Info/"+userValue! , method: .get ).responseJSON { response in
            
            
            
            var statusCode = response.response?.statusCode
            if statusCode == 404 {
                
                print("Error have been ")
                
                
            }
            
            else{
             
              
          
            let item = response.value as! Dictionary<String,String>
                
                
                self.skills.text = item["skills"]
                self.education.text = item["education"]
            self.experience.text = item["experience"]
                
            
            }
            
            
            
            
        }
        
        
        
    }
    
    @IBAction func save(_ sender: Any) {
        setData()
    }
    
  
    
    func setData () {
        
        
        let parameters: [String: Any] = [
            
            "id" : self.Id ,
            "education" :  education.text  ,
            "skills" : skills.text   ,
            "experience" : experience.text
        ]
        
     
        
        AF.request(self.baseUrl+"user/edit/information" , method: .post , parameters: parameters, encoding: JSONEncoding.default ).responseJSON {
            response in
            let statusCode = response.response?.statusCode
           
            if statusCode == 404 {
                
                HUD.flash(.labeledError(title: "Error", subtitle: "Check your Fields") , delay: 2.0)
                
            }
            
            else if statusCode == 409{
          
                HUD.flash(.labeledError(title: "Error", subtitle: "Check your Fields") , delay: 2.0)
            
            }
            else{
                HUD.flash(.success , delay: 1.0)
            }
            
            
        }
    }
}



  @IBDesignable
  class CardView: UIView {
      
      @IBInspectable var CornerRadiusCard: CGFloat = 5
      @IBInspectable var shadowOffsetWidth: Int = 0
      @IBInspectable var shadowOffsetHeight: Int = 3
      @IBInspectable var shadowColor: UIColor? = UIColor.black
      @IBInspectable var shadowOpacity: Float = 0.9
      
      override func layoutSubviews() {
          layer.cornerRadius = CornerRadiusCard
          let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: CornerRadiusCard)
          layer.masksToBounds = false
          //layer.borderColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0).cgColor
          //layer.borderWidth = 1
          layer.shadowColor = shadowColor?.cgColor
          layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
          layer.shadowOpacity = shadowOpacity
          layer.shadowPath = shadowPath.cgPath
      }
      
      func RoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
          let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          self.layer.mask = mask
      }
      
      
  }


extension UpdateProfileController: UIDocumentMenuDelegate,UIDocumentPickerDelegate{
      public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
          guard let myURL = urls.first else {
              return
          }
          print("import result : \(myURL)")
          let data = NSData(contentsOf: myURL)
          do{
             
            let defaults = UserDefaults.standard
            self.userValue = defaults.string(forKey: "usernameUser")
         
            
              
            self.Doc(url: self.baseUrl+"parseCV", docData: try Data(contentsOf: myURL), parameters: ["username": self.userValue! ], fileName: self.userValue!+".pdf")
              self.docText.text = myURL.lastPathComponent
              
              //uploadActionDocument(documentURLs: myURL, pdfName: myURL.lastPathComponent)
          }catch{
              print(error)
          }
          
          
          
      }


      public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
          documentPicker.delegate = self
          present(documentPicker, animated: true, completion: nil)
      }


      func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
          print("view was cancelled")
          
          
         // dismiss(animated: true, completion: nil)
          
      
    
}
}

