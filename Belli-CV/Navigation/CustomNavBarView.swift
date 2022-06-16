//
//  CustomNavBarView.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 9/8/21.
//

import SwiftUI

struct CustomNavBarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let showDivider: Bool
    let title: String?
    //let subtitle: String?
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                if showBackButton {
                    backButton
                }
                Spacer()
                titleSection
                Spacer()
                if showBackButton {
                    backButton
                        .opacity(0)
                }
            }
            .padding()
            .accentColor(Color("c_text"))
            .foregroundColor(Color("c_text"))
            .font(.title3)
            
            if showDivider{
                dividerLine
            }
        }
       // .background(Color("c_white"))
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0){
            CustomNavBarView(showBackButton: true, showDivider: true, title: "Title here")
            Spacer()
        }
    }
}


extension CustomNavBarView {
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    
    private var dividerLine: some View{
        Divider()
    }
    
    private var titleSection: some View {
        VStack(spacing: 4) {
            if let title = title {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
            }
        }
    }
}
