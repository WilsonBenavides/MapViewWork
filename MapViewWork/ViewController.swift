//
//  ViewController.swift
//  MapViewWork
//
//  Created by willix on 22/05/18.
//  Copyright © 2018 willix. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var mapView = MKMapView()
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .red
        
        
        let loc = CLLocationCoordinate2DMake(2.4430307,-76.7184948)
        let span = MKCoordinateSpanMake(0.08, 0.08)
        let reg = MKCoordinateRegionMake(loc, span)
        self.mapView.setRegion(reg, animated: true)
        
        mapView.frame = CGRect(x: 0, y: 20, width: (self.window?.frame.width)!, height: (self.window?.frame.height)! / 2)
        
        //self.mapView = MKMapView(frame: CGRect(x: 0, y: 20, width: (self.window?.frame.width)!, height: 300))
        self.view.addSubview(self.mapView)
    }
}

