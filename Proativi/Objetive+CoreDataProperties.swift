//
//  Objetive+CoreDataProperties.swift
//  Proativi
//
//  Created by Victor Falcetta do Nascimento on 02/02/20.
//  Copyright © 2020 Victor Falcetta do Nascimento. All rights reserved.
//
//

import Foundation
import CoreData


extension Objetive {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Objetive> {
        return NSFetchRequest<Objetive>(entityName: "Objetive")
    }

    @NSManaged public var titulo: String?
    @NSManaged public var descricao: String?
    @NSManaged public var hora: String?
    @NSManaged public var prioridade: Int32

}
