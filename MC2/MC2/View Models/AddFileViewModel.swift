//
//  AddFileViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 15/07/22.
//

import Foundation

class AddFileViewModel: ObservableObject {
    @Published var fileTitle: String = ""
    var bookmarkData: Data?
    var fileUrl: URL? {
        didSet {
            if fileUrl != nil {
                fileName = fileUrl!.lastPathComponent
                if fileTitle == "" {
                    fileTitle = fileName
                }
            }else if fileUrl == nil {
                fileTitle = ""
            }
        }
    }
    var fileName: String = ""
    
    func addFile() -> FileViewModel? {
        let files : [File]? = File.findBy(format: "fileUrl == %@", fileUrl! as CVarArg)
        if let files = files, files.count > 0  {
            return FileViewModel(file: files[0])
        }
        
        let newFile = File(context: File.context)
        newFile.id = UUID()
        newFile.createdDate = Date()
        newFile.modifiedDate = Date()
        newFile.fileUrl = fileUrl
        newFile.fileExt = fileUrl?.pathExtension
        newFile.fileTitle = fileTitle
        newFile.bookmarkData = bookmarkData
        let res = newFile.save()
        
        if res {
            return FileViewModel(file: newFile)
        }
        return nil
    }
}
