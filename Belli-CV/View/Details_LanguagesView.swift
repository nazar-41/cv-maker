//
//  Details_LanguagesView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_LanguagesView: View {
    @AppStorage("languagesArray") var languagesArray: [LanguageModel] = []

    
    
    @State private var openSheet: Bool = false
    
    
    private var languagesInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Languages")
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
            
            languagesInfoTitle
            
            ScrollView(showsIndicators: false){
                
                ForEach(languagesArray){language in
                    
                    VStack(alignment: .leading, spacing: 1){
                        Text(language.language)
                            .font(.system(size: 19, weight: .regular))

                        Text(language.level)
                            .font(.system(size: 15))

                        Divider().padding(.top)
                            
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                    .padding(.horizontal)
                    .background(.white)
                    .contextMenu{
                        Button {
                            removeLanguage(id: language.id)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                
                
                Button {
                    openSheet = true
                } label: {
                    HStack{
                        Text("Add language...")
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
        .sheet(isPresented: $openSheet) {
            AddLanuageSheet()
        }
    }
    
    
    private func removeLanguage(id: String){
        
        if let index = languagesArray.firstIndex(where: {$0.id == id}) {
            languagesArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
}
struct Details_LanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        Details_LanguagesView()
    }
}


struct AddLanuageSheet: View{
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("languagesArray") var languagesArray: [LanguageModel] = []
    
    
    @State private var language: String = ""
    
    @State private var languageLevel: LanguageLevel = .Beginner
    
    
    private var isSaveButtonDisabled: Bool{
        if language.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    private func addLanguage(){
        let data = LanguageModel(language: language, level: languageLevel.rawValue)
        
        languagesArray.append(data)
        
        presentationMode.wrappedValue.dismiss()
        
        language = ""
        languageLevel = .Beginner
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
                
                Text("Add language")
                    .font(.system(size: 21, weight: .semibold))
                
                
                Spacer()
                
                Button {
                    addLanguage()
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
                                Text("Language ").font(.system(size: 19)) + Text("*").foregroundColor(.red)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            TextField("English", text: $language)
                                .font(.system(size: 17))
                            
                        }
                        .padding(.vertical, 10)
                        
                        Divider().padding(.vertical, 10)
                        
                        HStack{
                            Text("Level ")
                                .font(.system(size: 19))
                            
                            Spacer()
                            Menu {
                                Picker(selection: $languageLevel) {
                                    ForEach(LanguageLevel.allCases ,id: \.self) { value in
                                        Text(value.rawValue.capitalized)
                                            .tag(value)
                                    }
                                } label: {}
                            } label: {
                                Text(languageLevel.rawValue)
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

enum LanguageLevel: String, CaseIterable, Identifiable{
    case Beginner
    case Elementary
    case Intermediate
    case Upper_Intermediate = "Upper Intermediate"
    case Advanced
    case Proficient
    case Native
    
    var id: String {self.rawValue}
}
