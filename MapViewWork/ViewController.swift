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
    
    let destinations = [VacationDestination(name: "Estadio", location: CLLocationCoordinate2DMake(2.454723, -76.591655), zoom: 15), VacationDestination(name: "Cementerio", location: CLLocationCoordinate2DMake(2.448356, -76.620785), zoom: 16)]
    
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
            
        }else {
            
            if let index = destinations.index(of: currentDestination!) {
                currentDestination = destinations[index + 1]
            }
        }
        setMapCamera()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyD0L_riQOEn9ngRmYiE8ko6HZ24AbzSshk")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .red
        
        let camera = GMSCameraPosition.camera(withLatitude: 2.464266, longitude: -76.580880, zoom: 12)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        mapView?.frame = CGRect(x: 0, y: 20, width: (self.window?.frame.width)!, height: (self.window?.frame.height)! * 3 / 4)
        
        let currentLocation = CLLocationCoordinate2DMake(2.464266, -76.580880)
        let markerFiet = GMSMarker(position: currentLocation)
        markerFiet.title = "Club Campestre"
        markerFiet.map = mapView
        
        
        
        self.view.addSubview(mapView!)
        self.view.addSubview(buttonTest)
    }
    
    private func setMapCamera() {
        
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
    }
}

