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

import MapKit

class DetailsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let baseUrl = Common.Global.LOCAL + "/"
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
    let locationManager = CLLocationManager()

    @IBOutlet var map: MKMapView!
    @IBOutlet weak var SALary: UILabel!
    @IBOutlet weak var INdustry: UILabel!
    @IBOutlet var ABOUT: UITextView!
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
    @IBOutlet var imagee: UIImageView!
    @IBOutlet weak var textViewHCDesc: NSLayoutConstraint!
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        applyyy.layer.cornerRadius=20.0
        saveee.layer.cornerRadius=20.0
     
     
        
        
        DEscription.text = Description
        
        COmpany.text = industry
        addressss.text = address
        TItre.text = titre
        TItre.adjustsFontSizeToFitWidth = true
        EMployment.text = jobtime
        FUnction.text = poste
        INdustry.text = industry
        let defaults = UserDefaults.standard
      let hamma =   defaults.string(forKey: "usernameUser")
   
        if type == hamma {
            applyyy.isHidden = true
            save.isHidden = true
        }
        switch industry {
        case "esprit":
            ABOUT.text = "ESPRIT est une école de formation d'ingénieur dirigée par un directeur qui appartient au corps enseignant de l'enseignement supérieur conformément à la règlementation en vigueur."
            
        case "vermeg":
            ABOUT.text = "For VERMEG, being a responsible business lies at the heart of our human adventure and the very essence of the engaged software company we aim to be for all of our stakeholders."
        case "ebay":
            ABOUT.text = "eBay is one of the world’s largest online marketplaces, connecting people with the things they need and love virtually anytime, anywhere. eBay has 157 million active users globally and more than 800 million live individual and merchant listings at any given time, the majority of which is new and fixed-price merchandise."
        case "microsoft":
            ABOUT.text = "At Microsoft, our mission is to empower every person and every organization on the planet to achieve more. Our mission is grounded in both the world in which we live and the future we strive to create. Today, we live in a mobile-first, cloud-first world, and the transformation we are driving across our businesses is designed to enable Microsoft and our customers to thrive in this world. "
        case "apple":
            ABOUT.text = "We’re a diverse collective of thinkers and doers, continually reimagining what’s possible to help us all do what we love in new ways. And the same innovation that goes into our products also applies to our practices — strengthening our commitment to leave the world better than we found it. This is where your work can make a difference in people’s lives. Including your own."
        case "convergen":
            ABOUT.text = "Convergen is a digital and creative agency providing intelligent ad solutions that grow brands through their website performance."
            
        default :
            ABOUT.text = " "
        }
        SALary.text = String(salary!)
        imagee.image = UIImage(named: industry!)
        self.locationManager.requestAlwaysAuthorization()

            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()
        


            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }

        map.delegate = self
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        self.map.showsUserLocation = true

            if let coor = map.userLocation.location?.coordinate{
                map.setCenter(coor, animated: true)
            }
        
    }
    
    @IBAction func apply(_ sender: Any) {
        let defaults = UserDefaults.standard
        let idValue = defaults.string(forKey: "idUser")
        
        let parameterss: [String: Any] = [
            "idUser" : idValue ,
            "idOffre" : self.id
                                    
            
        ]
        AF.request(self.baseUrl+"offre/apply/new", method: .post, parameters: parameterss, encoding: JSONEncoding.default)
            .responseJSON { response in
                             
                let statusCode = response.response?.statusCode
              
                
                if statusCode == 200
                  {
                    
                  
                    HUD.flash(.labeledSuccess(title: "Success", subtitle: "Prepare for your interview now"), delay: 3.0)
                    self.performSegue(withIdentifier: "Interview", sender: self)
                    
                  }
                  else {
                    
                    
                      let alert = UIAlertController(title: "Alerte", message: "You Have already applied for this job , check your applications list ", preferredStyle: .alert)
                      let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                      alert.addAction(action)
                      self.present(alert,animated: true,completion: nil)
                    
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        map.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        map.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "You are here"
        annotation.subtitle = "current location"
        map.addAnnotation(annotation)

        //centerMap(locValue)
    }
    
}



