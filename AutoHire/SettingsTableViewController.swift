//
//  SettingsTableViewController.swift
//  AutoHire
//
//  Created by Aymen Smati on 10/1/2021.
//  Copyright © 2021 ESPRIT. All rights reserved.
//


import UIKit
import CoreData
class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    var exercices = [String]()
    var idUser : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        retreiveData()
        logoImageView.clipsToBounds = true
        idUser = UserDefaults.standard.string(forKey: "idUser")
        
        print(exercices)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 2
        } else if(section == 1){
            return 1
        } else if(section == 2){
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath == [0,0]){
            performSegue(withIdentifier: "jobPosting", sender: nil)
        } else if(indexPath == [0,1]) {
            performSegue(withIdentifier: "toFav", sender: nil)
        } else if(indexPath == [1,0]) {
            performSegue(withIdentifier: "toProfile", sender: nil)
        } else if(indexPath == [2,0]){
            
            deleteElements()
            exercices.removeAll()
         
            self.performSegue(withIdentifier: "LogOut", sender: self)
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "usernameUser")
            defaults.removeObject(forKey: "idUser")
            
        }
    }
  
    func retreiveData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Offre")
        
        do {
            
            let data = try managedContext.fetch(request)
            for item in data {
                
                self.exercices.append(item.value(forKey: "titre") as! String)
                print(exercices)
            }
            
        } catch  {
            
            print("Fetching error !")
        }
        
    }
    
    //..
    func getByCreateria(name: String) -> NSManagedObject{
        
        var exExist:NSManagedObject?
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Offre")
        let predicate = NSPredicate(format: "titre = %@", name)
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                
                exExist = (result[0] as! NSManagedObject)
               
              
            }
            
        } catch {
            
            print("Fetching by criteria error !")
        }
        
        
        return exExist!
    }
    
    
    //..
    
    func deleteElements() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        for item in self.exercices {
        
            let object = getByCreateria(name: item)
            managedContext.delete(object)
        }
       
    


}
}
