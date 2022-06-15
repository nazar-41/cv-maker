//
//  VM_CareerObjective.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI

class VM_DetailsCareerObjectiveView: ObservableObject{
    @AppStorage("position") var position: String = ""
    @AppStorage("personalStatement") var personalStatement: String = ""
    
    var personalStatementTextfieldPlaceholder = "A conscientious and professional sales manager with extensive experience in sales and strategic planning currently seeking a new position as a Marketing Director."
    
    
    var positionInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Position")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }.padding(.vertical, 5)
    }
    var personalStatementInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Personal Statement")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }.padding(.vertical, 5)
    }
    
    func endEditing() {
        UIApplication.shared.endEditing()
    }
    
}
