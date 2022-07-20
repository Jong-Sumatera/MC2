//
//  Translation+CoreDataProperties.swift
//  MC2
//
//  Created by Widya Limarto on 20/07/22.
//
//

import Foundation
import CoreData


extension Translation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Translation> {
        return NSFetchRequest<Translation>(entityName: "Translation")
    }

    @NSManaged public var createdDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var translationText: String?
    @NSManaged public var highlights: NSSet?

}

// MARK: Generated accessors for highlights
extension Translation {

    @objc(addHighlightsObject:)
    @NSManaged public func addToHighlights(_ value: Highlight)

    @objc(removeHighlightsObject:)
    @NSManaged public func removeFromHighlights(_ value: Highlight)

    @objc(addHighlights:)
    @NSManaged public func addToHighlights(_ values: NSSet)

    @objc(removeHighlights:)
    @NSManaged public func removeFromHighlights(_ values: NSSet)

}

extension Translation : Identifiable {

}
