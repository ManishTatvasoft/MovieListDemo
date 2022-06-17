//
//  Movies+CoreDataProperties.swift
//  
//
//  Created by PCQ229 on 17/06/22.
//
//

import Foundation
import CoreData


extension Movies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movies> {
        return NSFetchRequest<Movies>(entityName: "Movies")
    }

    @NSManaged public var movieName: String?
    @NSManaged public var time: Date?
    @NSManaged public var movieId: String?
    @NSManaged public var genre: String?
    @NSManaged public var posterPath: String?

}
