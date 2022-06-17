//
//  Details_ProfessionalExperienceView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_ProfessionalExperienceView: View{
    @StateObject var viewModel: VM_ProfessionalExperience = VM_ProfessionalExperience()
        
    var body: some View{
        ZStack {
            VStack(spacing: 0){
                
                Spacer()
                    .frame(height: 20)
                
                viewModel.experienceInfoTitle
                
                ScrollView(showsIndicators: false){
                    ForEach(viewModel.workedPlacesArray){place in
                        
                        VStack(alignment: .leading, spacing: 1){
                            Text(place.company)
                                .font(.system(size: 19, weight: .regular))
                            Text(place.position)
                                .font(.system(size: 15))
                            
                            Divider().padding(.top)
                                
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 7)
                        .padding(.horizontal)
                        .background(.white)
                        .contextMenu {
                                Button {
                                    viewModel.removeWorkPlace(id: place.id)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                    
                    
                    Button {
                        viewModel.openSheet = true
                    } label: {
                        HStack{
                            Text("Add place of work...")
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
            AddPlaceOfWorkSheet()
        }
    }

}

struct Details_ProfessionalExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        Details_ProfessionalExperienceView()
    }
}



struct YesNoSwitch: View{
    
    @Binding var isCurrentPosition: Bool
    
    var body: some View{
        ZStack{
            Color.gray.opacity(0.2)
            HStack{
                
                if isCurrentPosition{Spacer()}
                
                Color.white
                    .frame(width: 45, height: 25)
                    .cornerRadius(7)
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 1, y: 1)
                
                if !isCurrentPosition{Spacer()}
                
            }
            .padding(.horizontal, 5)
            
            
            HStack{
                Text("No")
                    .foregroundColor(isCurrentPosition ? .gray : .black)
                Spacer()
                Text("Yes")
                    .foregroundColor(isCurrentPosition ? .black : .gray)
                
            }
            .padding(.horizontal, 14)
        }
        .frame(width: 100, height: 35)
        .cornerRadius(10)
        .onTapGesture {
            withAnimation{
                isCurrentPosition.toggle()
            }
        }
    }
}
