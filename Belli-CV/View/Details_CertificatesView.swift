//
//  Details_CertificatesView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_CertificatesView: View {
    @StateObject var viewModel = VM_CertificatesView()
    
    
    var body: some View {
        ZStack {

            VStack(spacing: 0){
                
                Spacer()
                    .frame(height: 20)
                
                viewModel.experienceInfoTitle
                
                ScrollView(showsIndicators: false){
                        
                    ForEach(viewModel.certificateArray){certificate in
                        
                        VStack(alignment: .leading, spacing: 1){
                            Text(certificate.certificate)
                                .font(.system(size: 19, weight: .regular))
                            
                            Text(certificate.date, format: .dateTime.day().month().year())
                                .font(.system(size: 15))
                            
                            Divider().padding(.top)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.horizontal)
                        .background(.white)
                        .contextMenu{
                            Button {
                                viewModel.removeCertificate(id: certificate.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    
                    Button {
                        viewModel.openSheet = true
                    } label: {
                        HStack{
                            Text("Add certificate...")
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
        .sheet(isPresented: $viewModel.openSheet) {
            AddCertificateSheet()
        }
    }

}

struct Details_CertificatesView_Previews: PreviewProvider {
    static var previews: some View {
        Details_CertificatesView()
    }
}



