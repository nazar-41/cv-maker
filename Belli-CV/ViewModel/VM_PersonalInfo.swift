//
//  VM_PersonalInfo.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI


class VM_DetailsPersonalInfoView: ObservableObject{
   
    @AppStorage("fullName") var fullName: String = ""
    @AppStorage("birthDate") var birthDate: Date = Date()
    
    @AppStorage("email") var email: String = ""
    @AppStorage("phone") var phone: String = ""
    @AppStorage("address") var address: String = ""
    @AppStorage("postcode") var postcode: String = ""
    @AppStorage("city") var city: String = ""
    @AppStorage("region") var region: String = ""
    @AppStorage("country") var country: String = ""
    
    @Published var value: CGFloat = 0
    
    @Published var showDatePicker: Bool = false
    
    
    var requiredIcon = Text("*").foregroundColor(.red)
    
    var contactInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Contact Info")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }.padding(.vertical, 5)
    }
    
    var locationInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Location")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }.padding(.vertical, 5)
    }
    
    var dateOfBirthItem: some View{
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 10){
                Text("Date of Birth ") + requiredIcon
                
                Text(birthDate, format: .dateTime.day().month().year())
                    .foregroundColor(.gray)
                
                if showDatePicker{
                    VStack(alignment: .leading, spacing: 0){
                        
                        DatePicker("", selection: $birthDate, in: ...Date.now, displayedComponents: .date)
                            .fixedSize()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .datePickerStyle(WheelDatePickerStyle())
                        
                    }
                }
                HStack{
                    Spacer()
                    Image(systemName: "calendar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                
                Divider()
            }
            .background(.white)
            .onTapGesture {
                withAnimation{
                    self.showDatePicker.toggle()
                }
            }
        }.padding(.vertical, 5)
    }
    
    
    func contactInfoItem(title: String, placeholder: String, bindingValue: Binding<String>, isRequred: Bool = false) -> some View{
        VStack(alignment: .leading){
            isRequred ? (Text("\(title) ") + requiredIcon) : Text("\(title)")
            TextField(placeholder, text: bindingValue)
                .submitLabel(.continue)
                .padding(.bottom, 5)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            
            Divider()
        }.padding(.vertical, 5) // Full name
    }
    
    
    func moveTextField(){
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
            if (notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) != nil{
               //let height = value.height
                self.value = 10
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { notif in
                self.value = 0
        }
    }
}
