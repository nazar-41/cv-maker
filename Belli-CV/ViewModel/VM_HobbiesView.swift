//
//  VM_HobbiesView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI

class VM_HobbiesView: ObservableObject{
    
    @AppStorage("hobbiesArray") var hobbiesArray: [HobbiesModel] = []
    
    
    @Published var openSheet: Bool = false
    
    
    var hobbiesInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Hobbies & Interests")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
    
     func removeHobby(id: String){
        if let index = hobbiesArray.firstIndex(where: {$0.id == id}) {
            hobbiesArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
    
}
