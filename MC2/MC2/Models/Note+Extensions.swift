//
//  Note+Extensions.swift
//  MC2
//
//  Created by Widya Limarto on 19/07/22.
//

import Foundation
import CoreData

extension Note: BaseModel {
    static func getNotesByHighlight(highlight: Highlight) -> [Note] {
        let request : NSFetchRequest<Note> = Note.fetchRequest()

        request.predicate = NSPredicate(format: "highlight.id CONTAINS[cd] %@", highlight.id! as CVarArg)
        request.fetchLimit = 3

        do {
            return try Note.context.fetch(request)

        }catch {
            print(error)
            return []
        }
    }
}
