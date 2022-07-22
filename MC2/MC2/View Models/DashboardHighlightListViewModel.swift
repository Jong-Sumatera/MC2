//
//  DashboardHighlightListViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 22/07/22.
//

import Foundation
import CoreData

class DashboardHighlightListViewModel: NSObject, ObservableObject {
    @Published var highlights: [HighlightViewModel] = [HighlightViewModel]()
    @Published var search: String = ""
    @Published var tag : TagViewModel?
    
    var fetchController: NSFetchedResultsController<Highlight>!
    
    func getHighLights() {
        let fetchRequest : NSFetchRequest<Highlight> = Highlight.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
        
        var predicate = ""
        var args : [Any] = []
        
        if tag != nil {
//            predicate += "(ANY notes.tags.title == %@) \(search != "" ? "AND" : "")"
        predicate += "SUBQUERY(notes, $x, $x.tags.title CONTAINS %@).@count>0 \(search != "" ? "AND" : "")"
            args.append(tag?.title ?? "")
            
        }
        
        if search != "" {
            predicate += "(text CONTAINS[cd] %@ OR notes.text CONTAINS[cd] %@ OR fileName CONTAINS[cd] %@)"
            args.append(contentsOf: [search, search, search])
        }
        
        if predicate != "" {
            fetchRequest.predicate = NSPredicate(format: predicate, argumentArray: args)
        }

        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: Highlight.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchController.delegate = self

        try? fetchController.performFetch()
        self.highlights = (self.fetchController.fetchedObjects ?? []).map(HighlightViewModel.init)

    }
}

extension DashboardHighlightListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
//        try? controller.performFetch()
//        DispatchQueue.main.async { [self] in
//            self.highlights = (self.fetchController.fetchedObjects ?? []).map(HighlightViewModel.init)
//        }
        
    }
}
