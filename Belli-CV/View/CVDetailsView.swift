//
//  CVDetailsView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 25/05/2022.
//

import SwiftUI

struct CVDetailsView: View {
    
    //MARK: - Check this arrays (empty or not)
    @AppStorage("workedPlacesArray") var workedPlacesArray: [WorkedPlaceModel] = []
    @AppStorage("educationArray") var educationArray: [EducationModel] = []
    @AppStorage("skillsArray") var skillsArray: [SkillModel] = []
    @AppStorage("languagesArray") var languagesArray: [LanguageModel] = []
    @AppStorage("hobbiesArray") var hobbiesArray: [HobbiesModel] = []
    @AppStorage("certificatesArray") var certificateArray: [CertificateModel] = []

    @State private var showingAlert: Bool = false
    
    
    var body: some View {
       // NavigationView{
            VStack{

                ScrollView(showsIndicators: false) {
                    ChooseDesignButton()
                    
                    Group{
                        DetailsItemView(
                            //iconBackgroundColor: .blue,
                            savedIconBackgroundColor: .blue,
                            icon: "person.fill",
                            itemName: "Personal info",
                            navigateTo: AnyView(Details_PersonalInfoView()))
                        
                        DetailsItemView(
                            //iconBackgroundColor: .orange,
                            savedIconBackgroundColor: .orange,
                            icon: "globe.europe.africa.fill",
                            itemName: "Career objective",
                            navigateTo: AnyView(Details_CareerObjectiveView()))
                        
                        DetailsItemView(
                            savedIconBackgroundColor: .red,
                            icon: "hourglass",
                            itemName: "Professional Experience",
                            navigateTo: AnyView(Details_ProfessionalExperienceView()),
                            checkArr: workedPlacesArray)
                        
                        DetailsItemView(
                            savedIconBackgroundColor: .green,
                            icon: "graduationcap",
                            itemName: "Education",
                            navigateTo: AnyView(Details_EducationView()),
                            checkArr: educationArray)
                        
                        DetailsItemView(
                            savedIconBackgroundColor: .yellow,
                            icon: "pencil.slash",
                            itemName: "Skills",
                            navigateTo: AnyView(Details_SkillsView()),
                            checkArr: skillsArray)
                        
                        DetailsItemView(
                            savedIconBackgroundColor: .blue,
                            icon: "globe",
                            itemName: "Languages",
                            navigateTo: AnyView(Details_LanguagesView()),
                            checkArr: languagesArray)
                        
                        DetailsItemView(
                            savedIconBackgroundColor: .purple,
                            icon: "heart.fill",
                            itemName: "Hobbies & Interests",
                            navigateTo: AnyView(Details_Hobbies_InterestsView()),
                            checkArr: hobbiesArray)
                        
                        DetailsItemView(
                            savedIconBackgroundColor: .red,
                            icon: "rosette",
                            itemName: "Cerificates",
                            navigateTo: AnyView(Details_CertificatesView()),
                            checkArr: certificateArray)
                    }
                    
                    DeleteCVButton(showingAlert: $showingAlert)
                    
                    Spacer().frame(maxHeight: 30)
                    
                }.padding(.horizontal)

        }
        .foregroundColor(Color("c_text"))
    }
}

struct CVDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CVDetailsView()
    }
}

struct DetailsItemView: View{
    var iconBackgroundColor: Color = .gray.opacity(0.2)
    var savedIconBackgroundColor: Color
    var iconColor: Color { isSaved ? .white : .black }
    let icon: String
    let itemName: String
    let navigateTo: AnyView
    
    var checkArr: [Any]? = nil
    
    var isSaved: Bool {
        if let checkArr = checkArr {
            if checkArr.isEmpty{
                return false
            }else{
                return true
            }
        }else{
            return true
        }
    }
    
    var body: some View{
        CustomNavLink(destination: navigateTo.customNavBarItems(title: itemName)) {
            VStack {
                HStack(spacing: 30){
                    ZStack {
                        if let isSaved = isSaved {
                            if isSaved{
                                savedIconBackgroundColor
                            }else{
                                iconBackgroundColor
                            }
                        }else{
                            iconBackgroundColor
                        }
                        
                        Image(systemName: icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(iconColor)
                            .frame(width: 17, height: 17)
                    }
                    .frame(width: 40, height: 40)
                    .cornerRadius(10)
                    
                    Text(itemName)
                        .font(.system(size: 18, weight: .regular))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
            }
            .padding(.vertical, 5)
        }
    }
}

struct ChooseDesignButton: View{
    var body: some View{
        CustomNavLink(destination: ChooseDesignView().customNavBarItems(title: "Choose design")) {
            
            VStack {
                ZStack{
                    Color("c_continue_button").opacity(0.2)
                        .cornerRadius(10)
                    
                    HStack{
                        Text("Choose design")
                            .font(.system(size: 18))
                            .foregroundColor(Color("c_continue_button"))
                        Spacer()
                        Image(systemName: "doc.fill.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color("c_continue_button"))
                        
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .padding(.vertical)
        }
    }
}

struct DeleteCVButton: View{
    
    
    @AppStorage("fullName") var fullName: String = ""
    @AppStorage("birthDate") var birthDate: Date = Date()
    
    @AppStorage("email") var email: String = ""
    @AppStorage("phone") var phone: String = ""
    @AppStorage("address") var address: String = ""
    @AppStorage("postcode") var postcode: String = ""
    @AppStorage("city") var city: String = ""
    @AppStorage("region") var region: String = ""
    @AppStorage("country") var country: String = ""
    
    @AppStorage("designColor") var dc: DesignColors = .d1
    
    //MARK: - Career Objective
    @AppStorage("personalStatement") var personalStatement: String = ""
    @AppStorage("position") var position: String = ""
    
    //MARK: - Professional Experience
    @AppStorage("workedPlacesArray") var workedPlacesArray: [WorkedPlaceModel] = []
    
    //MARK: - Education
    @AppStorage("educationArray") var educationArray: [EducationModel] = []
    
    //MARK: - Skills
    @AppStorage("skillsArray") var skillsArray: [SkillModel] = []
    
    //MARK: - Languages
    @AppStorage("languagesArray") var languagesArray: [LanguageModel] = []
    
    //MARK: - Hobbies
    @AppStorage("hobbiesArray") var hobbiesArray: [HobbiesModel] = []
    
    //MARK: - Certificates
    @AppStorage("certificatesArray") var certificateArray: [CertificateModel] = []

    @Binding var showingAlert: Bool
    var body: some View{
        Button {
            showingAlert = true
        } label: {
            VStack {
                ZStack{
                    Color.red.opacity(0.3)
                        .cornerRadius(10)
                    
                    HStack{
                        Text("Delete CV")
                            .font(.system(size: 18))
                            .foregroundColor(.red)
                        Spacer()
                        Image(systemName: "trash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.red)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                
            }
            .padding(.vertical)
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Are you sure you want to delete this?"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Delete")) {
                    deleteCV()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    
    func deleteCV(){
        fullName = ""
        birthDate = .now
        
        email = ""
        phone = ""
        address = ""
        postcode = ""
        city = ""
        region = ""
        country = ""
        email = ""
        
        personalStatement = ""
        position = ""
        
        dc = .d1
        
        workedPlacesArray = []
        educationArray = []
        skillsArray = []
        languagesArray = []
        hobbiesArray = []
        certificateArray = []

    }
}
