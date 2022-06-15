//
//  ResultView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 10/06/2022.
//

import SwiftUI

struct ResultView: View {
    //@State private var designColor: Color = Color("c_d4")
    
    var designColor: Color {
        @AppStorage("designColor") var dc: DesignColors = .d1

        return Color("\(dc.rawValue)")
    }
    
    @AppStorage("fullName") var fullName: String = ""
    @AppStorage("birthDate") var birthDate: Date = Date()
    
    @AppStorage("email") var email: String = ""
    @AppStorage("phone") var phone: String = ""
    @AppStorage("address") var address: String = ""
    @AppStorage("postcode") var postcode: String = ""
    @AppStorage("city") var city: String = ""
    @AppStorage("region") var region: String = ""
    @AppStorage("country") var country: String = ""
    
    @AppStorage("personalStatement") var personalStatement: String = ""
    @AppStorage("position") var position: String = ""
    
    @AppStorage("workedPlacesArray") var workedPlacesArray: [WorkedPlaceModel] = []
    @AppStorage("educationArray") var educationArray: [EducationModel] = []
    @AppStorage("skillsArray") var skillsArray: [SkillModel] = []
    @AppStorage("languagesArray") var languagesArray: [LanguageModel] = []
    @AppStorage("hobbiesArray") var hobbiesArray: [HobbiesModel] = []
    @AppStorage("certificatesArray") var certificateArray: [CertificateModel] = []
    
    
    
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack(spacing: 0){
                    ZStack{
                        designColor
                            .frame(width: 15)
                    }// Left green line
                    
                    SmallPersonalDetailsInResultCV(fullName: fullName, email: email, phone: phone, address: address, city: city, region: region, country: country, postcode: postcode, birthDate: birthDate, languagesArray: languagesArray, certificateArray: certificateArray, skillsArray: skillsArray, hobbiesArray: hobbiesArray)
                    
                    
                    ExperienceDetailsInResultCV(fullName: fullName, personalStatement: personalStatement, position: position, educationArray: educationArray, workedPlacesArray: workedPlacesArray)
                    
                }//.padding(.vertical)
            }.frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height - 50)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}


struct SmallPersonalDetailsInResultCV: View{
    var designColor: Color {
        @AppStorage("designColor") var dc: DesignColors = .d1

        return Color("\(dc.rawValue)")
    }
    
    var fullName: String
    var email: String
    var phone: String
    var address: String
    var city: String
    var region: String
    var country: String
    var postcode: String
    var birthDate: Date
    
    var languagesArray: [LanguageModel]
    var certificateArray: [CertificateModel]
    var skillsArray: [SkillModel]
    var hobbiesArray: [HobbiesModel]
    
    
    var fullAdress: String {
        var resultString: String = ""
        
        let bAdrress: Bool  = !address.isEmpty
        let bPostcode: Bool  = !postcode.isEmpty
        let bRegion: Bool  = !region.isEmpty
        let bCity: Bool  = !city.isEmpty
        let bCountry: Bool  = !country.isEmpty
        
        if bAdrress{ resultString += address }
        if bPostcode{ resultString = resultString + ", " + postcode }
        if bRegion{ resultString = resultString + ", " + region }
        if bCity{ resultString = resultString + ", " + city }
        if bCountry{ resultString = resultString + ", " + country }
        
        if !bAdrress{
            return resultString.toLengthOf(length: 2)
        } else{
            return resultString
        }
    }
    
    var body: some View{
        ZStack{
            Color.gray.opacity(0.2)
                .frame(width: 150)
            
            VStack{
                VStack(alignment: .leading, spacing: 0){// personal details
                    
                    if !fullName.isEmpty || !email.isEmpty || !phone.isEmpty || !address.isEmpty || !city.isEmpty || !region.isEmpty || !country.isEmpty || !postcode.isEmpty || !birthDate.rawValue.isEmpty{
                        VStack(alignment: .leading, spacing: 0){
                            Text("Personal details")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(designColor)
                                .padding(.top, 20)
                                .padding(.horizontal, 10)
                                .frame(width: 150, alignment: .leading)
                            
                            Divider()
                                .frame(width: 130)
                                .padding(.horizontal, 10)
                                .padding(.top, 5)
                        }
                    }
                    
                    
                    Group{
                        VStack(alignment: .leading, spacing: 15){
                            if !fullName.isEmpty{
                                HStack(spacing: 10){
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 13, height: 13)
                                        .foregroundColor(designColor)
                                    
                                    
                                    Text(fullName)
                                        .font(.system(size: 9, weight: .regular))
                                }
                            }
                            
                            if !email.isEmpty{
                                HStack(spacing: 10){
                                    Image(systemName: "envelope.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 13, height: 13)
                                        .foregroundColor(designColor)
                                    
                                    Text(email)
                                        .font(.system(size: 9, weight: .regular))
                                    
                                }
                            }
                            
                            if !phone.isEmpty{
                                HStack(spacing: 10){
                                    Image(systemName: "phone.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 13, height: 13)
                                        .foregroundColor(designColor)
                                    
                                    Text(phone)
                                        .font(.system(size: 9, weight: .regular))
                                    
                                }
                            }
                            
                            if !address.isEmpty || !city.isEmpty || !region.isEmpty || !country.isEmpty || !postcode.isEmpty{
                                HStack(spacing: 10){
                                    Image(systemName: "house.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 13, height: 13)
                                        .foregroundColor(designColor)
                                    
                                    //Text("\(address), \(city), \(postcode), \(region), \(country)")
                                    Text(fullAdress)
                                        .font(.system(size: 9, weight: .regular))
                                    
                                    
                                }
                            }
                            
                            if !birthDate.rawValue.isEmpty{
                                HStack(spacing: 10){
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 13, height: 13)
                                        .foregroundColor(designColor)
                                    
                                    Text(birthDate, format: .dateTime.day().month().year() )
                                        .font(.system(size: 9, weight: .regular))
                                    
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    .frame(width: 150, alignment: .leading)
                    
                }
                
                if !languagesArray.isEmpty{
                    VStack(alignment: .leading, spacing: 0){// languages
                        
                        Text("Languages")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(designColor)
                            .padding(.top, 20)
                            .padding(.horizontal, 10)
                            .frame(width: 150, alignment: .leading)
                        
                        
                        Divider()
                            .frame(width: 130)
                            .padding(.horizontal, 10)
                            .padding(.top, 5)
                        
                        
                        Group{
                            VStack(alignment: .leading, spacing: 15){
                                ForEach(languagesArray){language in
                                    HStack(spacing: 0){
                                        Text(language.language)
                                            .font(.system(size: 9, weight: .medium))
                                            .foregroundColor(designColor)
                                            .frame(width: 50, alignment: .leading)
                                        
                                        Text(language.level)
                                            .font(.system(size: 9, weight: .regular))
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .frame(width: 150, alignment: .leading)
                    }
                }
                
                if !certificateArray.isEmpty{
                    VStack(alignment: .leading, spacing: 0){// certificates
                        
                        Text("Certificates")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(designColor)
                            .padding(.top, 20)
                            .padding(.horizontal, 10)
                            .frame(width: 150, alignment: .leading)
                        
                        Divider()
                            .frame(width: 130)
                            .padding(.horizontal, 10)
                            .padding(.top, 5)
                        
                        
                        Group{
                            VStack(alignment: .leading, spacing: 15){
                                
                                ForEach(certificateArray){certificate in
                                    HStack(spacing: 0){
                                        Text(certificate.date, format: .dateTime.month().year()  )
                                        
                                            .font(.system(size: 9, weight: .medium))
                                            .foregroundColor(designColor)
                                            .frame(width: 50, alignment: .leading)
                                        
                                        Text(certificate.certificate)
                                            .font(.system(size: 9, weight: .regular))
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .frame(width: 150, alignment: .leading)
                        
                    }
                }
                
                if !skillsArray.isEmpty{
                    VStack(alignment: .leading, spacing: 0){// skills
                        
                        Text("Skills")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(designColor)
                            .padding(.top, 20)
                            .padding(.horizontal, 10)
                            .frame(width: 150, alignment: .leading)
                        
                        Divider()
                            .frame(width: 130)
                            .padding(.horizontal, 10)
                            .padding(.top, 5)
                        
                        
                        Group{
                            VStack(alignment: .leading, spacing: 15){
                                ForEach(skillsArray){skill in
                                    HStack(spacing: 0){
                                        Text(skill.level)
                                            .font(.system(size: 9, weight: .medium))
                                            .foregroundColor(designColor)
                                            .frame(width: 50, alignment: .leading)
                                        
                                        Text(skill.skill)
                                            .font(.system(size: 9, weight: .regular))
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .frame(width: 150, alignment: .leading)
                        
                    }
                }
                
                if !hobbiesArray.isEmpty{
                    VStack(alignment: .leading, spacing: 0){// hobbies
                        
                        Text("Hobbies & Interests")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(designColor)
                            .padding(.top, 20)
                            .padding(.horizontal, 10)
                            .frame(width: 150, alignment: .leading)
                        
                        Divider()
                            .frame(width: 130)
                            .padding(.horizontal, 10)
                            .padding(.top, 5)
                        
                        
                        Group{
                            VStack(alignment: .leading, spacing: 15){
                                ForEach(hobbiesArray){hobby in
                                    Text(hobby.hobby)
                                        .font(.system(size: 9, weight: .medium))
                                        .foregroundColor(designColor)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .frame(width: 150, alignment: .leading)
                        
                    }
                }
                Spacer()
            }
        }
    }
}


struct ExperienceDetailsInResultCV: View{
    var designColor: Color {
        @AppStorage("designColor") var dc: DesignColors = .d1

        return Color("\(dc.rawValue)")
    }
    
    var fullName: String
    var personalStatement: String
    var position: String
    
    var educationArray: [EducationModel]
    var workedPlacesArray: [WorkedPlaceModel]
    
    var body: some View{
        ZStack{
            Color.white
            
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    HStack {
                        Text(fullName)
                            .font(.system(size: 19, weight: .bold))
                            .padding(.top)
                            .padding(.horizontal, 10)
                            .foregroundColor(designColor)
                        Spacer()
                    }
                    Text(position)
                        .font(.system(size: 10, weight: .regular))
                        .padding(.horizontal, 10)
                    
                }// header
                
                if !personalStatement.isEmpty{
                    Group{ // personal statement
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Personal statement")
                                .foregroundColor(designColor)
                                .font(.system(size: 14, weight: .medium))
                            
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 2){
                                
                                Text(personalStatement)
                                    .font(.system(size: 10, weight: .regular))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, 20)
                    }
                }

                
                
                if !educationArray.isEmpty{
                Group{ // education
                    VStack(alignment: .leading, spacing: 5){
                        Text("Education")
                            .foregroundColor(designColor)
                            .font(.system(size: 14, weight: .medium))
                        
                        Divider()
                        
                        
                        ForEach(educationArray){place in
                            VStack(alignment: .leading, spacing: 2){
                                HStack{
                                    Text(place.institution)
                                        .font(.system(size: 10, weight: .bold))
                                    
                                    Spacer()
                                    
                                    HStack{
                                        Text(place.startDate, format: .dateTime.month().year())
                                        
                                        if place.endDate != nil{
                                            Text("-")
                                            Text(place.endDate!, format: .dateTime.month().year())
                                        }
                                    }
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(designColor)
                                }
                                
                                Text(place.department)
                                    .font(.system(size: 10, weight: .regular))
                                
                                    Text(place.degreeStatus)
                                        .font(.system(size: 10, weight: .regular))

                                    Text(place.gpa)
                                        .font(.system(size: 10, weight: .regular))
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }.padding(.top, 20)
            }
                
                if !workedPlacesArray.isEmpty{
                    Group{ // professional experience
                        VStack(alignment: .leading, spacing: 5){
                            Text("Professional experience")
                                .foregroundColor(designColor)
                                .font(.system(size: 14, weight: .medium))
                            
                            Divider()
                            
                            ForEach(workedPlacesArray){place in
                                VStack(alignment: .leading, spacing: 2){
                                    HStack{
                                        Text(place.company)
                                            .font(.system(size: 10, weight: .bold))
                                        
                                        Spacer()
                                        
                                        HStack{
                                            Text(place.startDate, format: .dateTime.month().year())
                                            
                                            if place.endDate != nil{
                                                Text("-")
                                                Text(place.endDate!, format: .dateTime.month().year())
                                            }
                                        }
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(designColor)
                                    }
                                    
                                    Text(place.position)
                                        .font(.system(size: 10, weight: .regular))
                                    Text(place.website)
                                        .font(.system(size: 10, weight: .regular))
                                    
                                }
                            }
                            
                        }
                        .padding(.horizontal, 10)
                    }.padding(.top, 20)
                }
                
                Spacer()
            }
        }
    }
}

enum DesignColors: String{
    case d1 = "c_d1"
    case d2 = "c_d2"
    case d3 = "c_d3"
    case d4 = "c_d4"
}
