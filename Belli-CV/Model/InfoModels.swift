//
//  WorkedPlaceModel.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 06/06/2022.
//

import Foundation


// MARK: - Worked Places Model
struct WorkedPlaceModel: Identifiable, Codable{
    var id: String = UUID().uuidString
    
    let company: String
    let position: String
    let website: String
    let isCurrentPosition: Bool
    
    let startDate: Date
    let endDate: Date?
}



// MARK: - Educations Model
struct EducationModel: Identifiable, Codable{
    var id: String = UUID().uuidString
    
    let institution: String
    let department: String
    let degreeStatus: String

    let isCurrentPosition: Bool

    let startDate: Date
    let endDate: Date?
    let gpa: String
}



// MARK: - Skills Model
struct SkillModel: Identifiable, Codable{
    var id: String = UUID().uuidString
    
    let skill: String
    let level: String
}


//MARK: - Languages Model
struct LanguageModel: Identifiable, Codable{
    var id: String = UUID().uuidString
    
    let language: String
    let level: String
}


//MARK: - Languages Model
struct HobbiesModel: Identifiable, Codable{
    var id: String = UUID().uuidString
    
    let hobby: String
}


//MARK: - Languages Model
struct CertificateModel: Identifiable, Codable{
    var id: String = UUID().uuidString
    
    let certificate: String
    let date: Date
}
