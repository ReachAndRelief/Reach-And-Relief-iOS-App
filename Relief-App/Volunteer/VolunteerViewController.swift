//
//  VolunteerViewController.swift
//  Relief-App
//
//  Created by Steven Hurtado on 10/1/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class VolunteerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtn(_ sender: Any) {
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

extension VolunteerViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertCell", for: indexPath) as! AlertCell
        cell.timeLabel.text = "Dei Nada"
        cell.detailLabel.text = "503 Address Street"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let title = UILabel(frame: CGRect(x: 8.0, y: 0.0, width: 128, height: 28))
        if(section == 0)
        {
            title.text = "Go Out There"
        }
        else if(section == 1)
        {
            title.text = "Donate"
        }
        else
        {
            title.text = "Events"
        }
        
        view.addSubview(title)
        
        view.backgroundColor = UIColor.ReliefRed.withAlphaComponent(0.84)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = view.bounds
        visualEffectView.tintColor = UIColor.ReliefRed
        
        view.addSubview(visualEffectView)
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}
