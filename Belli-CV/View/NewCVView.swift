//
//  CreateCVView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 25/05/2022.
//

import SwiftUI

struct NewCVView: View {
    @AppStorage("fullName") var fullName: String = ""
    @AppStorage("birthDate") var birthDate: Date = Date()
    @AppStorage("position") var position: String = ""
    
    @AppStorage("createdDate") var createdDate: Date = .now

    @State private var selection: Int = 1
    
    
    var isContinueButtonClickable: Bool {
        if position.isEmpty || fullName.isEmpty || birthDate.rawValue.isEmpty{
            return false
        }else{
            return true
        }
    }
    
    
    var body: some View { 
        
        VStack(spacing: 0){
            TabView(selection: $selection){
                NewCVTabViewFullName(fullName: $fullName).tag(1)
                NewCVTabViewBirthDate(birthDate: $birthDate).tag(2)
                NewCVTabViewPosition(position: $position).tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            
            VStack{
                Button {

                    if selection < 3{
                        withAnimation {
                            selection += 1
                        }
                    }else{
                        withAnimation {
                            selection = 1
                        }
                    }
                    
                } label: {
                    ZStack{
                        Color("c_continue_button").opacity(isContinueButtonClickable ? 0.6 : 1)
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .cornerRadius(10)
                }
                .disabled(isContinueButtonClickable)
                
                
                CustomNavLink(destination: CVDetailsView().customNavBarItems(title: "Details")) {
                    ZStack{
                        Color("c_continue_button").opacity(isContinueButtonClickable ? 1 : 0.6)
                        Text("Continue")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .cornerRadius(10)
                }
                .disabled(!isContinueButtonClickable)
                
            }
            
            Spacer()
                .frame(height: 10)
        }
        .foregroundColor(Color("c_text"))
        .padding()
        .onAppear {
            createdDate = Date.now
        }
    }
}

struct CreateCVView_Previews: PreviewProvider {
    static var previews: some View {
        NewCVView()
    }
}

struct NewCVTabViewPosition: View {
    @Binding var position: String
    var body: some View {
        VStack(spacing: 0){
            Text("What position would you like to apply for?")
                .font(.system(size: 35, weight: .semibold, design: .default))
                .multilineTextAlignment(.center)
                //.padding(.top, 30)
            Spacer()
            
            TextField("Marketing Director", text: $position)
                .multilineTextAlignment(.center)
                .padding()
                .font(.system(size: 20, weight: .medium, design: .default))
            
            Divider()
                .padding(.horizontal)
            Spacer()
            
        }
    }
}

struct NewCVTabViewFullName: View {
    @Binding var fullName: String
    var body: some View {
        VStack(spacing: 0){
            Text("Your full name")
                .font(.system(size: 35, weight: .semibold, design: .default))
                .multilineTextAlignment(.center)
                //.padding(.top, 30)
            Spacer()
            
            TextField("John Doe", text: $fullName)
                .multilineTextAlignment(.center)
                .padding()
                .font(.system(size: 20, weight: .medium, design: .default))
            
            Divider()
                .padding(.horizontal)
            Spacer()
            
        }
    }
}


struct NewCVTabViewBirthDate: View {
    @Binding var birthDate: Date
    var body: some View {
        VStack(spacing: 0){
            Text("Your birtday")
                .font(.system(size: 35, weight: .semibold, design: .default))
                .multilineTextAlignment(.center)
                //.padding(.top, 30)
            
            Text(birthDate, format: .dateTime.day().month().year())
                .font(.system(size: 20, weight: .regular))
                .padding(.top, 20)
            
            Spacer()
            
            DatePicker("Enter your birthday", selection: $birthDate, in: ...Date.now, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .frame(maxHeight: 400)
            
            Divider()
                .padding(.horizontal)
            Spacer()
            
        }
    }
}
