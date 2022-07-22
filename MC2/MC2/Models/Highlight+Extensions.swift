//
//  Highlight+Extensions.swift
//  MC2
//
//  Created by Widya Limarto on 15/07/22.
//

import Foundation
import CoreData

extension Highlight: BaseModel {
    static func getByText(text: String) -> [Highlight] {
        let request : NSFetchRequest<Highlight> = Highlight.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "fileName", ascending: true), NSSortDescriptor(key: "createdDate", ascending: false)]
        request.predicate = NSPredicate(format: "text CONTAINS[cd] %@", text)
        
        do {
            return try Highlight.context.fetch(request)
            
        }catch {
            print(error)
            return []
        }
    }
    
}
