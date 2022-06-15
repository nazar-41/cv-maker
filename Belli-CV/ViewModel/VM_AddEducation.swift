//
//  VM_AddEducation.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI



class VM_AddEducationSheet: ObservableObject{
    
    
    @AppStorage("educationArray") var educationArray: [EducationModel] = []

    
    
    @Published var institution: String = ""
    @Published var department: String = ""
    @Published var degreeStatus: String = ""
    
    
    @Published var isCurrentPosition: Bool = false

    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var gpa: String = ""
    
    @Published var showStartDatePicker: Bool = false
    @Published var showEndDatePicker: Bool = false
        
    
    var isSaveButtonDisabled: Bool{
        if institution.isEmpty || department.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    func saveAddedEducation(){
        let data = EducationModel(institution: institution, department: department, degreeStatus: degreeStatus, isCurrentPosition: isCurrentPosition, startDate: startDate, endDate: isCurrentPosition ? nil : endDate, gpa: gpa)
        
        educationArray.append(data)
                
        institution = ""
        department = ""
        degreeStatus = ""
        isCurrentPosition = false
        startDate = .now
        endDate = .now
        gpa = ""
        
    }
    func endEditing() {
        UIApplication.shared.endEditing()
    }
}
