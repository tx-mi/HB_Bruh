//
//  Quest+CoreDataClass.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 14.07.2022.
//
//

import UIKit
import CoreData

@objc(Quest)
public class Quest: NSManagedObject {

    func fetchQuests() -> [Quest] {
        guard
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        else { return [] }
        
        return fetch(context)
    }
    
    func makeQuests() -> [Quest] {
        guard
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        else { return [] }
        
        let result = QuestsStorage.names.enumerated().map { index, name in
            makeQuest(name, index, context)
        }
        save(context)
        
        return result
    }
    
}

extension Quest {
    
    func makeQuest(
        _ name: String,
        _ index: Int,
        _ context: NSManagedObjectContext
    ) -> Quest {
        let quest = Quest(context: context)
        quest.name = name
        quest.id = Int32(index)
        quest.isCompleted = false
        return quest
    }
    
    func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetch(_ context: NSManagedObjectContext) -> [Quest] {
        let fetchRequest: NSFetchRequest<Quest> = Quest.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
}
