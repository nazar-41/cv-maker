//
//  AddLanguageSheet.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI


struct AddLanuageSheet: View{
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: VM_AddLanguageSheet = VM_AddLanguageSheet()

    
    
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
                
                Text("Add language")
                    .font(.system(size: 21, weight: .semibold))
                
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                    viewModel.addLanguage()
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
                                Text("Language ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("English", text: $viewModel.language)
                                .font(.system(size: 17))
                            
                        }
                        .padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 10)
                        
                        HStack{
                            Text("Level ")
                                .font(.system(size: 19))
                            
                            Spacer()
                            Menu {
                                Picker(selection: $viewModel.languageLevel) {
                                    ForEach(LanguageLevel.allCases ,id: \.self) { value in
                                        Text(value.rawValue.capitalized)
                                            .tag(value)
                                    }
                                } label: {}
                            } label: {
                                Text(viewModel.languageLevel.rawValue)
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

enum LanguageLevel: String, CaseIterable, Identifiable{
    case Beginner
    case Elementary
    case Intermediate
    case Upper_Intermediate = "Upper Intermediate"
    case Advanced
    case Proficient
    case Native
    
    var id: String {self.rawValue}
}
