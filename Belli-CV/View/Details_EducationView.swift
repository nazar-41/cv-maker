//
//  Details_EducationView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI

struct Details_EducationView: View {
    @StateObject var viewModel: VM_EducationView = VM_EducationView()
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                
                Spacer()
                    .frame(height: 20)
                
                viewModel.educationInfoTitle
                
                ScrollView(showsIndicators: false){
                    
                    ForEach(viewModel.educationArray){place in
                        
                        VStack(alignment: .leading, spacing: 1){
                            Text(place.institution)
                                .font(.system(size: 19, weight: .regular))
                            Text(place.department)
                                .font(.system(size: 15))

                            
                            Divider().padding(.top)
                                
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 7)
                        .padding(.horizontal)
                        .background(.white)
                        .contextMenu{
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
                            Text("Add education")
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
            AddEducationSheet()
        }
    }
}

struct Details_EducationView_Previews: PreviewProvider {
    static var previews: some View {
        Details_EducationView()
    }
}


