//
//  TagViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 21/07/22.
//

import Foundation
import CoreData

struct TagViewModel {
    var tag : Tag
    
    init(_ model: Tag) {
        tag = model
    }
    
    init(title: String) {
        let newTag = Tag(context: Tag.context)
        newTag.id = UUID()
        newTag.createdDate = Date()
        newTag.title = title
        tag = newTag
    }
    
    var id: NSManagedObjectID {
        return tag.objectID
    }
    
    var tagId: UUID? {
        return tag.id
    }
    
    var title: String {
        return tag.title ?? ""
    }
    
    var createdDate: Date {
        return tag.createdDate ?? Date()
    }
    
    var isSelected: Bool = false
}
