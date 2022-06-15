//
//  VM_ProfessionalExperience.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI

class VM_ProfessionalExperience: ObservableObject{
    
    
    @AppStorage("workedPlacesArray") var workedPlacesArray: [WorkedPlaceModel] = []

    @Published var openSheet: Bool = false
    

    
    var experienceInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Experience")
                .font(.title)
                .fontWeight(.semibold)
            Divider()
            
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
    
    func removeWorkPlace(id: String){
        
        if let index = workedPlacesArray.firstIndex(where: {$0.id == id}) {
            workedPlacesArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
}
