//
//  AymenController.swift
//  AutoHire
//
//  Created by imen manai on 12/3/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
class AymenController : UITableViewController
{
    

    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier : "hhhh" , for: indexPath)
        
        cell.textLabel?.text = "hammaaaaaaaa"
        
        return cell
    }
    
    
    
    
    
    
    
}
