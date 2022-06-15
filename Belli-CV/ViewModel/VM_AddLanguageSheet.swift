//
//  VM_AddLanguageSheet.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI

class VM_AddLanguageSheet: ObservableObject{
    
    @AppStorage("languagesArray") var languagesArray: [LanguageModel] = []
    
    
    @Published var language: String = ""
    
    @Published var languageLevel: LanguageLevel = .Beginner
    
    
    var isSaveButtonDisabled: Bool{
        if language.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    func addLanguage(){
        let data = LanguageModel(language: language, level: languageLevel.rawValue)
        
        languagesArray.append(data)
        
        
        language = ""
        languageLevel = .Beginner
    }
    
    func endEditing() {
        UIApplication.shared.endEditing()
    }
    
}
