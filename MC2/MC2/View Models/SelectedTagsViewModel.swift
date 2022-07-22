//
//  SelectedTagsViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 21/07/22.
//

import Foundation

class SelectedTagsViewModel : ObservableObject {
    @Published var selectedTags: [String:TagViewModel] = [:]
    
    func addSelected(tag: TagViewModel){
        selectedTags[tag.title] = tag
    }
    
    func removeSelected(tag: TagViewModel) {
        selectedTags.removeValue(forKey: tag.title)
    }
}
