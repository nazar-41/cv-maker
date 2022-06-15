//
//  Details_CareerObjectiveView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_CareerObjectiveView: View {
    @StateObject var viewModel: VM_DetailsCareerObjectiveView = VM_DetailsCareerObjectiveView()
    
    var body: some View {
        VStack {
            VStack(spacing: 0){
                viewModel.positionInfoTitle
                
                TextField("Marketing Director", text: $viewModel.position)
                    .submitLabel(.continue)
                    .padding(.bottom, 5)
                    .font(.system(size: 20, weight: .regular))
                
                Divider()
                
                Spacer()
                    .frame(height: 30)
                viewModel.personalStatementInfoTitle
            }
            .onTapGesture {
                viewModel.endEditing()
            }
            
            MultilineTextfield(placeholder: viewModel.personalStatementTextfieldPlaceholder, text: $viewModel.personalStatement)
            //.background(.clear)
            //.frame(maxHeight: 300)
                .disableAutocorrection(true)
                .adaptsToKeyboard()
            
            Spacer()
            
        }
        .padding(.horizontal)
        .edgesIgnoringSafeArea(.all)
    }
    

}

struct Details_CareerObjectiveView_Previews: PreviewProvider {
    static var previews: some View {
        Details_CareerObjectiveView()
    }
}
