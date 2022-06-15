//
//  Details_ProfessionalExperienceView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_ProfessionalExperienceView: View {
    @AppStorage("workedPlacesArray") var workedPlacesArray: [WorkedPlaceModel] = []

    @State private var openSheet: Bool = false
    

    
    private var experienceInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Experience")
                .font(.title)
                .fontWeight(.semibold)
            Divider()
            
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                
                Spacer()
                    .frame(height: 20)
                
                experienceInfoTitle
                
                ScrollView(showsIndicators: false){
                    ForEach(workedPlacesArray){place in
                        
                        VStack(alignment: .leading, spacing: 1){
                            Text(place.company)
                                .font(.system(size: 19, weight: .regular))
                            Text(place.position)
                                .font(.system(size: 15))
                            
                            Divider().padding(.top)
                                
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 7)
                        .padding(.horizontal)
                        .background(.white)
                        .contextMenu {
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
                            Text("Add place of work...")
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
            AddPlaceOfWorkSheet()
        }
    }
    private func removeWorkPlace(id: String){
        
        if let index = workedPlacesArray.firstIndex(where: {$0.id == id}) {
            workedPlacesArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
}

struct Details_ProfessionalExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        Details_ProfessionalExperienceView()
    }
}


struct AddPlaceOfWorkSheet: View{
    @AppStorage("workedPlacesArray") var workedPlacesArray: [WorkedPlaceModel] = []
    
    @State private var companyName: String = ""
    @State private var position: String = ""
    @State private var website: String = ""
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    @State private var isCurrentPosition: Bool = false
    
    @State private var showStartDatePicker: Bool = false
    @State private var showEndDatePicker: Bool = false
    

    
    private var isSaveButtonDisabled: Bool{
        if companyName.isEmpty || position.isEmpty{
            return true
        }else{
            return false
        }
    }

    func saveAddedWorkPlace(){
        
        let workedPlace = WorkedPlaceModel(company: companyName, position: position, website: website, isCurrentPosition: isCurrentPosition, startDate: startDate, endDate: isCurrentPosition ? nil : endDate)
        
        workedPlacesArray.append(workedPlace)
        
        presentationMode.wrappedValue.dismiss()
        
        companyName = ""
        position = ""
        website = ""
        startDate = .now
        endDate = .now
        isCurrentPosition = false
        
    }
    

    
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
                
                Text("Add place of work")
                    .font(.system(size: 21, weight: .semibold))
                
                
                Spacer()
                
                Button {
                    saveAddedWorkPlace()
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
                Section(header: Text("company info")) {
                    VStack(spacing: 0){
                        HStack{
                            Group{
                                Text("Company ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("Digital innovation", text: $companyName)
                                .font(.system(size: 17))
                            
                        }
                        
                        .padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 3)
                        
                        HStack{
                            Group{
                                Text("Position ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("Marketing Director", text: $position)
                                .font(.system(size: 17))
                            
                        }.padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 3)
                        
                        
                        HStack{
                            Group{
                                Text("Website ").font(.system(size: 19))
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("https://marketingideas.com", text: $website)
                                .font(.system(size: 17))
                            
                        }.padding(.vertical, 10)
                    }
                }
                
                Section{
                    HStack{
                        Text("Is it your current position?")
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

struct YesNoSwitch: View{
    
    @Binding var isCurrentPosition: Bool
    
    var body: some View{
        ZStack{
            Color.gray.opacity(0.2)
            HStack{
                
                if isCurrentPosition{Spacer()}
                
                Color.white
                    .frame(width: 45, height: 25)
                    .cornerRadius(7)
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 1, y: 1)
                
                if !isCurrentPosition{Spacer()}
                
            }
            .padding(.horizontal, 5)
            
            
            HStack{
                Text("No")
                    .foregroundColor(isCurrentPosition ? .gray : .black)
                Spacer()
                Text("Yes")
                    .foregroundColor(isCurrentPosition ? .black : .gray)
                
            }
            .padding(.horizontal, 14)
        }
        .frame(width: 100, height: 35)
        .cornerRadius(10)
        .onTapGesture {
            withAnimation{
                isCurrentPosition.toggle()
            }
        }
    }
}


