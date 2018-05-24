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
        
        //setupBottomControls()
    }    
}



