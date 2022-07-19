//
//  TranslationViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 17/07/22.
//

import Foundation
import CoreData

struct TranslationViewModel {
    var translation: Translation
    
    var id: NSManagedObjectID {
        return translation.objectID
    }
    
    var translationId: UUID? {
        return translation.id ?? nil
    }
    
    var createdDate: Date {
        return translation.createdDate ?? Date()
    }
    
    var text: String {
        return translation.text ?? ""
    }
    
    var translationText: String {
        return translation.translationText ?? ""
    }
    
}
