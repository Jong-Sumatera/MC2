//
//  Highlight+CoreDataProperties.swift
//  MC2
//
//  Created by Widya Limarto on 20/07/22.
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
    @NSManaged public var isShowOnWatch: Bool
    @NSManaged public var isPinned: Bool
    @NSManaged public var file: File?
    @NSManaged public var notes: NSSet?
    @NSManaged public var selectionLines: NSSet?
    @NSManaged public var translation: Translation?

}

// MARK: Generated accessors for notes
extension Highlight {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

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
