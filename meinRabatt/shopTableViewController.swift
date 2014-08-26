//
//  shopTableViewController.swift
//  meinRabatt
//
//  Created by Oliver Rosner on 24.08.14.
//  Copyright (c) 2014 Schilum23. All rights reserved.
//

import UIKit

class shopTableViewController: UITableViewController {
    
    var daten = [Shops]()
    let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    let dataSave: saveData = saveData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // mein-Rabatt Bild
        let image:UIImage = UIImage(named: "meinRabatt")
        let imageView:UIImageView = UIImageView(image: image)
        self.navigationItem.titleView = imageView
        
        dataSave.saveInDataBase()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {

        return 1
        
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell:shopTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as shopTableViewCell

       
        let image:UIImage = UIImage(data: NSData(contentsOfURL: NSURL(string: "")))

        
        cell.shopImageView.image = image
        cell.shopImageView.layer.cornerRadius = 10
        cell.shopImageView.clipsToBounds = true
       // cell.shopNameLabel.text = parser.objects[indexPath.row]["shopName"]

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
