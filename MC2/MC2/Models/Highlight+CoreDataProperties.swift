//
//  Highlight+CoreDataProperties.swift
//  MC2
//
//  Created by Widya Limarto on 17/07/22.
//
//

import Foundation
import CoreData
import UIKit

extension Highlight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Highlight> {
        return NSFetchRequest<Highlight>(entityName: "Highlight")
    }

    @NSManaged public var color: UIColor?
    @NSManaged public var createdDate: Date?
    @NSManaged public var fileName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var comments: NSSet?
    @NSManaged public var file: File?
    @NSManaged public var selectionLines: NSSet?
    @NSManaged public var translation: Translation?

}

// MARK: Generated accessors for comments
extension Highlight {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}

// MARK: Generated accessors for selectionLines
extension Highlight {

    @objc(addSelectionLinesObject:)
    @NSManaged public func addToSelectionLines(_ value: SelectionLine)

    @objc(removeSelectionLinesObject:)
    @NSManaged public func removeFromSelectionLines(_ value: SelectionLine)

    @objc(addSelectionLines:)
    @NSManaged public func addToSelectionLines(_ values: NSSet)

    @objc(removeSelectionLines:)
    @NSManaged public func removeFromSelectionLines(_ values: NSSet)

}

extension Highlight : Identifiable {

}
