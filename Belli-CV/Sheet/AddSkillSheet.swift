//
//  AddSkillSheet.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI


struct AddSkillSheet: View{
    @StateObject var viewModel: VM_AddSkillSheet = VM_AddSkillSheet()
    
    @Environment(\.presentationMode) var presentationMode

    
    
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
                
                Text("Add skill")
                    .font(.system(size: 21, weight: .semibold))
                
                
                Spacer()
                
                Button {
                    viewModel.saveAddedSkill()
                    presentationMode.wrappedValue.dismiss()
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
                Section{
                    VStack(spacing: 0){
                        HStack{
                            Group{
                                Text("Title ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("Strategic planning", text: $viewModel.title)
                                .font(.system(size: 17))
                            
                        }
                        .padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 10)
                        
                        HStack{
                            Text("Level ")
                                .font(.system(size: 19))
                            
                            Spacer()
                            Menu {
                                Picker(selection: $viewModel.skillLevel) {
                                    ForEach(SkillLevel.allCases ,id: \.self) { value in
                                        Text(value.rawValue.capitalized)
                                            .tag(value)
                                    }
                                } label: {}
                            } label: {
                                Text(viewModel.skillLevel.rawValue)
                                    //.font(.custom("Franca-Book", size: 15))
                                    .frame(maxWidth: .infinity, alignment:.trailing)
                                    .padding(.leading, 20)
                                    .foregroundColor(Color("c_continue_button"))
                            }
                        }
                        .padding(.vertical, 10)


                    }
                }
            }
            .listStyle(GroupedListStyle())
            
        }
        .onTapGesture(perform: viewModel.endEditing)
    }

}

enum SkillLevel: String, CaseIterable, Identifiable{
    case Basic, Average, Proficient, Advanced, Expert
    
    var id: String {self.rawValue}
}
