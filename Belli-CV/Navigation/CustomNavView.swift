//
//  CustomNavView.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 9/8/21.
//

import SwiftUI

struct CustomNavView<Content:View>: View {
    //@Environment(\.colorScheme) var colorScheme
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            CustomNavBarContainerView {
                content
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        //.background(Color("c_white"))
//        .navigationViewStyle(.stack)
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            Color("c_white").ignoresSafeArea()
        }
    }
}

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
