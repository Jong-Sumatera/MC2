//
//  File.swift
//  MC2
//
//  Created by Clara Evangeline on 03/07/22.
//

import Foundation

class SearchObservableObject: ObservableObject {
    @Published var searchFilesResults: [File] = []
    @Published var searchTagsResults: [Tag] = []
}


