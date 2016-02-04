//
//  PhotoDetailsViewController.swift
//  Instagram
//
//  Created by Jennifer Lee on 2/3/16.
//  Copyright © 2016 Jennifer Lee. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photosDetailsImageView: UIImageView!
    var photo_url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosDetailsImageView.setImageWithURL(NSURL(string: self.photo_url!)!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
