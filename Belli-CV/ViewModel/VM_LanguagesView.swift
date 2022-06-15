//
//  VM_LanguagesView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI


class VM_LanguagesView: ObservableObject{
    
    
    @AppStorage("languagesArray") var languagesArray: [LanguageModel] = []
    
    @Published var openSheet: Bool = false
    
    
    var languagesInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Languages")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }
        .padding(.top, 5)
        .padding(.horizontal)
        
    }
    
    
    func removeLanguage(id: String){
        
        if let index = languagesArray.firstIndex(where: {$0.id == id}) {
            languagesArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
    
    
}
