//
//  VM_AddPlaceOfWork.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI

class VM_AddPlaceOfWork: ObservableObject{
    
    @AppStorage("workedPlacesArray") var workedPlacesArray: [WorkedPlaceModel] = []
    
    @Published var companyName: String = ""
    @Published var position: String = ""
    @Published var website: String = ""
    
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    
    @Published var isCurrentPosition: Bool = false
    
    @Published var showStartDatePicker: Bool = false
    @Published var showEndDatePicker: Bool = false
    
    
    var isSaveButtonDisabled: Bool{
        if companyName.isEmpty || position.isEmpty{
            return true
        }else{
            return false
        }
    }

    func saveAddedWorkPlace(){
        
        let workedPlace = WorkedPlaceModel(company: companyName, position: position, website: website, isCurrentPosition: isCurrentPosition, startDate: startDate, endDate: isCurrentPosition ? nil : endDate)
        
        workedPlacesArray.append(workedPlace)
        
        
        companyName = ""
        position = ""
        website = ""
        startDate = .now
        endDate = .now
        isCurrentPosition = false
        
    }
    
    func endEditing() {
        UIApplication.shared.endEditing()
    }
}
