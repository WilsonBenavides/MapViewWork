//
//  RoutsManager.swift
//  MapViewWork
//
//  Created by willix on 24/05/18.
//  Copyright © 2018 willix. All rights reserved.
//

import Foundation

private var appSupportDirectory:URL = {
    let url = FileManager().urls(for:.applicationSupportDirectory,in: .userDomainMask).first!
    if !FileManager().fileExists(atPath: url.path) {
        do {
            try FileManager().createDirectory(at: url,
                                              withIntermediateDirectories: false)
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    return url
}()

private var booksFile:URL = {
    let filePath = appSupportDirectory.appendingPathComponent("Route").appendingPathExtension("db")
    print(filePath)
    if !FileManager().fileExists(atPath: filePath.path) {
        if let bundleFilePath = Bundle.main.resourceURL?.appendingPathComponent("Route").appendingPathExtension("db") {
            do {
                try FileManager().copyItem(at: bundleFilePath, to: filePath)
            } catch let error as NSError {
                //fingers crossed
                print("\(error.localizedDescription)")
            }
        }
    }
    return filePath
}()

class BooksManager {
    private lazy var books:[Route] = self.loadBooks()

    var bookCount:Int {return books.count}
    func getBook(at index:Int)->Route {
        return books[index]
    }
    
    private func loadBooks()->[Route] {
        //print("testint loadBooks function... \(books[0].name)")
        return retrieveBooks() ?? []
    }
    
    func addBook(_ book:Route) {
        var book = book
        SQLAddBook(book: &book)
        books.append(book)
    }
    
    func updateBook(at index:Int, with book:Route) {
        SQLUpdateBook(book: book)
        books[index] = book
    }
    
    func removeBook(at index:Int) {
        let bookToRemove = books.remove(at: index)
        SQLRemoveBook(book: bookToRemove)
    }
    
    private func sampleBooks()->[Route] {
        return [
            Route(name: "aaaa", headerText: "bbbbbb", bodyText: "ccccccc", zoom: 12, id: 1),
            Route(name: "dddddd", headerText: "eeeeee", bodyText: "ffffff", zoom: 12, id: 1)
            //More books
        ]
    }
    
    func getOpenDB()->FMDatabase? {
        let db = FMDatabase(path: booksFile.path)
        guard db.open() else {
            print("Unable to open database")
            return nil
        }
        return db
    }
    
    //MARK: SQLite
    func retrieveBooks() -> [Route]? {
        guard let db = getOpenDB() else { return nil }
        var books:[Route] = []
        do {
            let rs = try db.executeQuery(
                "SELECT *, ROWID FROM BusRoute", values: nil)
            while rs.next() {
                if let book = Route(rs: rs) {
                    books.append(book)
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        db.close()
        return books
    }
    
    func SQLAddBook(book:inout Route) {
        guard let db = getOpenDB() else { return }
        do {
            try db.executeUpdate(
                "insert into BusRoute (name, headerText, bodyText, zoom) values (?, ?, ?, ?)",
                values: [book.name, book.headerText, book.bodyText, book.zoom]
            )
            book.id = Int(db.lastInsertRowId)
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        db.close()
    }
    
    func SQLRemoveBook(book:Route) {
        guard let db = getOpenDB() else { return }
        do {
            try db.executeUpdate(
                "delete from BusRoute where ROWID = ?",
                values: [book.id]
            )
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        db.close()
    }
    
    func SQLUpdateBook(book:Route) {
        guard let db = getOpenDB() else { return }
        do {
            try db.executeUpdate(
                "update BusRoute SET name = ?, headerText = ?, bodyText = ?, zoom = ? WHERE ROWID = ?", values: [book.name, book.headerText, book.bodyText, book.zoom, book.id]
            )
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        db.close()
    }
}

