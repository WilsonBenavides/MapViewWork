//
//  ViewController.swift
//  MapViewWork
//
//  Created by willix on 22/05/18.
//  Copyright © 2018 willix. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination: NSObject {
    
    let name: String
    let location:  CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
}

class ViewController: UIViewController {
    
    var window: UIWindow?
    var mapView: GMSMapView?
    
    var currentDestination: VacationDestination?
    
    let destinations = [VacationDestination(name: "Fiet", location: CLLocationCoordinate2DMake(2.446662, -76.598466), zoom: 15), VacationDestination(name: "Cementerio", location: CLLocationCoordinate2DMake(2.448356, -76.620785), zoom: 16)]
    
    let buttonTest: UIButton = {
        let yPos = UIScreen.main.bounds.height - 50
        let btn = UIButton()
        btn.setTitle("Test", for: .normal)
        btn.frame = CGRect(x: 0, y: yPos, width: 100, height: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(handleBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func handleBtn() {
        print(123)
        if currentDestination == nil {
            currentDestination = destinations.first
            
            //mapView?.animateToCameraPosition()
            
            mapView?.camera = GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom)
            
            let marker = GMSMarker(position: currentDestination!.location)
            marker.title = currentDestination?.name
            marker.map = mapView
        }else {
            
            if let index = destinations.index(of: currentDestination!) {
                currentDestination = destinations[index + 1]
                
                mapView?.camera = GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom)
                
                let marker = GMSMarker(position: currentDestination!.location)
                marker.title = currentDestination?.name
                marker.map = mapView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyD0L_riQOEn9ngRmYiE8ko6HZ24AbzSshk")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .red
        
        let camera = GMSCameraPosition.camera(withTarget: destinations[0].location, zoom: destinations[0].zoom)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //mapView?.isMyLocationEnabled = true
        mapView?.frame = CGRect(x: 0, y: 20, width: (self.window?.frame.width)!, height: (self.window?.frame.height)! * 3 / 4)
        
        let currentLocation = CLLocationCoordinate2DMake(2.448632, -76.598720)
        let markerFiet = GMSMarker(position: currentLocation)
        markerFiet.title = "FIET"
        markerFiet.map = mapView
        
        
        
        self.view.addSubview(mapView!)
        self.view.addSubview(buttonTest)
    }
}

