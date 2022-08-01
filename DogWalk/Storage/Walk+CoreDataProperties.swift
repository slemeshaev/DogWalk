//
//  Walk+CoreDataProperties.swift
//  DogWalk
//
//  Created by Stanislav Lemeshaev on 31.07.2022.
//  Copyright © 2022 slemeshaev. All rights reserved.
//
//

import Foundation
import CoreData


extension Walk {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Walk> {
        return NSFetchRequest<Walk>(entityName: "Walk")
    }
    
    @NSManaged public var date: Date?
    @NSManaged public var dog: Dog?
    
}

extension Walk : Identifiable {
    
}
