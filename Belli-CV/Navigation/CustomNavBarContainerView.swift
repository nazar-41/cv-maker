//
//  CustomNavBarContainerView.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 9/8/21.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var showDividerLine: Bool = true
    @State private var title: String? = nil
    //@State private var subtitle: String? = nil

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(showBackButton: showBackButton, showDivider: showDividerLine, title: title)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color("c_white"))
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self, perform: { value in
            self.title = value
        })

        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self, perform: { value in
            self.showBackButton = !value
        })
        .onPreferenceChange(CustomNavBarDividerHiddenPreferenceKey.self, perform: { value in
            self.showDividerLine = !value
        })
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView {
//            ZStack {
//                Color.green.ignoresSafeArea()
//
//                Text("Hello, world!")
//                    .foregroundColor(.white)
//                    .customNavigationTitle("New Title")
//                    .customNavigationSubtitle("subtitle")
//                    .customNavigationBarBackButtonHidden(true)
//            }
            VStack{
                
            }
        }
    }
}
