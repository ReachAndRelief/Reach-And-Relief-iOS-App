//
//  MapViewController.swift
//  Relief-App
//
//  Created by Steven Hurtado on 9/30/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager : CLLocationManager!
    var selfLocation : CLLocation! = CLLocation()
    
    var locations : [(CLLocation, String)] = []
    var disasters : [String] = []
    
    var spanX : Double!
    var spanY : Double!
    
    var maxX : Double! = 0.001
    var maxY : Double! = 0.001
    
    var span = MKCoordinateSpan()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        self.mapView.layer.cornerRadius = self.mapView.frame.width/8
        self.mapView.clipsToBounds = true
        
        mapView.tintColor = UIColor.white
        
        //Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        loadData()
    }
    
    func loadData()
    {
        ReliefAPI.sharedInstance().getDisastersRecent { (result: NSDictionary?, status: Int, error: String?) in
            if(error == nil)
            {
                print(status)
                print(result)

                guard let result = result else{return}
                if let data = result["data"] as? [NSDictionary]
                {
                    for dict in data
                    {
                        guard let fields = dict["fields"] as? NSDictionary else{return}
                        guard let valueString = fields["name"] as? String else{return}
                        
                        var name = ""
                        var disaster = ""
                        var switchDisaster = false
                        for c in valueString
                        {
                            if(c == ":")
                            {
                                switchDisaster = true
                            }
                            else
                            {
                                if(!switchDisaster){ name += "\(c)"}
                                else{
                                    disaster += "\(c)"
                                }
                            }
                        }
                        
                        self.disasters.append(disaster)
                        
                        let request = MKLocalSearchRequest()
                        request.naturalLanguageQuery = name
                        request.region = self.mapView.region
                        let search = MKLocalSearch(request: request)
                        search.start(completionHandler: { (response, error) in
                            guard let response = response else {return}
                            if(response.mapItems.count > 0)
                            {
                                if let text = response.mapItems[0].placemark.name, let location = response.mapItems[0].placemark.location
                                {
                                    self.locations.append((location, text))
                                    self.addAnnotationAtCoordinate(coordinate: response.mapItems[0].placemark.coordinate, nameLabelText: text)
                                    
                                    self.selfLocation = self.locationManager.location
                                    
                                    self.tableView.reloadData()
                                    
                                    let lat = location.coordinate.latitude
                                    let long = location.coordinate.longitude
                                    let destLocation = CLLocation(latitude: lat, longitude: long)
                                    self.goToLocation(destLocation: destLocation)
                                    self.goToLocation(destLocation: self.selfLocation)
                                }
                            }
                        })
                    }
                }
            }
            else
            {
                print("Error: \(error)")
            }
        }
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    // add an Annotation with a coordinate: CLLocationCoordinate2D
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D, nameLabelText: String)
    {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = nameLabelText
        
        mapView.addAnnotation(annotation)
    }
    
    func goToLocation(destLocation: CLLocation)
    {
        spanX = 3*abs(self.selfLocation.coordinate.latitude-destLocation.coordinate.latitude)
        spanY = 3*abs(self.selfLocation.coordinate.longitude-destLocation.coordinate.longitude)
        
        if(spanX > maxX)
        {
            maxX = spanX
        }
        
        if(spanY > maxY)
        {
            maxY = spanY
        }
        
        print("MAX X: \(maxX) CURR: \(spanX) ")
        print("MAX Y: \(maxY) CURR: \(spanY) ")
        
        let region = MKCoordinateRegionMakeWithDistance(destLocation.coordinate, maxX, maxY)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func TapLocation(_ sender : IPTap)
    {
        guard let row = sender.indexPath?.row else{return}
        let loca = self.locations[row]
        goToLocation(destLocation: loca.0)
    }
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertCell", for: indexPath) as! AlertCell
//        print(cell.frame.width)
//        print(cell.frame.height)
//        print("")
//        print(cell.timeLabel.text)
//        print(cell.detailLabel.text)
//        print("")
        
        cell.timeLabel.text = self.locations[indexPath.row].1
        cell.detailLabel.text = disasters[indexPath.row]
        let recog = IPTap(target: self, action: #selector(TapLocation(_:)))
        recog.indexPath = indexPath
        cell.addGestureRecognizer(recog)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
}

class IPTap : UITapGestureRecognizer
{
    var indexPath : IndexPath?
}
