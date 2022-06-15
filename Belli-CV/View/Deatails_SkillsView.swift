//
//  Deatails_SkillsView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Deatails_SkillsView: View {
    @AppStorage("skillsArray") var skillsArray: [SkillModel] = []
    
    @State private var openSheet: Bool = false
    
    private var skillsInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Skills")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }
        .padding(.top, 5)
        .padding(.horizontal)
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            
            Spacer()
                .frame(height: 20)
            
            skillsInfoTitle
            
            ScrollView(showsIndicators: false){
                
                ForEach(skillsArray){skill in
                    
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
                            removeSkill(id: skill.id)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                
                
                
                Button {
                    openSheet = true
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
        .sheet(isPresented: $openSheet) {
            AddSkillSheet()
        }
    }
    private func removeSkill(id: String){
        
        if let index = skillsArray.firstIndex(where: {$0.id == id}) {
            skillsArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
}


struct Deatails_SkillsView_Previews: PreviewProvider {
    static var previews: some View {
        Deatails_SkillsView()
    }
}


struct AddSkillSheet: View{
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("skillsArray") var skillsArray: [SkillModel] = []
    
    
    
    @State private var title: String = ""
    
    @State private var skillLevel: SkillLevel = .Basic
    
    
    private var isSaveButtonDisabled: Bool{
        if title.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    private func saveAddedSkill(){
        let data = SkillModel(skill: title, level: skillLevel.rawValue)
        
        skillsArray.append(data)
        
        presentationMode.wrappedValue.dismiss()
        
        title = ""
        skillLevel = .Basic
        
    }
    
    
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
                
                Text("Add skill")
                    .font(.system(size: 21, weight: .semibold))
                
                
                Spacer()
                
                Button {
                    saveAddedSkill()
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
                Section{
                    VStack(spacing: 0){
                        HStack{
                            Group{
                                Text("Title ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("Strategic planning", text: $title)
                                .font(.system(size: 17))
                            
                        }
                        .padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 10)
                        
                        HStack{
                            Text("Level ")
                                .font(.system(size: 19))
                            
                            Spacer()
                            Menu {
                                Picker(selection: $skillLevel) {
                                    ForEach(SkillLevel.allCases ,id: \.self) { value in
                                        Text(value.rawValue.capitalized)
                                            .tag(value)
                                    }
                                } label: {}
                            } label: {
                                Text(skillLevel.rawValue)
                                    //.font(.custom("Franca-Book", size: 15))
                                    .frame(maxWidth: .infinity, alignment:.trailing)
                                    .padding(.leading, 20)
                                    .foregroundColor(Color("c_continue_button"))
                            }
                        }
                        .padding(.vertical, 10)


                    }
                }
            }
            .listStyle(GroupedListStyle())
            
        }
        .onTapGesture(perform: endEditing)
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

enum SkillLevel: String, CaseIterable, Identifiable{
    case Basic, Average, Proficient, Advanced, Expert
    
    var id: String {self.rawValue}
}
