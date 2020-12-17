//
//  FavController.swift
//  AutoHire
//
//  Created by Admin on 12/9/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import Foundation
import  UIKit
import CoreData

class FavController : UITableViewController {
    
    
    var OffreArray : [NSManagedObject] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCoreData()

    }
    
   override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OffreArray.count
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let offre = OffreArray[indexPath.row]

         let cell = tableView.dequeueReusableCell(withIdentifier: "FavOffre", for: indexPath)
         let content = cell.viewWithTag(0)
         let offreImageView = content?.viewWithTag(1) as! UIImageView
         let offreTitreLabel = content?.viewWithTag(2) as! UILabel
         let offreIndustryLabel = content?.viewWithTag(3)  as! UILabel
         let offreAddressLabel = content?.viewWithTag(4) as! UILabel
         let offreDateLabel = content?.viewWithTag(5) as! UILabel
         offreTitreLabel.text = offre.value(forKey: "titre") as? String
         offreIndustryLabel.text = offre.value(forKey: "poste") as? String
         offreAddressLabel.text = offre.value(forKey: "address") as? String
         offreDateLabel.text = offre.value(forKey: "date") as? String
     
        
        
        return cell
        
        
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
            performSegue(withIdentifier: "toDetailss", sender: indexPath)
        

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)    {
        let index = sender as? NSIndexPath
        
        let offre = OffreArray[index!.item]
        
        let OffreId = offre.value(forKey: "id") as! Int
        let OffreTitre = offre.value(forKey: "titre") as! String
        let OffreAddress = offre.value(forKey: "address") as! String
        let OffreIndustry = offre.value(forKey: "industry") as! String
        let OffreSalary = offre.value(forKey: "salary") as! Int
        let OffreDescription = offre.value(forKey: "descriptionn") as! String
        let OffreJobtime = offre.value(forKey: "jobTime") as! String
        let OffrePoste = offre.value(forKey: "poste") as! String
        let Offredatee = offre.value(forKey: "date") as! String
        let OffreType = offre.value(forKey: "type") as! String
      
            if let destinationVC =  segue.destination as? DetailsViewController{
                
                destinationVC.id = OffreId
                destinationVC.titre = OffreTitre
                destinationVC.datee = Offredatee
                destinationVC.Description = OffreDescription
                destinationVC.industry = OffreIndustry
                destinationVC.address = OffreAddress
                destinationVC.poste = OffrePoste
                destinationVC.jobtime = OffreJobtime
                destinationVC.salary = OffreSalary
                destinationVC.type = OffreType
            }
            
        
      
        
    }
    
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let productToDelete =  OffreArray[indexPath.row]
            context.delete(productToDelete)
            
            do{
                try context.save()
                OffreArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                //tableView.reloadData()
            }catch{
                print("Error")
            }
            
            
            
        }
    }
    
    
    
    func getCoreData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject> (entityName: "Offre")
        
        do {
            OffreArray = try context.fetch(request)
            tableView.reloadData()
        } catch  {
            print ("Error!")
        }
    }
    
    
    
}
