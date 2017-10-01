//
//  ViewController.swift
//  Relief-App
//
//  Created by Steven Hurtado on 9/30/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleMenu: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var menu: UIView!
    var toggled : Bool = false
    
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var prepBtn: UIButton!
    @IBOutlet weak var sosBtn: UIButton!
    @IBOutlet weak var volBtn: UIButton!
    
    var dragView : SDragView?
    var contentView = UIView()
    var buttons : [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuBtn.layer.shadowColor = UIColor.black.cgColor
        self.menuBtn.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.menuBtn.layer.shadowRadius = 5
        
        self.menu.layer.cornerRadius = self.menu.layer.frame.width/2
        self.menu.clipsToBounds = true
        
        buttons.append(mapBtn)
        buttons.append(statusBtn)
        buttons.append(prepBtn)
        buttons.append(sosBtn)
        buttons.append(volBtn)
        
        for btn in buttons
        {
            btn.addTarget(self, action: #selector(selectBtn(_:)), for: .touchUpInside)
            btn.alpha = 0.0
        }
        
        UIView.animate(withDuration: 0.48, animations: {
            self.menu.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.menuBtn.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            for btn in self.buttons
            {
                btn.alpha = 0.0
            }
            self.titleMenu.alpha = 1.0
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        self.dragView = SDragView(dragViewAnimatedTopSpace: 40, viewDefaultHeightConstant: 76)
//        if let dragView = self.dragView
//        {self.view.addSubview(dragView)}
//
//        self.selectBtn(self.mapBtn)
    }
    
    func changeContent(btn : UIButton)
    {
//        if let dragView = self.dragView
//        {
//            self.contentView.removeFromSuperview()
//            if(btn == mapBtn)
//            {
//                guard let vC = self.storyboard?.instantiateViewController(withIdentifier: "MapView") as? MapViewController else {return}
//
//                //add data to map view
//                vC.modalPresentationStyle = .currentContext
//
//                self.contentView = vC.view
//            }
//
//            dragView.addSubview(self.contentView)
//            dragView.alpha = 0.0
//
//            UIView.animate(withDuration: 0.48, animations: {
//                dragView.alpha = 1.0
//            })
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toggleMenu(_ sender: Any) {
        self.toggled = !toggled
        
        if(toggled)
        {
            UIView.animate(withDuration: 0.48, animations: {
                self.menu.transform = CGAffineTransform.identity
                self.menuBtn.transform = CGAffineTransform.identity
                for btn in self.buttons
                {
                    btn.alpha = 1.0
                }
                self.titleMenu.alpha = 0.0
            })
        }
        else
        {
            UIView.animate(withDuration: 0.48, animations: {
                self.menu.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.menuBtn.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                for btn in self.buttons
                {
                    btn.alpha = 0.0
                }
                self.titleMenu.alpha = 1.0
            })
        }
    }
    
    @IBAction func mapPressed(_ sender: Any) {
        guard let vC = self.storyboard?.instantiateViewController(withIdentifier: "MapView") as? MapViewController else {return}
        vC.modalPresentationStyle = .overCurrentContext
        self.present(vC, animated: true, completion: nil)
    }
    
    @IBAction func notifyPressed(_ sender: Any) {
        guard let vC = self.storyboard?.instantiateViewController(withIdentifier: "SelfStatusView") as? SelfStatusViewController else {return}
        vC.modalPresentationStyle = .overCurrentContext
        self.present(vC, animated: true, completion: nil)
    }
    
    @IBAction func preparePressed(_ sender: Any) {
        guard let vC = self.storyboard?.instantiateViewController(withIdentifier: "PrepareView") as? PrepareViewController else {return}
        vC.modalPresentationStyle = .overCurrentContext
        self.present(vC, animated: true, completion: nil)
    }
    
    @IBAction func sosPressed(_ sender: Any) {
        guard let vC = self.storyboard?.instantiateViewController(withIdentifier: "SOSView") as? EmergencyViewController else {return}
        vC.modalPresentationStyle = .overCurrentContext
        self.present(vC, animated: true, completion: nil)
    }
    
    @IBAction func volunteerPressed(_ sender: Any) {
        guard let vC = self.storyboard?.instantiateViewController(withIdentifier: "VolunteerView") as? VolunteerViewController else {return}
        vC.modalPresentationStyle = .overCurrentContext
        self.present(vC, animated: true, completion: nil)
    }
    
    
    @objc func selectBtn(_ sender: Any)
    {
//        for btn in buttons
//        {
//            btn.tintColor = UIColor.ReliefRed
//        }
//        
//        guard let btn = sender as? UIButton else {return}
//        if(btn.backgroundColor == UIColor.ReliefRed)
//        {
//            btn.tintColor = UIColor.ReliefRed
//        }
//        else
//        {
//            btn.tintColor = UIColor.white
//            btn.layer.cornerRadius = btn.frame.width/4
//            btn.clipsToBounds = true
//        }
//        
//        changeContent(btn: btn)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

