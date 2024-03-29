//
//  Details_Hobbies&InterestsView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_Hobbies_InterestsView: View {
    @StateObject var viewModel = VM_HobbiesView()
    
    var body: some View {
        
        VStack(spacing: 0){
            
            Spacer()
                .frame(height: 20)
            
            viewModel.hobbiesInfoTitle
            
            ScrollView(showsIndicators: false){
                ForEach(viewModel.hobbiesArray){hobby in
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text(hobby.hobby)
                            .font(.system(size: 19, weight: .regular))
                        
                        Divider().padding(.top)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                    .padding(.horizontal)
                    .background(.white)
                    .contextMenu{
                        Button {
                            viewModel.removeHobby(id: hobby.id)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                
                Button {
                    viewModel.openSheet = true
                } label: {
                    HStack{
                        Text("Add hobby...")
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
        .sheet(isPresented: $viewModel.openSheet) {
            AddHobbySheet()
        }
    }
}

struct Details_Hobbies_InterestsView_Previews: PreviewProvider {
    static var previews: some View {
        Details_Hobbies_InterestsView()
    }
}

