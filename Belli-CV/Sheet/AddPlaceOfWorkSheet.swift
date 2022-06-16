//
//  AddPlaceOfWorkSheet.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import SwiftUI

struct AddPlaceOfWorkSheet: View{

    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: VM_AddPlaceOfWork = VM_AddPlaceOfWork()
    
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
                
                Text("Add place of work")
                    .font(.system(size: 21, weight: .semibold))
                
                
                Spacer()
                
                Button {
                    viewModel.saveAddedWorkPlace()
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
                Section(header: Text("company info")) {
                    VStack(spacing: 0){
                        HStack{
                            Group{
                                Text("Company ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("Digital innovation", text: $viewModel.companyName)
                                .font(.system(size: 17))
                            
                        }
                        
                        .padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 3)
                        
                        HStack{
                            Group{
                                Text("Position ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("Marketing Director", text: $viewModel.position)
                                .font(.system(size: 17))
                            
                        }.padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 3)
                        
                        
                        HStack{
                            Group{
                                Text("Website ").font(.system(size: 19))
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("https://marketingideas.com", text: $viewModel.website)
                                .font(.system(size: 17))
                            
                        }.padding(.vertical, 10)
                    }
                }
                
                Section{
                    HStack{
                        Text("Is it your current position?")
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
                    
                }
            }
            .listStyle(GroupedListStyle())
            .onTapGesture {
                viewModel.endEditing()
            }
            .background(Color("c_white"))
            
        }
        .background(Color("c_white"))
    }
}

