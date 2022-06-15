//
//  VM_EducationView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI


class VM_EducationView: ObservableObject{
    
    @AppStorage("educationArray") var educationArray: [EducationModel] = []

    
    
    @Published var openSheet: Bool = false
        
    var educationInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Education")
                .font(.title)
                .fontWeight(.semibold)
            
            Divider()
            
        }
        .padding(.top, 5)
        .padding(.horizontal)

    }
    
    func removeWorkPlace(id: String){
        
        if let index = educationArray.firstIndex(where: {$0.id == id}) {
            educationArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
    
    
}
