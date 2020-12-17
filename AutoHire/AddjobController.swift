//
//  AddjobController.swift
//  AutoHire
//
//  Created by imen manai on 12/4/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
class AddjobController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var userValue : String?
    
    @IBOutlet weak var TITLE: UITextField!
    
    @IBOutlet weak var TYPEE: UITextField!
    @IBOutlet weak var DESCRIPTION: UITextField!
   
    @IBOutlet weak var titleError: UILabel!
    @IBOutlet weak var SALARY: UITextField!
    @IBOutlet weak var TYPE: UIPickerView!
    
    @IBOutlet weak var descriptionError: UILabel!
    @IBOutlet weak var salaryError: UILabel!
    @IBOutlet weak var functionError: UILabel!
    @IBOutlet weak var locationError: UILabel!
    @IBOutlet weak var companyError: UILabel!
    @IBOutlet weak var LOCATION: UITextField!
    @IBOutlet weak var COMPANY: UITextField!
    
    var JobTIME : String?

    var pickerData: [String] = [String]()
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
   

        
        self.TYPE.delegate = self
               self.TYPE.dataSource = self
               
               // Input the data into the array
        pickerData = ["Full-Time", "Part-Time", "Contract", " Temporary", "Volunteer", "Intership"]

        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func Add(_ sender: Any) {
        
        
        
        if (DESCRIPTION.text?.isEmpty == true || TITLE.text?.isEmpty == true || COMPANY.text?.isEmpty == true || LOCATION.text?.isEmpty == true || TYPEE.text?.isEmpty == true || SALARY.text?.isEmpty == true ||
           validateCompany() == false
        
        ) {
            
            print("please check your information")
            

        }
        else {
        let defaults = UserDefaults.standard
        self.userValue = defaults.string(forKey: "usernameUser")
        let TiTre = TITLE.text
        let DEscription = DESCRIPTION.text
        let POste = TYPEE.text
        let ADRESS =  LOCATION.text
        let InDustry = COMPANY.text
        let SalARy = SALARY.text
        
        let hamma = validateCompany()
        
            print(hamma)
            
       
         
        let parameters: [String: Any] = [
        "titre": TiTre,
        "description":DEscription,
        "poste": POste,
        "address": ADRESS,
        "creator" : userValue ,
        "industry": InDustry,
        "company": InDustry,
        "jobTime": JobTIME ,
        "salary": SalARy,
        "longitude" : "10.164723",
        "latitude" : "36.866537"
         ]
         
         
         AF.request("http://localhost:3000/offre/Newoffre", method: .post, parameters: parameters, encoding: JSONEncoding.default)
             .responseString { response in
                 var statusCode = response.response?.statusCode
               
                 
                 if statusCode == 201
                   {
                    self.performSegue(withIdentifier: "toDetails", sender: self)
                     
                   }
                   else {
                    
                     
                     print("Check your Information")
                    
                    
                   }
                
             }
        
        
        }
     
        
    }
    
    @IBAction func jobTitleDidChange(_ sender: UITextField) {
        guard let string = sender.text else { return }

           if (string.isEmpty   ) {
            titleError.text = "This field can't be empty "
           }
           else{
            titleError.text = ""
            TITLE.text = string           }
        
    }
    
    @IBAction func companyDidChange(_ sender: UITextField) {
        guard let string = sender.text else { return }

           if (string.isEmpty || !validateCompany() ) {
            companyError.text = "Can't add job with this company"
           }
           else{
            companyError.text = ""
            COMPANY.text = string           }
    }
    
    @IBAction func locationDidChange(_ sender: UITextField) {
        guard let string = sender.text else { return }

           if (string.isEmpty  ) {
            locationError.text = "This field can't be empty "
           }
           else{
            locationError.text = ""
            LOCATION.text = string           }
    }
    
    @IBAction func functionDidChange(_ sender: UITextField) {
        guard let string = sender.text else { return }

           if (string.isEmpty  ) {
            functionError.text = "This field can't be empty "
           }
           else{
            functionError.text = ""
            TYPEE.text = string           }
    }
    @IBAction func salaryDidChange(_ sender: UITextField) {
        guard let string = sender.text else { return }

           if (string.isEmpty  ) {
            salaryError.text = "This field can't be empty "
           }
           else{
            salaryError.text = ""
            SALARY.text = string           }
    }
    
    @IBAction func descriptionDidChange(_ sender: UITextField) {
        guard let string = sender.text else { return }

           if (string.isEmpty  ) {
            descriptionError.text = "This field can't be empty "
           }
           else{
            descriptionError.text = ""
            DESCRIPTION.text = string           }
    }
    
    public func validateCompany() -> Bool {
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "emailUser")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@"+COMPANY.text!+"+\\.[A-Za-z]{2,64}"
          let trimmedString = email!.trimmingCharacters(in: .whitespaces)
          let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          let isValidateEmail = validateEmail.evaluate(with: trimmedString)
          
          return isValidateEmail
       }
  
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           
        self.JobTIME = pickerData[row]
        return self.JobTIME
       }
    
  
    
}
