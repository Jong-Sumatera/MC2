//
//  Tag+Extension.swift
//  MC2
//
//  Created by Widya Limarto on 21/07/22.
//

import Foundation
import CoreData

extension Tag: BaseModel {
    static func byNote(note: Note) -> [Tag] {
        let request : NSFetchRequest<Tag> = Tag.fetchRequest()
        request.predicate = NSPredicate(format: "notes.id CONTAINS %@", note.id! as CVarArg)
        
        do {
            return try Tag.context.fetch(request)
            
        }catch {
            print(error)
            return []
        }
    }
}
