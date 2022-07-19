//
//  NotesListViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 19/07/22.
//

import Foundation
import CoreData

class NotesListViewModel: NSObject, ObservableObject {
    @Published var notes: [NoteViewModel] = [NoteViewModel]()
    var fetchController: NSFetchedResultsController<Note>!
    
    func getNotesFromHighlight(highlightVM: HighlightViewModel) {
        let fetchRequest : NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "highlight == %@", highlightVM.id)

        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: Highlight.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchController.delegate = self

        try? fetchController.performFetch()
        self.notes = (fetchController.fetchedObjects ?? []).map(NoteViewModel.init)

    }
}

extension NotesListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        try? controller.performFetch()
        self.notes = []
        self.notes = (fetchController.fetchedObjects ?? []).map(NoteViewModel.init)
    }
}
