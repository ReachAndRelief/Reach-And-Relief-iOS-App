//
//  SelfStatusViewController.swift
//  Relief-App
//
//  Created by Steven Hurtado on 10/1/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class SelfStatusViewController: UIViewController {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var postToFB: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        messageView.layer.cornerRadius = 8
        postToFB.layer.cornerRadius = postToFB.frame.width/2
        postToFB.clipsToBounds = true
    }
    
    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
