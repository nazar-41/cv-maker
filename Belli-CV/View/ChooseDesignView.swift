//
//  ChooseDesignView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 14/06/2022.
//

import SwiftUI

struct ChooseDesignView: View {
    @State private var selected: Int = 0
    @AppStorage("designColor") var dc: DesignColors = .d1
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var body: some View {
        TabView(selection: $selected) {
            // Images
            ForEach(1...4, id: \.self) { index in
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                    // Geometry reader for parallax effect
                    GeometryReader { reader in
                        Image("img-d\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            // Moving view in opposite side
                            // When user starts to swipe
                            // This will create parallax effect
                            .offset(x: -reader.frame(in: .global).minX)
                            .frame(width: width, height: height / 1.3)
                    }
                    .frame(height: height / 1.3)
                    .cornerRadius(15)
                    //.padding(10)
                    .background(Color.white)
                    .cornerRadius(15)
                    // Shadow
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: -5, y: -5)
                    // Decreasing width by padding
                    // So outer view only decreased
                    // Inner image will be full width

                    // Bottom image
                    //Image("pic")
                    ZStack{
                        Color("c_d\(index)")
                            .frame(width: 55, height: 55)
                        
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .opacity(dc.rawValue == "c_d\(index)" ? 1 : 0)
                    }
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                        .padding(5)
                        .background(Color.white)
                        .clipShape(Circle())
                        .offset(x: -15, y: 25)
                })
                .padding(.horizontal, 25)
                .onTapGesture {
                    if index == 1{
                        dc = .d1
                    }else if index == 2{
                        dc = .d2
                    }else if index == 3{
                        dc = .d3
                    }else if index == 4{
                        dc = .d4
                    }else{
                        dc = .d1
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct ChooseDesignView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDesignView()
    }
}
