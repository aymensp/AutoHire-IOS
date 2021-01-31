//
//  ManageJobController.swift
//  AutoHire
//
//  Created by Aymen Smati on 10/1/2021.
//  Copyright © 2021 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
class ManageJobController : UIViewController {
    
    var id : String?
    var salary : Int?
    var titre  : String?
    var type  : String?
    var Description  : String?
    var jobtime  : String?
    var industry  : String?
    var address  : String?
    var poste  : String?
    var datee : String?
    
    var offre : Dictionary<String,Any> = [:]
    var users : NSArray = []
  
    @IBOutlet var imageee: UIImageView!
    @IBOutlet weak var FUnction: UILabel!
    @IBOutlet weak var SALary: UILabel!
    @IBOutlet weak var INdustry: UILabel!
    @IBOutlet weak var EMployment: UILabel!
    @IBOutlet var TItre: UILabel!
    @IBOutlet weak var DEscription: UITextView!
    @IBOutlet weak var DATe: UILabel!
    @IBOutlet weak var addressss: UILabel!
    @IBOutlet var viewApp: UIButton!
    @IBOutlet var applicants: UILabel!
    @IBOutlet var COmpany: UILabel!
    
    let baseUrl = Common.Global.LOCAL + "/"

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        getData()
     
     
        
        
        DEscription.text = Description
        COmpany.text = industry
        addressss.text = address
        TItre.text = titre
        EMployment.text = jobtime
        FUnction.text = poste
        INdustry.text = industry
        SALary.text = String(salary!)
        imageee.image = UIImage(named: industry!)
        let lastDate = String(datee!.prefix(10))
        let startDate = Date()
       

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        if let endDate = formatter.date(from: lastDate) {
            let components = Calendar.current.dateComponents([.day], from: endDate, to: startDate)
            DATe.text = "Posted \(components.day!) days ago"
        } else {
            print("\(lastDate) can't be converted to a Date")
        }
    }
    
    
    @IBAction func toto(_ sender: Any) {

        
        let movie = String(id!)
        print(movie)
        performSegue(withIdentifier: "toApplicants", sender: movie  )
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toApplicants" {
            
            let param = sender as! String
        if let destinationVC =  segue.destination as? ApplicantsController {
            
            destinationVC.id = param
            
        }
        }
        
    }
    
    func getData(){
       
        AF.request(self.baseUrl+"offre/ApplicantsForOffer/"+self.id! , method: .get ).responseJSON { response in

            
            
            var statusCode = response.response?.statusCode
          
            
            if statusCode == 200
              {
                self.offre = (response.value as! Dictionary < String, Any >)
                self.users = self.offre["users"] as! NSArray
                self.applicants.text = String(self.users.count)+" Applicants"
               
              }
              else {
                
                print("Something goes wrong")
              }
          
            
        }
        
    }
    
    
    
    
    
    
}
