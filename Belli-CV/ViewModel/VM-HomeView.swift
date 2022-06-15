//
//  VM-HomeView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI


class VM_HomeView: ObservableObject{
    @Published var showSheet: Bool = false

    
    //MARK: - Personal Info
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
    
    @AppStorage("createdDate") var createdDate: Date = .now
    
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
    
    
    var isCreated: Bool {
        if position.isEmpty{
            return false
        }else{
            return true
        }
    }
    
    var calculate: Int {
        var totalScore: Int = 3
        
        if !fullName.isEmpty{
            totalScore += 1
        }
        if !birthDate.rawValue.isEmpty{
            totalScore += 1
        }
        if !email.isEmpty{
            totalScore += 1
        }
        if !phone.isEmpty{
            totalScore += 1
        }
        if !address.isEmpty{
            totalScore += 1
        }
        if !postcode.isEmpty{
            totalScore += 1
        }
        if !city.isEmpty{
            totalScore += 1
        }
        if !region.isEmpty{
            totalScore += 1
        }
        if !country.isEmpty{
            totalScore += 1
        }
        if !personalStatement.isEmpty{
            totalScore += 1
        }
        if !position .isEmpty{
            totalScore += 1
        }
        if !workedPlacesArray.isEmpty{
            totalScore += 1
        }
        if !educationArray.isEmpty{
            totalScore += 1
        }
        if !skillsArray.isEmpty{
            totalScore += 1
        }
        if !languagesArray.isEmpty{
            totalScore += 1
        }
        if !hobbiesArray.isEmpty{
            totalScore += 1
        }
        if !certificateArray .isEmpty{
            totalScore += 1
        }
        
        
        return Int(totalScore * 5)
    }

    
}
