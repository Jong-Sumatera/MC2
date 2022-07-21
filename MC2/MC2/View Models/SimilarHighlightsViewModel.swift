//
//  SimilarHighlightsViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 21/07/22.
//

import Foundation

class SimilarHighlightsViewModel: ObservableObject {
    @Published var similarHighlights: [HighlightViewModel] = []
    
    func getSimilarHighlights(text: String, currentHighlight: HighlightViewModel) {
        DispatchQueue.main.async {
            self.similarHighlights = Highlight.getByText(text: text).map(HighlightViewModel.init).filter{
                $0.id != currentHighlight.id &&
                $0.fileName != currentHighlight.fileName &&
                $0.notes.count > 0
            }
        }
        
    }
}
