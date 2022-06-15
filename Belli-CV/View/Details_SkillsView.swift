//
//  Deatails_SkillsView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_SkillsView: View {
    @StateObject var viewModel: VM_SkillsView = VM_SkillsView()
    
    var body: some View {
        
        VStack(spacing: 0){
            
            Spacer()
                .frame(height: 20)
            
            viewModel.skillsInfoTitle
            
            ScrollView(showsIndicators: false){
                
                ForEach(viewModel.skillsArray){skill in
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text(skill.skill)
                            .font(.system(size: 19, weight: .regular))

                        Text(skill.level)
                            .font(.system(size: 15))

                        
                        Divider().padding(.top)
                            
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                    .padding(.horizontal)
                    .background(.white)
                    .contextMenu{
                        Button {
                            viewModel.removeSkill(id: skill.id)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                
                
                Button {
                    viewModel.openSheet = true
                } label: {
                    HStack{
                        Text("Add skill...")
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
                                .font(.system(size: 1, weight: .bold))
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
            AddSkillSheet()
        }
    }
}


struct Deatails_SkillsView_Previews: PreviewProvider {
    static var previews: some View {
        Details_SkillsView()
    }
}

