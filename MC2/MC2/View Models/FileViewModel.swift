//
//  FileViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 16/07/22.
//

import Foundation
import CoreData

struct FileViewModel {
    var file: File
    
    var id: NSManagedObjectID {
        return file.objectID
    }
    
    var fileId: UUID? {
        return file.id ?? nil
    }
    
    var fileTitle: String {
        return file.fileTitle ?? ""
    }
    
    var fileExt: String {
        return file.fileExt ?? "pdf"
    }
    
    var fileUrl: URL? {
        return file.fileUrl ?? nil
    }
    
    var fileName: String {
        return file.fileUrl?.lastPathComponent ?? ""
    }
    
    var bookmarkData: Data? {
        return file.bookmarkData
    }
}
