//
//  VM_AddSkillsSheet.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI

class VM_AddSkillSheet: ObservableObject{
    
    @AppStorage("skillsArray") var skillsArray: [SkillModel] = []
    
    
    
    @Published var title: String = ""
    
    @Published var skillLevel: SkillLevel = .Basic
    
    
    var isSaveButtonDisabled: Bool{
        if title.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    func saveAddedSkill(){
        let data = SkillModel(skill: title, level: skillLevel.rawValue)
        
        skillsArray.append(data)
        
        
        title = ""
        skillLevel = .Basic
        
    }
    
    func endEditing() {
        UIApplication.shared.endEditing()
    }
}
