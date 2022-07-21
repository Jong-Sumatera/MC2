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
        
        request.predicate = NSPredicate(format: "text CONTAINS[cd] %@", text)
        request.fetchLimit = 5
        
        do {
            return try Highlight.context.fetch(request)
            
        }catch {
            print(error)
            return []
        }
    }
    
}
