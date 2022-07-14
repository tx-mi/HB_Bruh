//
//  Quest+CoreDataProperties.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 14.07.2022.
//
//

import Foundation
import CoreData


extension Quest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quest> {
        return NSFetchRequest<Quest>(entityName: "Quest")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var isCompleted: Bool

}

extension Quest : Identifiable {

}
