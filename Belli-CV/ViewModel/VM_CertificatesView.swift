//
//  VM_CertificatesView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI

class VM_CertificatesView: ObservableObject{
    @AppStorage("certificatesArray") var certificateArray: [CertificateModel] = []

    
    @Published var openSheet: Bool = false
    
    
    var experienceInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Certificates")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
    
    
    func removeCertificate(id: String){
        if let index = certificateArray.firstIndex(where: {$0.id == id}) {
            certificateArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
    
}
