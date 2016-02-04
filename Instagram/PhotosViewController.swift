//
//  ViewController.swift
//  Instagram
//
//  Created by Jennifer Lee on 2/3/16.
//  Copyright © 2016 Jennifer Lee. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var data: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 320;

        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                    data, options:[]) as? NSDictionary {
                        self.data = responseDictionary["data"] as! [NSDictionary]
                        self.tableView.reloadData()
                        
                    }
                }
        });
        task.resume()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.PrototypeCell", forIndexPath: indexPath) as! TableViewCell
        if  let data = self.data {
            let data_row = data[indexPath.row]
            let caption_field = data_row["caption"] as? NSDictionary
            let from_field = caption_field!["from"] as? NSDictionary
            let url = from_field!["profile_picture"] as? String
            // In memory of our janky code:
            // let url = data["caption"]!["from"]!!["profile_picture"] as! String
            cell.photoImageView.setImageWithURL(NSURL(string: url!)!)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.data {
            return data.count
        } else {
            return 0
        }

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! PhotoDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        if  self.data != nil {
            let data = self.data![indexPath!.row]
            let url = data["caption"]!["from"]!!["profile_picture"] as! String
            vc.photo_url = url
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }


}

