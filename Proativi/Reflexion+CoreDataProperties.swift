//
//  Reflexion+CoreDataProperties.swift
//  Proativi
//
//  Created by Victor Falcetta do Nascimento on 02/02/20.
//  Copyright © 2020 Victor Falcetta do Nascimento. All rights reserved.
//
//

import Foundation
import CoreData


extension Reflexion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reflexion> {
        return NSFetchRequest<Reflexion>(entityName: "Reflexion")
    }

    @NSManaged public var titulo: String?
    @NSManaged public var descricao: String?

}
