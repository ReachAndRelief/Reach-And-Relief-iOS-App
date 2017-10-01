//
//  SplashViewController.swift
//  Relief-App
//
//  Created by Steven Hurtado on 10/1/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoIV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        logoIV.alpha = 0.0
        
        UIView.animate(withDuration: 0.48) {
            self.logoIV.alpha = 1.0
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.48, repeats: false, block: { (Timer) in
            
            UIView.animate(withDuration: 0.48, animations: {
                self.logoIV.alpha = 0.0
            }, completion: { (Bool) in
                self.performSegue(withIdentifier: "splashSegue", sender: self)
            })
        })
        // Do any additional setup after loading the view.
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
