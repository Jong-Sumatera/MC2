//
//  Translation+Extensions.swift
//  MC2
//
//  Created by Widya Limarto on 17/07/22.
//

import Foundation
import CoreData

extension Translation: BaseModel {
    static func findByText(text: String) -> Translation? {
        let fr : NSFetchRequest<Translation> = NSFetchRequest(entityName: String(describing: Translation.self))
        fr.predicate = NSPredicate(format: "text == %@", text)
        do{
           let res = try Translation.context.fetch(fr)
            if res.count > 0 {
                        return res[0] as? Translation
                    } else {
                        return nil
                    }
        }catch {
            print(error)
            return nil
        }
        return nil
    }
}
