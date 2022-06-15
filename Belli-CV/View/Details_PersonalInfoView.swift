//
//  Details_PersonInfoView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI
import Foundation


struct Details_PersonalInfoView: View {
    
    @AppStorage("fullName") var fullName: String = ""
    @AppStorage("birthDate") var birthDate: Date = Date()
    
    @AppStorage("email") var email: String = ""
    @AppStorage("phone") var phone: String = ""
    @AppStorage("address") var address: String = ""
    @AppStorage("postcode") var postcode: String = ""
    @AppStorage("city") var city: String = ""
    @AppStorage("region") var region: String = ""
    @AppStorage("country") var country: String = ""
    
    @State private var value: CGFloat = 0
    
    @State private var showDatePicker: Bool = false
    
    
    private var requiredIcon = Text("*").foregroundColor(.red)
    
    private var contactInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Contact Info")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }.padding(.vertical, 5)
    }
    
    private var locationInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Location")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }.padding(.vertical, 5)
    }
    
    private var dateOfBirthItem: some View{
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
                    showDatePicker.toggle()
                }
            }
        }.padding(.vertical, 5)
    }
    
    
    private func contactInfoItem(title: String, placeholder: String, bindingValue: Binding<String>, isRequred: Bool = false) -> some View{
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
    
    
    var body: some View {
        VStack{

            
            
            ScrollView(showsIndicators: false) {
                
                Group{ // Base Info
                    contactInfoItem(title: "Full name", placeholder: "John Doe", bindingValue: $fullName, isRequred: true)
                    
                    dateOfBirthItem
                }
                
                Spacer().frame(height: 30)
                contactInfoTitle
                
                Group{// Contact Info
                    contactInfoItem(title: "Email", placeholder: "johndoe@gmail.com", bindingValue: $email)
                    contactInfoItem(title: "Phone", placeholder: "309940304", bindingValue: $phone)

                }
                
                Spacer().frame(height: 30)
                locationInfoTitle
                
                Group{ // Location Info
                    contactInfoItem(title: "Address",
                                    placeholder: "457 54 St.",
                                    bindingValue: $address)
                    
                    contactInfoItem(title: "Postcode",
                                    placeholder: "10014",
                                    bindingValue: $postcode)
                    
                    contactInfoItem(title: "City",
                                    placeholder: "New York",
                                    bindingValue: $city)
                    
                    contactInfoItem(title: "Region",
                                    placeholder: "NY",
                                    bindingValue: $region)
                    
                    contactInfoItem(title: "Country",
                                    placeholder: "USA",
                                    bindingValue: $country)
                }
            }
            .offset(y: -self.value)
            .onAppear(perform: moveTextField)

            .padding(.horizontal)
        }
        .foregroundColor(Color("c_text"))
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

struct Details_PersonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Details_PersonalInfoView()
    }
}
