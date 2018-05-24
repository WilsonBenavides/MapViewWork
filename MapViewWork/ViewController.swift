//
//  ViewController.swift
//  MapViewWork
//
//  Created by willix on 22/05/18.
//  Copyright © 2018 willix. All rights reserved.
//

import UIKit
import GoogleMaps

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class ViewController: UIViewController {
    
    var window: UIWindow?
    var mapView = GMSMapView()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        var prop = (UIScreen.main.bounds.height / 200.0) + 1
        print("height: " + "\(UIScreen.main.bounds.height)" + ", width: " + "\(UIScreen.main.bounds.width)" + " , related font to 18 and 13: " + "\(prop * 4)" + ", \(prop * 3)")
        
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: prop * 4)])
        
        attributedText.append(NSAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: prop * 3), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        //textView.text = "Join us today in our fun and games!"
        //textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        
        print("console message test...")
        if UIDevice.current.userInterfaceIdiom == .phone {
            print("height: " + "\(UIScreen.main.bounds.height)" + ", width: " + "\(UIScreen.main.bounds.width)" + " , iPhone device.")
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            print("height: " + "\(UIScreen.main.bounds.height)" + ", width: " + "\(UIScreen.main.bounds.width)" + " , iPad device.")
        }
        
        setupMapView()
        
        view.addSubview(descriptionTextView)
        
        setupLayout()
        setupBottomControls()
    }
    
    private func setupMapView() {
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
    }
    
    fileprivate func setupBottomControls() {
        //view.addSubview(previousButton)
        //previousButton.backgroundColor = .red
        //previousButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        //let yellowView = UIView()
        //yellowView.backgroundColor = .yellow
        
        //let greenView = UIView()
        //greenView.backgroundColor = .green
        
        //let blueView = UIView()
        //blueView.backgroundColor = .blue
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        //bottomControlsStackView.axis = .vertical
        view.addSubview(bottomControlsStackView)
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
                ])
        } else {
            NSLayoutConstraint.activate([
                bottomControlsStackView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor),
                bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
                ])
        }
    }
    
    private func setupLayout() {
        let topImageContainerView = UIView()
        view.addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topImageContainerView.addSubview(mapView)
        mapView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        
        //jokerImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.7).isActive = true
        mapView.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor).isActive = true
        
        //topImageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //topImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

