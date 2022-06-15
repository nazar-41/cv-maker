//
//  Details_CertificatesView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_CertificatesView: View {
    @AppStorage("certificatesArray") var certificateArray: [CertificateModel] = []

    
    @State private var openSheet: Bool = false
    
    
    private var experienceInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Certificates")
                .font(.title)
                .fontWeight(.medium)
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
                        
                    ForEach(certificateArray){certificate in
                        
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
                                removeCertificate(id: certificate.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    
                    Button {
                        openSheet = true
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
        .sheet(isPresented: $openSheet) {
            AddCertificateSheet()
        }
    }
    
    private func removeCertificate(id: String){
        if let index = certificateArray.firstIndex(where: {$0.id == id}) {
            certificateArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
}

struct Details_CertificatesView_Previews: PreviewProvider {
    static var previews: some View {
        Details_CertificatesView()
    }
}


struct AddCertificateSheet: View{
    @AppStorage("certificatesArray") var certificateArray: [CertificateModel] = []
    
    
    @State private var title: String = ""
    
    @State private var date: Date = Date()
    
    @State private var showDatePicker: Bool = false
    
    private var isSaveButtonDisabled: Bool{
        if title.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    private func saveCertificate(){
        let data = CertificateModel(certificate: title, date: date)
        certificateArray.append(data)
        
        presentationMode.wrappedValue.dismiss()
        title = ""
        date = .now
        
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
                
                Text("Add certificate")
                    .font(.system(size: 21, weight: .semibold))
                
                
                Spacer()
                
                Button {
                    saveCertificate()
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
                Section(header: Text("certificate info")) {
                    VStack(spacing: 0){
                        HStack{
                            Group{
                                Text("Title ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("TOEFL", text: $title)
                                .font(.system(size: 19))
                            
                        }
                        .padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 3)
                        
                        HStack{
                            Text("Date")
                                .font(.system(size: 19))
                            
                            Spacer()
                            Text(date, format: .dateTime.day().month().year())
                                .foregroundColor(.gray)
                            
                        }
                        .background(.white)
                        .padding(.vertical, 10)
                        .onTapGesture {
                            showDatePicker.toggle()
                            
                        }
                        
                        if showDatePicker{
                            DatePicker("", selection: $date, in: ...Date.now, displayedComponents: .date)
                                .fixedSize()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .datePickerStyle(WheelDatePickerStyle())
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
}
private func endEditing() {
    UIApplication.shared.endEditing()
}

