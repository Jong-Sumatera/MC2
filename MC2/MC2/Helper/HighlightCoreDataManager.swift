//
//  HighlightCoreDataManager.swift
//  MC2
//
//  Created by Widya Limarto on 04/07/22.
//

import Foundation
import CoreData

class HighlightCoreDataManager {
    static var shared : HighlightCoreDataManager = HighlightCoreDataManager()
    
    let context : NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    func addHighlight(data: Highlight) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
