//
//  OffreController.swift
//  AutoHire
//
//  Created by Admin on 12/2/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//
import Alamofire
import Foundation
import UIKit
class OffreController : UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    
   
    @IBOutlet weak var tableView: UITableView!
    
    var offres :NSArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AF.request("http://localhost:3000/offre/admin", method: .get, encoding: JSONEncoding.default)
            .responseJSON(completionHandler: {  response in
               
                print(response.value)

                
                self.tableView.reloadData()
                
                print (self.offres)
              
            })}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offres.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier : "cell")
        let item = self.offres[indexPath.row]
        let container = cell?.contentView
        let image = container?.viewWithTag(1) as! UIImageView
        let titre = container?.viewWithTag(2) as! UITextView
        let industry = container?.viewWithTag(3) as! UITextView
        let address = container?.viewWithTag(4) as! UITextView
        let date = container?.viewWithTag(5) as! UITextView
        let applicants = container?.viewWithTag(6) as! UITextView
         
        titre.text = self.offres[indexPath.row] as! String
        
        return cell!
    }
    
    
  

    }
