//
//  AddEducationSheet.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI

struct AddEducationSheet: View{
    @StateObject var viewModel: VM_AddEducationSheet = VM_AddEducationSheet()
    
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
                
                Text("Add education")
                    .font(.system(size: 21, weight: .semibold))
                
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                    viewModel.saveAddedEducation()
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
                Section(header: Text("info")) {
                    VStack(spacing: 0){
                        HStack{
                            Group{
                                Text("Institution ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("Boston University", text: $viewModel.institution)
                                .font(.system(size: 17))
                            
                        }
                        
                        .padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 3)
                        
                        HStack{
                            Group{
                                Text("Department ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("Economics", text: $viewModel.department)
                                .font(.system(size: 17))
                            
                        }.padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 3)
                        
                        
                        HStack{
                            Group{
                                Text("Degree/Status ").font(.system(size: 19))
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("Bachelor degree", text: $viewModel.degreeStatus)
                                .font(.system(size: 17))
                            
                        }.padding(.vertical, 10)
                    }
                }
                
                Section{
                    HStack{
                        Text("Are you currently studying?")
                        Spacer()
                        YesNoSwitch(isCurrentPosition: $viewModel.isCurrentPosition)
                    }.padding(.vertical, 10)
                    
                    VStack{
                        HStack{
                            Text("Start Date")
                                .font(.system(size: 19))
                            
                            Spacer()
                            Text(viewModel.startDate, format: .dateTime.day().month().year())
                                .foregroundColor(.gray)
                            
                        }
                        .background(.white)
                        .padding(.vertical, 10)
                        .onTapGesture {
                            viewModel.showEndDatePicker = false
                            
                            viewModel.showStartDatePicker.toggle()
                        }
                        
                        if viewModel.showStartDatePicker{
                            DatePicker("", selection: $viewModel.startDate, in: ...Date.now, displayedComponents: .date)
                                .fixedSize()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .datePickerStyle(WheelDatePickerStyle())
                        }
                    }
                    
                    if !viewModel.isCurrentPosition{
                        VStack {
                            HStack{
                                Text("End Date")
                                    .font(.system(size: 19))
                                Spacer()
                                Text(viewModel.endDate, format: .dateTime.day().month().year())
                                    .foregroundColor(.gray)
                                
                            }
                            .background(.white)
                            .padding(.vertical, 10)
                            .onTapGesture {
                                viewModel.showStartDatePicker = false
                                
                                viewModel.showEndDatePicker.toggle()
                            }
                            
                            if viewModel.showEndDatePicker{
                                DatePicker("", selection: $viewModel.endDate, in: ...Date.now, displayedComponents: .date)
                                    .fixedSize()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .datePickerStyle(WheelDatePickerStyle())
                            }
                        }
                        
                    }
                    
                    HStack{
                        Group{
                            Text("GPA ").font(.system(size: 19))
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        TextField("4.0", text: $viewModel.gpa)
                            .font(.system(size: 19))
                            .keyboardType(UIKeyboardType.decimalPad)
                        
                    }.padding(.vertical, 10)
                    
                }
            }
            .listStyle(GroupedListStyle())
            .onTapGesture {
                viewModel.endEditing()
            }
        }
    }

}

