//
//  AddHobbySheet.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI

struct AddHobbySheet: View{
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = VM_AddHobbiesSheet()

    var body: some View{
        VStack(spacing: 0){
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("c_continue_button"))
                        .font(.system(size: 20, weight: .semibold))
                        .frame(width: 50, alignment: .leading)
                }
                
                Spacer()
                
                Text("Add hobby")
                    .font(.system(size: 21, weight: .semibold))
                
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()

                    viewModel.saveHobby()
                } label: {
                    Text("Save")
                        .foregroundColor(viewModel.isSaveButtonDisabled ? Color("c_continue_button").opacity(0.5) : Color("c_continue_button"))
                        .font(.system(size: 20))
                        .frame(width: 50)
                }.disabled(viewModel.isSaveButtonDisabled)
            }
            .padding()
            
            Divider()
            
            List{
                Section(header: Text("summary")){
                    VStack(spacing: 0){
                        
                        TextField("Football", text: $viewModel.hobby)
                            .font(.system(size: 19))
                        
                            .padding(.vertical, 10)
                        
                    }
                }
            }
            .listStyle(GroupedListStyle())
            
        }
        .onTapGesture(perform: viewModel.endEditing)
    }

}

