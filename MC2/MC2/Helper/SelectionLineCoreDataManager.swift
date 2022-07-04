//
//  SelectionLineCoreDataManager.swift
//  MC2
//
//  Created by Widya Limarto on 04/07/22.
//

import Foundation
import CoreData

class SelectionLineCoreDataManager {
    static var shared : SelectionLineCoreDataManager = SelectionLineCoreDataManager()
    
    let context : NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    func addLine(data: SelectionLine) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
