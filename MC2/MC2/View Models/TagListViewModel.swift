//
//  TagListViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 21/07/22.
//

import Foundation
import CoreData

class TagListViewModel: NSObject, ObservableObject {
    
    @Published var tags: [TagViewModel] = [TagViewModel]()
    var fetchController: NSFetchedResultsController<Tag>!
    
    func getTags() {
        let fetchRequest : NSFetchRequest<Tag> = Tag.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "notes.@count != 0")
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: Tag.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchController.delegate = self
        try? fetchController.performFetch()
        
        DispatchQueue.main.async { [self] in
            self.tags = (fetchController.fetchedObjects ?? []).map(TagViewModel.init)
        }
    }
}

extension TagListViewModel : NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.getTags()
    }
}
