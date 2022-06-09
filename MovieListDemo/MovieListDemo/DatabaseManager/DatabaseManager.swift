//
//  DatabaseManager.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import Foundation

import Foundation
import FMDB

final class DatabaseManager {
    static let dataBaseFileName = "MovieDB.db"
    static var database: FMDatabase!
    static let shared : DatabaseManager = {
        let instance = DatabaseManager()
        return instance
    }()
    func createDatabase(){
        let bundlePath = Bundle.main.path(forResource: "MovieDB", ofType: ".db")
        print(bundlePath ?? "","\n") //prints the correct path
        guard let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else{
            return
        }
        let fileManager = FileManager.default
        let fullDestPath = URL(fileURLWithPath: destPath).appendingPathComponent("MovieDB.db")
        let fullDestPathString = fullDestPath.path
        
        if fileManager.fileExists(atPath : fullDestPathString){
            print("File is available")
            DatabaseManager.database = FMDatabase(path: fullDestPathString)
            openDataBase()
            print(fullDestPathString)
        }
        else{
            do{
                try fileManager.copyItem(atPath: bundlePath!, toPath: fullDestPathString)
                if fileManager.fileExists(atPath : fullDestPathString){
                    DatabaseManager.database = FMDatabase(path: fullDestPathString)
                    openDataBase()
                    print("file is copy")
                }
                else{
                    print("file is not copy")
                }
            }
            catch{
                print("\n")
                print(error)
            }
        }
    }
    
    func openDataBase(){
        if DatabaseManager.database != nil{
            DatabaseManager.database.open()
        }else{
            DatabaseManager.shared.createDatabase()
        }
    }
    
    func closeDataBase(){
        if DatabaseManager.database != nil{
            DatabaseManager.database.close()
        }else{
            DatabaseManager.shared.createDatabase()
        }
    }
    
    func insertData(_ data: Movie) -> Bool{
        DatabaseManager.database.open()
        let isSave = DatabaseManager.database.executeUpdate("INSERT INTO MovieTable(movieName,movieID,posterPath,time,genre) VALUES(?,?,?,?,?)", withArgumentsIn: [data.movieName,data.movieID,data.posterPath,data.time, data.genre])
        DatabaseManager.database.close()
        return isSave
    }
    
    func getData()-> [Movie]{
        DatabaseManager.database.open()
        let resultset : FMResultSet!  = DatabaseManager.database.executeQuery("SELECT * FROM MovieTable", withArgumentsIn: [0])
        var itemInfo : [Movie] = []
        if (resultset != nil){
            while (resultset?.next())!{
                var item : Movie = Movie()
                item.id = Int((resultset?.int(forColumn: "id") ?? 0))
                item.movieName = String((resultset?.string(forColumn: "movieName") ?? ""))
                item.movieID = String((resultset?.int(forColumn: "movieID") ?? 0))
                item.posterPath = String((resultset?.string(forColumn: "posterPath") ?? ""))
                item.time = String((resultset?.string(forColumn: "time") ?? ""))
                item.genre = String((resultset?.string(forColumn: "genre") ?? ""))
                itemInfo.append(item)
            }
        }
        DatabaseManager.database.close()
        return itemInfo
    }
    
    func checkAndInserData(_ data: Movie){
        let allMoviedata = getData()
        
        var isContainData = false
        
        allMoviedata.forEach { movie in
            if data.movieID == movie.movieID{
                isContainData = true
                return
            }
        }
        if !isContainData{
            let isSave = insertData(data)
            print(isSave)
        }else{
            print("movie already present")
            let isDeleted = deleteRecord(data: data)
            print("Movie Deleted \(isDeleted)")
            let isSave = insertData(data)
            print("Movie Saved \(isSave)")
        }
    }
    
    func deleteRecord(data: Movie) -> Bool {
        DatabaseManager.database.open()
        let isDelete = DatabaseManager.database.executeUpdate("DELETE FROM MovieTable WHERE movieID = ?", withArgumentsIn: [data.movieID])
        DatabaseManager.database.close()
        return isDelete
    }
    
}
