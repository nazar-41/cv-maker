//
//  Details_CareerObjectiveView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_CareerObjectiveView: View {
    @AppStorage("position") var position: String = ""
    @AppStorage("personalStatement") var personalStatement: String = ""
    
    var personalStatementTextfieldPlaceholder = "A conscientious and professional sales manager with extensive experience in sales and strategic planning currently seeking a new position as a Marketing Director."
    
    
    private var positionInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Position")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }.padding(.vertical, 5)
    }
    private var personalStatementInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Personal Statement")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }.padding(.vertical, 5)
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 0){
                positionInfoTitle
                
                TextField("Marketing Director", text: $position)
                    .submitLabel(.continue)
                    .padding(.bottom, 5)
                    .font(.system(size: 20, weight: .regular))
                
                Divider()
                
                Spacer()
                    .frame(height: 30)
                personalStatementInfoTitle
            }
            .onTapGesture {
                endEditing()
            }
            
            MultilineTextfield(placeholder: personalStatementTextfieldPlaceholder, text: $personalStatement)
            //.background(.clear)
            //.frame(maxHeight: 300)
                .disableAutocorrection(true)
                .adaptsToKeyboard()
            
            Spacer()
            
        }
        .padding(.horizontal)
        .edgesIgnoringSafeArea(.all)
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct Details_CareerObjectiveView_Previews: PreviewProvider {
    static var previews: some View {
        Details_CareerObjectiveView()
    }
}
