//
//  BaseModel.swift
//  MC2
//
//  Created by Widya Limarto on 15/07/22.
//

import Foundation
import CoreData

protocol BaseModel: NSManagedObject {
    func save() -> Bool
    func delete()
    static func byId<T: NSManagedObject>(id: NSManagedObjectID) -> T?
    static func all<T: NSManagedObject>() -> [T]
}

extension BaseModel {
    static var context: NSManagedObjectContext {
        PersistenceController.shared.container.viewContext
    }
    
    func save() -> Bool {
        do {
            try Self.context.save()
            return true
        }catch {
            Self.context.rollback()
            print(error)
            return false
        }
    }
    
    func delete() {
        Self.context.delete(self)
        save()
    }
    
    static func byId<T: NSManagedObject>(id: NSManagedObjectID) -> T? {
        do{
            return try Self.context.existingObject(with: id) as? T
        } catch {
            return nil
        }
    }
    
    static func findBy<T>(format: String, _ args: CVarArg...) -> [T] where T: NSManagedObject {
        let fetchRequest : NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        fetchRequest.predicate = NSPredicate(format: format, args)
        print(format, fetchRequest)
        do {
            let objs: [T]? = try Self.context.fetch(fetchRequest)
            guard let objs = objs, objs.count > 0 else {
                return []
            }
            return objs
        } catch {
            print(error)
            return []
        }
    }
    
    static func all<T>() -> [T] where T: NSManagedObject {
        let fetchRequest : NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        do {
            return try Self.context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}
