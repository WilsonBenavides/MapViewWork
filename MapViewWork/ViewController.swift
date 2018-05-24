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
        
        let camera = GMSCameraPosition.camera(withLatitude: 2.441427, longitude: -76.606610, zoom: 14)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: 2.444492, longitude: -76.599074))
        path.add(CLLocationCoordinate2D(latitude: 2.441427, longitude: -76.606610))
        path.add(CLLocationCoordinate2D(latitude: 2.438383, longitude: -76.624452))
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .black
        polyline.strokeWidth = 10.0
        polyline.geodesic = true
        polyline.map = mapView

        mapView?.frame = CGRect(x: 0, y: 20, width: (self.window?.frame.width)!, height: (self.window?.frame.height)! * 3 / 4)
        
        self.view.addSubview(mapView!)
        self.view.addSubview(buttonTest)
    }
}

