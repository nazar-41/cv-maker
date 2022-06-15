//
//  VM_AddHobbiesHeet.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI


class VM_AddHobbiesSheet: ObservableObject{
    @AppStorage("hobbiesArray") var hobbiesArray: [HobbiesModel] = []
    
    
    
    @Published var hobby: String = ""
    
    
    var isSaveButtonDisabled: Bool{
        if hobby.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    func saveHobby(){
        let data = HobbiesModel(hobby: hobby)
        hobbiesArray.append(data)
        hobby = ""
    }
    
    func endEditing() {
        UIApplication.shared.endEditing()
    }
}
