//
//  ConfirmerController.swift
//  AutoHire
//
//  Created by imen manai on 12/2/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire

class ConfirmerController : UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate

{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    let baseUrl = Common.Global.LOCAL + "/"
    @IBOutlet weak var updloadImage: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var user : String?
    var somedateString : String?
    let imagePicker = UIImagePickerController()

    override  func  viewDidLoad() {
        super.viewDidLoad()
        
        
        
             let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapGesture1))
        updloadImage.addGestureRecognizer(tap1)
        updloadImage.isUserInteractionEnabled = true
        imagePicker.delegate = self
   
    
        
    }
 
    @objc func tapGesture1() {
        
        let sheet = UIAlertController(title: "Ajouter une photo", message: "Choisssez votre source", preferredStyle: .actionSheet)
        
        let actionSheetLibrary = UIAlertAction(title: "Photo library", style: .default) { (UIAlertAction) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let actionSheetCamera = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let actionSheetCancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        sheet.addAction(actionSheetLibrary)
        sheet.addAction(actionSheetCamera)
        sheet.addAction(actionSheetCancel)
        self.present(sheet, animated: true, completion: nil)
        
    }
    
    
    var picker_image : UIImage? {
        didSet {
            guard let image = picker_image else { return }
            self.profilePicture.image = image
          
            
        }
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.picker_image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.picker_image = originalImage
            
        }
       
        picker.dismiss(animated: true, completion: nil)
        
    }
 

    @IBAction func datePickerChanged(_ sender: UIDatePicker ) {
        
        
      

        let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MMM dd, YYYY"
        self.somedateString = dateFormatter.string(from: sender.date)
        print(self.somedateString)
         
    }
    @IBAction func confirm(_ sender: Any) {
    
    
    
  
        let userName = username.text
        let Password = password.text
        let Email = email.text
        let addressee = address.text
        let Phone = phone.text
    
        let parameters: [String: Any] = [
            "username" : userName,
            "password" : Password,
            "role" : "user",
            "address" : addressee,
            "picture" : "test" ,
            "email" : Email,
            "birthDate" : self.somedateString,
            
            "phoneNumber" : Phone,
            "resume" : "null",
            "skills" : "skills" ,
            "experience" : "experience" ,
            "education" : "education"
        ]
        
        
        
        AF.request(self.baseUrl+"user/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString { response in
               
                print(response.value)

                var statusCode = response.response?.statusCode
              
                
                if statusCode == 201
                  {
                   self.performSegue(withIdentifier: "toLogin", sender: self)
                    
                  }
                  else {
                    
                    print("Username already exists")
                  }
                    
                }
        let imageData = self.picker_image!.jpegData(compressionQuality: 0.5)
        print(imageData!)
        let parameterss: [String:AnyObject] = [
        "name" : userName as AnyObject
     ]
        let headers: HTTPHeaders = [
                    "Content-type": "multipart/form-data",
                  
                ]
        
        AF.upload(multipartFormData: { (MultipartFormData) in
            if let DATA = imageData {
                MultipartFormData.append(DATA, withName: "file", fileName:  userName! + ".jpeg" , mimeType: "application/jpeg"  )
                
                for (key , value) in parameterss {
                    
                    MultipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)! , withName: key)
                    
                }
              

        }
          
        },  to:self.baseUrl+"uploadImage", method: .post, headers: headers).response { resp in
          
                     
            switch resp.result{
            case .failure(let error):
            print(error)
            case.success( _):
            print("🥶🥶Response after upload Img: ")
            }
        }
                
                
        
        
    }
    
    

    
        
     
        
        
    
  
        
}
