//
//  DetailsViewController.swift
//  MiniProjetIos
//
//  Created by Tarek El Ghoul on 09/12/2018.
//  Copyright © 2018 Tarek El Ghoul. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import CoreData
import PKHUD



class DetailsViewController: UIViewController {
    
    
    var id : Int?
    var salary : Int?
    var titre  : String?
    var type  : String?
    var Description  : String?
    var jobtime  : String?
    var industry  : String?
    var address  : String?
    var poste  : String?
    var datee : String?
    
    @IBOutlet weak var SALary: UILabel!
    @IBOutlet weak var INdustry: UILabel!
    @IBOutlet weak var FUnction: UILabel!
    @IBOutlet weak var EMployment: UILabel!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var TItre: UILabel!
    @IBOutlet weak var DEscription: UITextView!
    @IBOutlet weak var DATe: UILabel!
    @IBOutlet weak var addressss: UILabel!
  
    @IBOutlet weak var applyyy: UIButton!
    @IBOutlet weak var saveee: UIButton!
    
    @IBOutlet weak var COmpany: UILabel!
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        applyyy.layer.cornerRadius=20.0
        saveee.layer.cornerRadius=20.0
     
     
        
        
        DEscription.text = Description
        COmpany.text = type
        addressss.text = address
        TItre.text = titre
        EMployment.text = jobtime
        FUnction.text = poste
        INdustry.text = industry
        SALary.text = String(salary!)
        
        
    }
    
    @IBAction func apply(_ sender: Any) {
        let defaults = UserDefaults.standard
        let idValue = defaults.string(forKey: "idUser")
        
        let parameterss: [String: Any] = [
            "idUser" : idValue ,
            "idOffre" : self.id
                                    
            
        ]
        AF.request("http://localhost:3000/offre/apply/new", method: .post, parameters: parameterss, encoding: JSONEncoding.default)
            .responseJSON { response in
                             
                let statusCode = response.response?.statusCode
              
                
                if statusCode == 200
                  {
                    
                    HUD.flash(.success , delay: 1.0)
                    
                    
                  }
                  else {
                    
                    print("You are already applied for this offer")
                  }
                }
        
    }
    
    
    @IBAction func Save(_ sender: Any) {
        
      

              
              let appDelegate = UIApplication.shared.delegate as! AppDelegate
              let persistantContainer = appDelegate.persistentContainer
              
              let context = persistantContainer.viewContext

        let request = NSFetchRequest<NSManagedObject>(entityName: "Offre")
        let predicate = NSPredicate(format: "titre = %@" , titre!  )
        request.predicate = predicate
              do {
                
                  let resultArray = try context.fetch(request)
                  if resultArray.count == 0 {
                    let newProduct = NSEntityDescription.insertNewObject (forEntityName: "Offre", into: context)
               
                      
                    newProduct.setValue(self.id, forKey: "id")
                    newProduct.setValue(self.salary, forKey: "salary")
                    newProduct.setValue(self.titre, forKey: "titre")
                    newProduct.setValue(self.type, forKey: "type")
                    newProduct.setValue(self.Description, forKey: "descriptionn")
                    newProduct.setValue(self.jobtime, forKey: "jobTime")
                    newProduct.setValue(self.industry, forKey: "industry")
                    newProduct.setValue(self.address, forKey: "address")
                    newProduct.setValue(self.poste, forKey: "poste")
                    newProduct.setValue(self.datee, forKey: "date")



                      do {
                          try context.save()
                          HUD.flash(.success , delay: 1.0)
                          print ("Offre Saved !!")
                      } catch {
                          print("Error !")
                      }
                  }else{
                    
                    
                      let alert = UIAlertController(title: "Alerte", message: "l'offre existe déjà dans vos favoris", preferredStyle: .alert)
                      let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                      alert.addAction(action)
                      self.present(alert,animated: true,completion: nil)
                    
                  }
              } catch {
                
                  print("error")
              }
    }
    
}



