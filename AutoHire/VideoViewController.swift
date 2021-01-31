//
//  VideoViewController.swift
//  AutoHire
//
//  Created by Aymen Smati on 12/27/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import WebKit
class VideoViewController : UIViewController{
    
    
    
    @IBOutlet weak var videoWebView: WKWebView!
    
    
    var video:Video = Video()
       
    
    
       override func viewDidLoad() {
           super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
               webConfiguration.allowsInlineMediaPlayback = true
               
               
           getVideo(videoKey: video.Key)
           
           // Do any additional setup after loading the view.
       }
       
       func getVideo(videoKey:String) {
           
           let url = URL(string: "https://www.youtube.com/embed/\(videoKey)?playsinline=1")
           videoWebView?.load(URLRequest(url: url!))
           
       }
}
