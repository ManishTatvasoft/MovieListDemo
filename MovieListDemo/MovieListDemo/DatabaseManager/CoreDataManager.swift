//
//  CoreDataManager.swift
//  MovieListDemo
//
//  Created by PCQ229 on 15/06/22.
//

import Foundation
import CoreData

final class CoreDataManager{
    
    static let shared = CoreDataManager()
    let context = AppManager.appDelegate?.persistentContainer.viewContext
    
    func getData() -> [Movies]{
        let fetchRequest: NSFetchRequest<Movies> = Movies.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "time", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 10
        guard let context = context else {
            return []
        }
        do{
            let data = try context.fetch(fetchRequest)
            return data
        }catch let error{
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func addDataToDb(_ result: Results){
        checkAndSavedata(result.id ?? 0, result)
        
    }
    
    func checkAndSavedata(_ id: Int, _ data: Results?, completion: (() -> ())? = nil){
        var success = false
        let fetchRequest: NSFetchRequest<Movies> = Movies.fetchRequest()
        let pred = NSPredicate(format: "movieId CONTAINS %@", "\(id)")
        fetchRequest.predicate = pred
        guard let context = context else {
            completion?()
            return
        }
        do {
            let getId = try context.fetch(fetchRequest)
            if getId.count >= 1{
                success = true
            }
        }catch let error{
            print(error.localizedDescription)
        }
        if !success{
            saveData(data) {
                completion?()
            }
        }else{
            deleteData(data) {
                self.saveData(data) {
                    completion?()
                }
            }

            
        }
    }
    
    func saveData(_ data: Results?, completion: (() -> ())? = nil){
        guard let data = data else {
            completion?()
            return
        }
        guard let context = context else {
            completion?()
            return
        }
        let movies = Movies(context: context)
        movies.movieName = data.title ?? ""
        movies.movieId = "\(String(describing: data.id ?? 0))"
        movies.posterPath = data.poster_path ?? ""
        movies.time = Date()
        movies.genre = AppConstants.getGenreString(data)
        do{
            _ = try context.save()
            completion?()
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func deleteData(_ movie: Results?, completion: (() -> ())? = nil){
        let fetchRequest: NSFetchRequest<Movies> = Movies.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "movieId CONTAINS %@", "\(movie?.id ?? 0)")
        guard let context = context else {
            completion?()
            return
        }
        do {
            let getId = try context.fetch(fetchRequest)
            if getId.count >= 1{
                getId.forEach { movie in
                    context.delete(movie)
                }
                completion?()
            }
        }catch let error{
            print(error.localizedDescription)
            completion?()
        }
    }
}
