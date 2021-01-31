//
//  ApplicantsController.swift
//  AutoHire
//
//  Created by Aymen Smati on 10/1/2021.
//  Copyright © 2021 ESPRIT. All rights reserved.
//
import UIKit
import Alamofire
class ApplicantsController : UITableViewController {
    var testBool = false
    var id : String?
    var offre : Dictionary<String,Any> = [:]
    var users : NSArray = []
    let baseUrl = Common.Global.LOCAL + "/"
    var urlKey = "file:///Users/ayman/Desktop/Mini/AutoHireBack/uploads/"
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     
        if !testBool {
            
            print(id)
         getData()
            
           
            
        }
        testBool = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      
        testBool = true
        getData()
           
 
                 
     
            }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "toProfile", sender: indexPath)

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier : "test" , for: indexPath)
        
  
        let item = self.users[indexPath.row] as! Dictionary<String,Any>
  
        let container = cell.viewWithTag(0)
        
        let image = container!.viewWithTag(1) as! UIImageView
        
        let nom = container!.viewWithTag(2) as! UILabel
        
        let industry = container!.viewWithTag(3) as! UILabel
        
        let address = container!.viewWithTag(4) as! UILabel
        let picture = item["picture"] as! String
        
        
        
        let date = container!.viewWithTag(5) as! UILabel
        if let url = URL(string: urlKey+picture){
                  
                  do {
                      let data = try Data(contentsOf: url)
                     image.image = UIImage(data: data)
                      
                  }catch let err {
                      print(" Error : \(err.localizedDescription)")
                  }
                  
                  
              }
        
        nom.text = item["username"] as? String
        industry.text = item ["role"] as? String
        address.text = item ["address"] as? String
      
       
        
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? NSIndexPath
        if segue.identifier == "toProfile"{
        
        let product = self.users[index!.row] as! Dictionary<String,Any>
  
        let username = product["username"] as! String
        
    
            
            if let destinationVC =  segue.destination as? ApplicantDetailController {
                
                destinationVC.username = username
              
              
               
                
                
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
                print(self.users)
                self.tableView.reloadData()
              }
              else {
                
                print("Something goes wrong")
              }
          
            
        }
        
    }
    
    
    
    
    
}
