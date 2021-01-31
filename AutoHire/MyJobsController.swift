//
//  MyJobs.swift
//  AutoHire
//
//  Created by Aymen Smati on 12/29/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import  UIKit
import Alamofire
import CoreData

class MyJobsController : UIViewController ,UITableViewDataSource, UITableViewDelegate {
 
    
    
    let baseUrl = Common.Global.LOCAL + "/"
    
    var offres : NSArray = []
    var testBool = false
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     
        if !testBool {
            
            
         
            
           
                getData()
          
           
            tableView.reloadData()
            
        }
        testBool = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        testBool = true

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
          let cell = tableView.dequeueReusableCell(
              withIdentifier : "my" , for: indexPath)
          

          let item = self.offres[indexPath.row] as! Dictionary<String,Any>

          let container = cell.viewWithTag(0)
          
          let image = container!.viewWithTag(1) as! UIImageView
          
          let titre = container!.viewWithTag(2) as! UILabel
          
         
          
          let date = container!.viewWithTag(3) as! UILabel
        
          titre.text = item["titre"] as? String
        
        let hammaa =  item ["createdAt"] as? String
        let lastDate = String(hammaa!.prefix(10))
        let startDate = Date()
        

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        if let endDate = formatter.date(from: lastDate) {
            let components = Calendar.current.dateComponents([.day], from: endDate, to: startDate)
            date.text = "Posted \(components.day!) days ago"
        } else {
            print("\(lastDate) can't be converted to a Date")
        }
        
           
          let hamma = item["industry"] as? String
          image.image = UIImage(named: hamma!)
          
          return cell
              
    }
 
 
    

    

        
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
            performSegue(withIdentifier: "toManage", sender: indexPath)
        

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)    {
        let index = sender as? NSIndexPath
        if segue.identifier == "toManage"{
        
        let product = self.offres[index!.row] as! Dictionary<String,Any>
  
        let id = product["id"] as! Int
        let titre = product["titre"] as! String
        let industry = product["industry"] as! String
        let description = product["description"] as! String
        let adress = product["address"] as! String
        let poste = product["poste"] as! String
        let jobTime = product["jobTime"] as! String
        let salary = product["salary"] as! Int
        let type = product["company"] as! String
        let date = product["createdAt"] as! String
        
           
        
        
       
            
            
            if let destinationVC =  segue.destination as? ManageJobController  {
                
                destinationVC.Description = description
                destinationVC.id = String(id)
                destinationVC.address = adress
                destinationVC.industry = industry
                destinationVC.poste = poste
                destinationVC.jobtime = jobTime
                destinationVC.titre = titre
                destinationVC.type = type
                destinationVC.salary = salary
                destinationVC.datee = date
                
                
            }
        }
        
    }
    
   
    
    func getData(){
        let defaults = UserDefaults.standard
        let idValue = defaults.string(forKey: "usernameUser")
        
        AF.request(self.baseUrl+"offre/ByCreator/"+idValue! , method: .get ).responseJSON { response in

            
            
            var statusCode = response.response?.statusCode
          
            
            if statusCode == 200
              {
                self.offres = (response.value as! NSArray)
                
                self.tableView.reloadData()
              }
              else {
                
                print("Something goes wrong")
              }
          
            
        }
        
    }
    
    
    
    
    
    
}

