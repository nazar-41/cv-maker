//
//  Details_LanguagesView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_LanguagesView: View {
    @StateObject var viewModel: VM_LanguagesView = VM_LanguagesView()
    
    
    var body: some View {
        
        VStack(spacing: 0){
            
            Spacer()
                .frame(height: 20)
            
            viewModel.languagesInfoTitle
            
            ScrollView(showsIndicators: false){
                
                ForEach(viewModel.languagesArray){language in
                    
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
                            viewModel.removeLanguage(id: language.id)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                
                
                Button {
                    viewModel.openSheet = true
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
        .sheet(isPresented: $viewModel.openSheet) {
            AddLanuageSheet()
        }
    }
}

struct Details_LanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        Details_LanguagesView()
    }
}
