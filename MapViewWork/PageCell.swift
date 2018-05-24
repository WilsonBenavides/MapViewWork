//
//  PageCell.swift
//  MapViewWork
//
//  Created by willix on 24/05/18.
//  Copyright © 2018 willix. All rights reserved.
//

import UIKit
import GoogleMaps

class PageCell: UICollectionViewCell {
    
    var mapView = GMSMapView()
    
    var currentDestination: Page?
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            
            currentDestination = unwrappedPage
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText + " - \(unwrappedPage.name)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.gray]))
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
            
            mapView.clear()
            //let camera = GMSCameraPosition.camera(withLatitude: unwrappedPage.location.latitude, longitude: unwrappedPage.location.longitude, zoom: 13)
            //mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            
            //let marker = GMSMarker(position: unwrappedPage.location)
            print(unwrappedPage.name)
            //marker.title = unwrappedPage.name
            //marker.icon = GMSMarker.markerImage(with: unwrappedPage.color)
            //marker.map = mapView
            
            setMapCamera()
        }
    }
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        var prop = (UIScreen.main.bounds.height / 200.0) + 1
        
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: prop * 4), NSAttributedStringKey.foregroundColor: UIColor.black])
        
       attributedText.append(NSAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: prop * 3), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .yellow
        setupMapView()
        setupLayout()
        
    }
    
    private func setupLayout() {
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageContainerView.addSubview(mapView)
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        
        mapView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor).isActive = true
        
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 2.441427, longitude: -76.606610, zoom: 13)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: 2.444492, longitude: -76.599074))
        //var position = CLLocationCoordinate2D(latitude: 2.444492, longitude: -76.599074)
        //let marker = GMSMarker(position: position)
        //marker.title = "Title 1"
        //marker.icon = GMSMarker.markerImage(with: .blue)
        //marker.map = mapView
        
        path.add(CLLocationCoordinate2D(latitude: 2.441427, longitude: -76.606610))
        //position = CLLocationCoordinate2D(latitude: 2.441427, longitude: -76.606610)
        //let marker2 = GMSMarker(position: position)
        //marker2.title = "Title 2"
        //marker2.icon = GMSMarker.markerImage(with: .green)
        //marker2.map = mapView
        
        path.add(CLLocationCoordinate2D(latitude: 2.438383, longitude: -76.624452))
        //position = CLLocationCoordinate2D(latitude: 2.438383, longitude: -76.624452)
        //let marker3 = GMSMarker(position: position)
        //marker3.title = "Title 3"
        //marker3.icon = GMSMarker.markerImage(with: .yellow)
        //marker3.map = mapView
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .black
        polyline.strokeWidth = 15.0
        polyline.geodesic = true
        polyline.map = mapView
    }
    
    private func setMapCamera() {
        
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        
        mapView.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.icon = GMSMarker.markerImage(with: currentDestination!.color)
        marker.map = mapView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
