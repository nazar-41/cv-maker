//
//  VM_SkillsView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI


class VM_SkillsView: ObservableObject{
    @AppStorage("skillsArray") var skillsArray: [SkillModel] = []
    
    @Published var openSheet: Bool = false
    
    var skillsInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Skills")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }
        .padding(.top, 5)
        .padding(.horizontal)
    }
    func removeSkill(id: String){
        
        if let index = skillsArray.firstIndex(where: {$0.id == id}) {
            skillsArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
    
    
}

