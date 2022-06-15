//
//  VM_AddCertificateSheet.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI

class VM_AddCertificateSheet: ObservableObject{
    @AppStorage("certificatesArray") var certificateArray: [CertificateModel] = []
    
    
    @Published var title: String = ""
    
    @Published var date: Date = Date()
    
    @Published var showDatePicker: Bool = false
    
    var isSaveButtonDisabled: Bool{
        if title.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    func saveCertificate(){
        let data = CertificateModel(certificate: title, date: date)
        certificateArray.append(data)
        
        title = ""
        date = .now
        
    }
    func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    
}
