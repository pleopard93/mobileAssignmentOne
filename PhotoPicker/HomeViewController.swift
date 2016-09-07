//
//  HomeViewController.swift
//  PhotoPicker
//
//  Created by Xinyi Ding on 9/6/16.
//  Copyright © 2016 Xinyi. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UITableViewController {
    
    let sharedImageModel = ImageModle.sharedInstance
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    override func viewWillAppear(animated: Bool) {
        self.mainTableView.reloadData()
        print("view will appear")
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        if section == 0 || section == 1 {
            return 1
        }
        return sharedImageModel.imageNames.count
    }
    
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("ImageCollection")
        cell?.textLabel!.text = "Collection"
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCellWithIdentifier("ImageSlider")
            cell?.textLabel!.text = "Image Slider"
        } else if indexPath.section == 2 {
            cell = tableView.dequeueReusableCellWithIdentifier("ImageDetail")
            var names = sharedImageModel.getImageNames()
            cell?.textLabel?.text = names[indexPath.row]
        }
        return cell!
    }

}