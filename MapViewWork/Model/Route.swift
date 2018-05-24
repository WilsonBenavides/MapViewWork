//
//  Route.swift
//  MapViewWork
//
//  Created by willix on 24/05/18.
//  Copyright © 2018 willix. All rights reserved.
//
import UIKit

internal struct Key {
    static let name = "name"
    static let headerText = "headerText"
    static let bodyText = "bodyText"
    static let zoom = "zoom"
}

struct Route {
    //static let defaultCover = UIImage(named: "book.jpg")!
    var id:Int
    var name:String
    var headerText:String
    var bodyText:String
    var zoom:Double
    
    init(name:String,headerText:String,bodyText:String,zoom:Double, id:Int) {
        self.name = name
        self.headerText = headerText
        self.bodyText = bodyText
        self.zoom = zoom
        self.id = id
    }
    
    init?(rs:FMResultSet) {
        let zoom = rs.double(forColumn: Key.zoom)
        let id = rs.int(forColumn: "ROWID")
        guard let name = rs.string(forColumn: Key.name),
            let headerText = rs.string(forColumn: Key.headerText),
            let bodyText = rs.string(forColumn: Key.bodyText)
        else { return nil }
            
        self.init(name:name,
                  headerText:headerText,
                  bodyText:bodyText,
                  zoom:zoom,
                  id:Int(id)
        )
    }
}
