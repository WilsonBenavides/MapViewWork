//
//  Extensions.swift
//  MapViewWork
//
//  Created by willix on 24/05/18.
//  Copyright © 2018 willix. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictinary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictinary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictinary))
    }
}

extension UIColor {
    static var statusBarColor = UIColor.rgb(red: 43, green: 113, blue: 143)
    static var navigationBarColor = UIColor.rgb(red: 50, green: 129, blue: 162)
    static var iconBarColor = UIColor.rgb(red: 191, green: 230, blue: 247)
    static var iconDarkBarColor = UIColor.rgb(red: 32, green: 53, blue: 62)
    static var separatorColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
}

let imageCache = NSCache<NSString, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler:  { (data, responses, error) in
            
            if error != nil {
                print(error ?? "error handling")
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                
                
            }
            
        }).resume()
    }
}
