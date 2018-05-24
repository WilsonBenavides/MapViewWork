//
//  ViewController.swift
//  MapViewWork
//
//  Created by willix on 22/05/18.
//  Copyright © 2018 willix. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    var window: UIWindow?
    var mapView: GMSMapView?
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyD0L_riQOEn9ngRmYiE8ko6HZ24AbzSshk")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.40, longitude: -122.1, zoom: 11)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
        path.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
        path.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2))
        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2))
        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
        
        let rectangle = GMSPolyline(path: path)
        rectangle.map = mapView

        mapView?.frame = CGRect(x: 0, y: 20, width: (self.window?.frame.width)!, height: (self.window?.frame.height)! * 3 / 4)
        
        self.view.addSubview(mapView!)
        self.view.addSubview(buttonTest)
    }
}

