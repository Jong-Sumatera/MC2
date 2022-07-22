//
//  RecentFilesViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 22/07/22.
//

import Foundation
import CoreData

class RecentFilesViewModel: NSObject, ObservableObject {
    @Published var files: [FileViewModel] = [FileViewModel]()
    var fetchController: NSFetchedResultsController<File>!
    
    func getFiles() {
        let fetchRequest : NSFetchRequest<File> = File.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: File.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchRequest.fetchLimit = 3
        fetchController.delegate = self
        try? fetchController.performFetch()
        
        DispatchQueue.main.async { [self] in
            self.files = (fetchController.fetchedObjects ?? []).map(FileViewModel.init)
        }
    }
}

extension RecentFilesViewModel : NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.getFiles()
    }
}
