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
    var mapView = GMSMapView()
    
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
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "BusesApp - Ruta No 01", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)])
        
        attributedText.append(NSAttributedString(string: "\n\nasdf asdf asdfasdfasdfasdf asdfasd  asdfasdfasdf  asdfasdf asdf asdf asdf asdfasdfasdfasdfa asdf asdf asdf asdfasdfasdfasdfasdfa asdfasdfasdfasdf  asdfasdfasdfasdf asdf asdfasdfasdf asdf asdf asdfasdfasdf asdf asdfasdf", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        
        //textView.text = "BusesApp - Ruta No 01"
        //textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    @objc func handleBtn() {
        print(123)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        
        let camera = GMSCameraPosition.camera(withLatitude: 2.441427, longitude: -76.606610, zoom: 13)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: 2.444492, longitude: -76.599074))
        var position = CLLocationCoordinate2D(latitude: 2.444492, longitude: -76.599074)
        let marker = GMSMarker(position: position)
        marker.title = "Title 1"
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.map = mapView
        
        path.add(CLLocationCoordinate2D(latitude: 2.441427, longitude: -76.606610))
        position = CLLocationCoordinate2D(latitude: 2.441427, longitude: -76.606610)
        let marker2 = GMSMarker(position: position)
        marker2.title = "Title 2"
        marker2.icon = GMSMarker.markerImage(with: .green)
        marker2.map = mapView
        
        path.add(CLLocationCoordinate2D(latitude: 2.438383, longitude: -76.624452))
        position = CLLocationCoordinate2D(latitude: 2.438383, longitude: -76.624452)
        let marker3 = GMSMarker(position: position)
        marker3.title = "Title 3"
        marker3.icon = GMSMarker.markerImage(with: .yellow)
        marker3.map = mapView
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .black
        polyline.strokeWidth = 10.0
        polyline.geodesic = true
        polyline.map = mapView
        
        //mapView.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: (self.window?.frame.height)! * 3 / 4)
        //mapView?.frame = CGRect.zero
        
        //view.addSubview(mapView)
        view.addSubview(descriptionTextView)
        //self.view.addSubview(buttonTest)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let topImageContainerView = UIView()
        topImageContainerView.backgroundColor = .blue
        view.addSubview(topImageContainerView)
        //topImageContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        topImageContainerView.addSubview(mapView)
        mapView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        
        
        //topImageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //topImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
        
        
//        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        mapView.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

