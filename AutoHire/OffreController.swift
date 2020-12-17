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
import SwiftyJSON
import MapKit
import CoreLocation

 

class OffreController : UITableViewController ,CLLocationManagerDelegate{
 
    
   
    var p : Int = 2
    var testBool = false
    var offres : NSArray = []
    var data: [JSON] = []
    let locationManager = CLLocationManager()
    
    var Lat : String?
    var Lon : String?

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     
        if !testBool {
            
            
         
            
            switch p {
            case 0:
                getData()
          
            case 1:
                getDataParAddress()
               
            default :
                
                getData()
               
            }
            tableView.reloadData()
            
        }
        testBool = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
                   locationManager.delegate = self
                   locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
                   locationManager.startUpdatingLocation()
               }
        
        
       getData()
        testBool = true
        tableView.reloadData()
        
      
     
        
     
        
            }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                print(location.coordinate)
                self.Lat = String(location.coordinate.latitude)
                self.Lon = String(location.coordinate.longitude)
            }
        }
        
        // If we have been deined access give the user the option to change it
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if(status == CLAuthorizationStatus.denied) {
                showLocationDisabledPopUp()
            }
        }
        
        // Show the popup to the user if we have been deined access
        func showLocationDisabledPopUp() {
            let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                    message: "In order to deliver pizza we need your location",
                                                    preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            alertController.addAction(openAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offres.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "toDetails", sender: indexPath)

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier : "test" , for: indexPath)
        
  
        let item = self.offres[indexPath.row] as! Dictionary<String,Any>
  
        let container = cell.viewWithTag(0)
        
        let image = container!.viewWithTag(1) as! UIImageView
        
        let titre = container!.viewWithTag(2) as! UILabel
        
        let industry = container!.viewWithTag(3) as! UILabel
        
        let address = container!.viewWithTag(4) as! UILabel
        
        let date = container!.viewWithTag(5) as! UILabel
      
        titre.text = item["titre"] as? String 
        industry.text = item ["company"] as? String
        address.text = item ["address"] as? String
        date.text = item ["date"] as? String
       
        
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? NSIndexPath
        if segue.identifier == "toDetails"{
        
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
        
            print(product)
        
        
       
            
            
            if let destinationVC =  segue.destination as? DetailsViewController{
                
                destinationVC.Description = description
                destinationVC.id = id
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
    
    @IBAction func switchCustom(_ sender: UISegmentedControl) {
   
      p = sender.selectedSegmentIndex
        
        switch p {
        case 0:
            getData()
      
        case 1:
            getDataParAddress()
           
        default :
            
            getData()
           
        }
        self.tableView.reloadData()
    
    }
    
  
    func getData(){
        self.data = []
        AF.request("http://localhost:3000/offre/All/Offre" , method: .get ).responseJSON { response in

            
            
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
    func getDataParAddress(){
       
        let parametrs : Dictionary < String , Any > = [
        
            "long" : self.Lon ,
            "latt" :   self.Lat
    
            
        ]
        AF.request("http://localhost:3000/offre/" , method: .post , parameters: parametrs , encoding: JSONEncoding.default ).responseJSON { response in

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
