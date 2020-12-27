//
//  DatabaseHelper.swift
//  Tranxit Task
//
//  Created by Shyam Kumar on 10/9/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        
        guard let entityName = T.entity().name else { return nil}
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else {return nil}
        let object = T(entity: entity, insertInto: viewContext)
        
        return object
    }

    func save() {
        
        do {
            try viewContext.save()
        } catch {
            print("error saving", error.localizedDescription)
        }
    }

    func fetch<T : NSManagedObject>(_ type: T.Type) -> [T] {
        
        let fetchRequest = T.fetchRequest()
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            return result as! [T]
        } catch {
            print("error fetching", error.localizedDescription)
            return []
        }
        
    }
    
    func delete<T: NSManagedObject>(object: T) {
        viewContext.delete(object)
        save()
    }
    
    
}

