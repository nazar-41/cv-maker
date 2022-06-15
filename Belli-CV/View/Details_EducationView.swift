//
//  Details_EducationView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_EducationView: View {
    @AppStorage("educationArray") var educationArray: [EducationModel] = []

    
    
    @State private var openSheet: Bool = false
        
    private var educationInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Education")
                .font(.title)
                .fontWeight(.semibold)
            
            Divider()
            
        }
        .padding(.top, 5)
        .padding(.horizontal)

    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                
                Spacer()
                    .frame(height: 20)
                
                educationInfoTitle
                
                ScrollView(showsIndicators: false){
                    
                    ForEach(educationArray){place in
                        
                        VStack(alignment: .leading, spacing: 1){
                            Text(place.institution)
                                .font(.system(size: 19, weight: .regular))
                            Text(place.department)
                                .font(.system(size: 15))

                            
                            Divider().padding(.top)
                                
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 7)
                        .padding(.horizontal)
                        .background(.white)
                        .contextMenu{
                            Button {
                                removeWorkPlace(id: place.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }

                        }
                    }

                    Button {
                        openSheet = true
                    } label: {
                        HStack{
                            Text("Add education")
                                .font(.system(size: 19, weight: .regular))
                                .foregroundColor(Color("c_continue_button"))

                            Spacer()
                            
                            ZStack{
                                Circle()
                                    .fill(Color("c_continue_button").opacity(0.2))
                                Image(systemName: "plus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 13, height: 13)
                                    .foregroundColor(Color("c_continue_button"))
                            }
                            .frame(width: 25, height: 25)
                            
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal)

                    }
                    Divider()
                }
                
                
                Spacer()
            }
            .foregroundColor(Color("c_text"))
        }
        .sheet(isPresented: $openSheet) {
            AddEducationSheet()
        }
    }
    private func removeWorkPlace(id: String){
        
        if let index = educationArray.firstIndex(where: {$0.id == id}) {
            educationArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
}

struct Details_EducationView_Previews: PreviewProvider {
    static var previews: some View {
        Details_EducationView()
    }
}


struct AddEducationSheet: View{
    @AppStorage("educationArray") var educationArray: [EducationModel] = []

    
    
    @State private var institution: String = ""
    @State private var department: String = ""
    @State private var degreeStatus: String = ""
    
    
    @State private var isCurrentPosition: Bool = false

    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var gpa: String = ""
    
    @State private var showStartDatePicker: Bool = false
    @State private var showEndDatePicker: Bool = false
        
    
    private var isSaveButtonDisabled: Bool{
        if institution.isEmpty || department.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    
    func saveAddedEducation(){
        let data = EducationModel(institution: institution, department: department, degreeStatus: degreeStatus, isCurrentPosition: isCurrentPosition, startDate: startDate, endDate: isCurrentPosition ? nil : endDate, gpa: gpa)
        
        educationArray.append(data)
        
        presentationMode.wrappedValue.dismiss()
        
        institution = ""
        department = ""
        degreeStatus = ""
        isCurrentPosition = false
        startDate = .now
        endDate = .now
        gpa = ""
        
    }
    
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
                    saveAddedEducation()
                } label: {
                    Text("Save")
                        .foregroundColor(isSaveButtonDisabled ? Color("c_continue_button").opacity(0.5) : Color("c_continue_button"))
                        .font(.system(size: 20))
                        .frame(width: 50)
                }.disabled(isSaveButtonDisabled)
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
                            
                            TextField("Boston University", text: $institution)
                                .font(.system(size: 17))
                            
                        }
                        
                        .padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 3)
                        
                        HStack{
                            Group{
                                Text("Department ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("Economics", text: $department)
                                .font(.system(size: 17))
                            
                        }.padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 3)
                        
                        
                        HStack{
                            Group{
                                Text("Degree/Status ").font(.system(size: 19))
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("Bachelor degree", text: $degreeStatus)
                                .font(.system(size: 17))
                            
                        }.padding(.vertical, 10)
                    }
                }
                
                Section{
                    HStack{
                        Text("Are you currently studying?")
                        Spacer()
                        YesNoSwitch(isCurrentPosition: $isCurrentPosition)
                    }.padding(.vertical, 10)
                    
                    VStack{
                        HStack{
                            Text("Start Date")
                                .font(.system(size: 19))
                            
                            Spacer()
                            Text(startDate, format: .dateTime.day().month().year())
                                .foregroundColor(.gray)
                            
                        }
                        .background(.white)
                        .padding(.vertical, 10)
                        .onTapGesture {
                            showEndDatePicker = false
                            
                            showStartDatePicker.toggle()
                        }
                        
                        if showStartDatePicker{
                            DatePicker("", selection: $startDate, in: ...Date.now, displayedComponents: .date)
                                .fixedSize()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .datePickerStyle(WheelDatePickerStyle())
                        }
                    }
                    
                    if !isCurrentPosition{
                        VStack {
                            HStack{
                                Text("End Date")
                                    .font(.system(size: 19))
                                Spacer()
                                Text(endDate, format: .dateTime.day().month().year())
                                    .foregroundColor(.gray)
                                
                            }
                            .background(.white)
                            .padding(.vertical, 10)
                            .onTapGesture {
                                showStartDatePicker = false
                                
                                showEndDatePicker.toggle()
                            }
                            
                            if showEndDatePicker{
                                DatePicker("", selection: $endDate, in: ...Date.now, displayedComponents: .date)
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
                        
                        TextField("4.0", text: $gpa)
                            .font(.system(size: 19))
                            .keyboardType(UIKeyboardType.decimalPad)
                        
                    }.padding(.vertical, 10)
                    
                }
            }
            .listStyle(GroupedListStyle())
            .onTapGesture {
                endEditing()
            }
            
            
        }
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

//struct YesNoSwitch: View{
//
//    @Binding var isCurrentPosition: Bool
//
//    var body: some View{
//        ZStack{
//            Color.gray.opacity(0.2)
//            HStack{
//
//                if isCurrentPosition{Spacer()}
//
//                Color.white
//                    .frame(width: 45, height: 25)
//                    .cornerRadius(7)
//                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 1, y: 1)
//
//                if !isCurrentPosition{Spacer()}
//
//            }
//            .padding(.horizontal, 5)
//
//
//            HStack{
//                Text("No")
//                    .foregroundColor(isCurrentPosition ? .gray : .black)
//                Spacer()
//                Text("Yes")
//                    .foregroundColor(isCurrentPosition ? .black : .gray)
//
//            }
//            .padding(.horizontal, 14)
//        }
//        .frame(width: 100, height: 35)
//        .cornerRadius(10)
//        .onTapGesture {
//            withAnimation{
//                isCurrentPosition.toggle()
//            }
//        }
//    }
//}
//
//
