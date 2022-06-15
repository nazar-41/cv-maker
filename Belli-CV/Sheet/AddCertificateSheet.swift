//
//  AddCertificateSheet.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI


struct AddCertificateSheet: View{
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = VM_AddCertificateSheet()
    
    
    
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
                
                Text("Add certificate")
                    .font(.system(size: 21, weight: .semibold))
                
                
                Spacer()
                
                Button {
                    viewModel.saveCertificate()
                    
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
                Section(header: Text("certificate info")) {
                    VStack(spacing: 0){
                        HStack{
                            Group{
                                Text("Title ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("TOEFL", text: $viewModel.title)
                                .font(.system(size: 19))
                            
                        }
                        .padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 3)
                        
                        HStack{
                            Text("Date")
                                .font(.system(size: 19))
                            
                            Spacer()
                            Text(viewModel.date, format: .dateTime.day().month().year())
                                .foregroundColor(.gray)
                            
                        }
                        .background(.white)
                        .padding(.vertical, 10)
                        .onTapGesture {
                            viewModel.showDatePicker.toggle()
                            
                        }
                        
                        if viewModel.showDatePicker{
                            DatePicker("", selection: $viewModel.date, in: ...Date.now, displayedComponents: .date)
                                .fixedSize()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .datePickerStyle(WheelDatePickerStyle())
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .onTapGesture {
                viewModel.endEditing()
            }
        }
    }
}
