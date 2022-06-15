//
//  Details_PersonInfoView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 27/05/2022.
//

import SwiftUI
import Foundation


struct Details_PersonalInfoView: View {
    @StateObject var viewModel: VM_DetailsPersonalInfoView = VM_DetailsPersonalInfoView()
    
    var body: some View {
        VStack{

            ScrollView(showsIndicators: false) {
                
                Group{ // Base Info
                    viewModel.contactInfoItem(title: "Full name", placeholder: "John Doe", bindingValue: $viewModel.fullName, isRequred: true)
                    
                    viewModel.dateOfBirthItem
                }
                
                Spacer().frame(height: 30)
                viewModel.contactInfoTitle
                
                Group{// Contact Info
                    viewModel.contactInfoItem(title: "Email", placeholder: "johndoe@gmail.com", bindingValue: $viewModel.email)
                    viewModel.contactInfoItem(title: "Phone", placeholder: "309940304", bindingValue: $viewModel.phone)

                }
                
                Spacer().frame(height: 30)
                viewModel.locationInfoTitle
                
                Group{ // Location Info
                    viewModel.contactInfoItem(title: "Address",
                                    placeholder: "457 54 St.",
                                              bindingValue: $viewModel.address)
                    
                    viewModel.contactInfoItem(title: "Postcode",
                                    placeholder: "10014",
                                              bindingValue: $viewModel.postcode)
                    
                    viewModel.contactInfoItem(title: "City",
                                    placeholder: "New York",
                                              bindingValue: $viewModel.city)
                    
                    viewModel.contactInfoItem(title: "Region",
                                    placeholder: "NY",
                                              bindingValue: $viewModel.region)
                    
                    viewModel.contactInfoItem(title: "Country",
                                    placeholder: "USA",
                                              bindingValue: $viewModel.country)
                }
            }
            .offset(y: -viewModel.value)
            .onAppear(perform: viewModel.moveTextField)

            .padding(.horizontal)
        }
        .foregroundColor(Color("c_text"))
    }
}

struct Details_PersonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Details_PersonalInfoView()
    }
}
