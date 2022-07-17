//
//  HighlightsListViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 17/07/22.
//

import Foundation
import CoreData

protocol HighlightsListViewModelDelegate: NSObject {
    func didChangeContent(_ highlights: [HighlightViewModel] )
}

class HighlightsListViewModel: NSObject, ObservableObject {
    var highlights: [HighlightViewModel] = [HighlightViewModel]()
    var fetchController: NSFetchedResultsController<Highlight>!
    var delegate: HighlightsListViewModelDelegate?

    func getHighLightsfromFile(fileVM: FileViewModel) {
        let fetchRequest : NSFetchRequest<Highlight> = Highlight.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "file == %@", fileVM.id)

        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: Highlight.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchController.delegate = self

        try? fetchController.performFetch()
        self.highlights = (fetchController.fetchedObjects ?? []).map(HighlightViewModel.init)

    }
}

extension HighlightsListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        try? controller.performFetch()
        self.highlights = (fetchController.fetchedObjects ?? []).map(HighlightViewModel.init)
        print("highlights", highlights.count)
        self.delegate?.didChangeContent(highlights)
    }
}
