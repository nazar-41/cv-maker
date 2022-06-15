//
//  SplashScreenView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 20/05/2022.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive: Bool = true
    @State private var size: CGFloat = 0
    @State private var opacity: CGFloat = 0.5
        
    var body: some View {
        if isActive{
            
            ZStack{
                Color("c_continue_button")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20){
                    
                    Image(systemName: "doc.fill.badge.plus")
                        .font(.system(size: 120))
                        .foregroundColor(.white)
                    
                    Text("CV Maker")
                        .foregroundColor(.white)
                        .font(.system(size: 45, weight: .bold))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)){
                        self.size = 1
                        self.opacity = 1
                    }
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        isActive = false
                    }
                }
            }
        }else{
            HomeView()
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

