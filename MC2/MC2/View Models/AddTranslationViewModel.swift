//
//  AddTranslationViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 17/07/22.
//

import Foundation

class AddTranslationViewModel {
    var text: String = ""
    var translationText: String = ""
    
    func addTranslation() -> TranslationViewModel? {
        let translation = Translation(context: Translation.context)
        translation.text = text
        translation.translationText = translationText
        translation.createdDate = Date()
        translation.id = UUID()
        let res = translation.save()
        if res {
            return TranslationViewModel(translation: translation)
        } else {
            return nil
        }
    }
    

}
