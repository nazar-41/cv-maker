//
//  Details_Hobbies&InterestsView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_Hobbies_InterestsView: View {
    @AppStorage("hobbiesArray") var hobbiesArray: [HobbiesModel] = []
    
    
    @State private var openSheet: Bool = false
    
    
    private var hobbiesInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Hobbies & Interests")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            
            Spacer()
                .frame(height: 20)
            
            hobbiesInfoTitle
            
            ScrollView(showsIndicators: false){
                ForEach(hobbiesArray){hobby in
                    
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
                            removeHobby(id: hobby.id)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                
                Button {
                    openSheet = true
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
        .sheet(isPresented: $openSheet) {
            AddHobbySheet()
        }
    }
    
    private func removeHobby(id: String){
        if let index = hobbiesArray.firstIndex(where: {$0.id == id}) {
            hobbiesArray.remove(at: index)
            print("deleted succesfully")
        }else{
            print("Error while deleting")
        }
    }
}

struct Details_Hobbies_InterestsView_Previews: PreviewProvider {
    static var previews: some View {
        Details_Hobbies_InterestsView()
    }
}

struct AddHobbySheet: View{
    @AppStorage("hobbiesArray") var hobbiesArray: [HobbiesModel] = []
    
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var hobby: String = ""
    
    
    private var isSaveButtonDisabled: Bool{
        if hobby.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    private func saveHobby(){
        let data = HobbiesModel(hobby: hobby)
        hobbiesArray.append(data)
        presentationMode.wrappedValue.dismiss()
        hobby = ""
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
                
                Text("Add hobby")
                    .font(.system(size: 21, weight: .semibold))
                
                
                Spacer()
                
                Button {
                    saveHobby()
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
                Section(header: Text("summary")){
                    VStack(spacing: 0){
                        
                        TextField("Football", text: $hobby)
                            .font(.system(size: 19))
                        
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
