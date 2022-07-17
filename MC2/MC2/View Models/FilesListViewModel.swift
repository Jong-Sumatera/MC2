//
//  FilesListViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 16/07/22.
//

import Foundation
import CoreData

class FilesListViewModel: NSObject, ObservableObject {
    @Published var search: String = ""
    @Published var files: [FileViewModel] = [FileViewModel]()
    var fetchController: NSFetchedResultsController<File>!
    
    func getFiles() {
        let fetchRequest : NSFetchRequest<File> = File.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
        if search != "" {
            fetchRequest.predicate = NSPredicate(format: "fileTitle CONTAINS[cd] %@ OR fileUrl CONTAINS[cd] %@", search, search)
        }
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: File.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchController.delegate = self
        try? fetchController.performFetch()
        
        DispatchQueue.main.async { [self] in
            self.files = (fetchController.fetchedObjects ?? []).map(FileViewModel.init)
        }
    }
}

extension FilesListViewModel : NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.getFiles()
    }
}
