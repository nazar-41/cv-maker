//
//  HomeView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 20/05/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: VM_HomeView = VM_HomeView()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        CustomNavView {
            
            VStack {
                HStack{
                    Spacer()
                    CustomNavLink(destination: ProfileView().customNavBarItems(dividerLineHidden: true)) {
                        ZStack{
                            Color("c_continue_button")
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                .padding(12)
                        }
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                        .padding()
                    }
                }
                DetectCreatedCV(showSheet: $viewModel.showSheet, position: viewModel.position, workedPlacesArray: viewModel.workedPlacesArray, dc: viewModel.dc, createdDate: viewModel.createdDate, completed: viewModel.calculate)
            }
            .customNavBarItems(backButtonHidden: true, dividerLineHidden: true)
            
            Spacer()
        }
        .sheet(isPresented: $viewModel.showSheet) {
            ResultView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

struct CreateNewCVCardView: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                
                Spacer()
                
                ZStack{
                    Circle()
                        .fill(.orange)
                        .frame(width: 25, height: 25)
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(.white)
                    
                }
            }
            Text("Create New CV")
                .font(.largeTitle)
            
            Spacer()
        }
        .padding(20)
        .frame(width: 300, height: 500)
        .overlay (
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.black.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [8]))
        )
        .padding(.top)
        .foregroundColor(Color("c_text"))
    }
}

struct CVCardHomeView: View{
    
    
    @StateObject var viewModel = ShareSheetViewModel()
    
    var position: String
    var workedPlacesArray: [WorkedPlaceModel]
    var dc: DesignColors
    var createdDate: Date
    var completed: Int
    
    var body: some View{
        ZStack {
            Color("c_continue_button")
                .cornerRadius(20)
            
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "person.text.rectangle")
                        .font(.system(size: 40))
                    
                    Spacer()
                    
                    VStack(alignment: .trailing){
                        HStack{
                            Text("completed")
                                .font(.system(size: 16, weight: .medium))
                            
                            Text("\(completed)%")
                                .font(.system(size: 16, weight: .heavy))
                        }
                        ZStack{
                            HStack{
                                Color.green.opacity(0.15).cornerRadius(3)
                                Spacer()
                            }
                            HStack{
                                Color.green.frame(width: CGFloat(Double(completed) * 1.5)).cornerRadius(3)
                                Spacer()
                            }
                        }
                        .frame(width: 150, height: 6)
                        .cornerRadius(3)
                    }
                }
                
                VStack{
                    Text(position)
                        .font(.system(size: 35, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(workedPlacesArray){place in
                            VStack(spacing: 1){
                                HStack{
                                    Rectangle().frame(width: 7, height: 7)
                                    Text(place.company)
                                        .font(.system(size: 19, weight: .semibold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                Text(place.position)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 16)
                                
                            }.padding(.vertical, 5)
                        }
                    }
                    HStack{
                        Text("Created")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.system(size: 12, weight: .medium))
                        
                        Text(createdDate, format: .dateTime.month().day().year())
                            .foregroundColor(.white.opacity(0.8))
                            .font(.system(size: 12, weight: .medium))
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.backward.and.arrow.down.forward")
                            .rotationEffect(Angle(degrees: 90))
                            .padding(.vertical)
                            .foregroundColor(.white.opacity(0.8))
                        
                    }
                }
                .padding(.top, 10)
                
                Spacer()
                
                VStack{
                    
                    
                    HStack(spacing: 10){
                        CustomNavLink(destination: CVDetailsView().customNavBarItems(title: "Details")) {
                            
                            ZStack{
                                Color.white
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .cornerRadius(8)
                                
                                
                                
                                HStack{
                                    Image(systemName: "doc.badge.gearshape")
                                        .foregroundColor(Color("c_continue_button"))
                                        .font(.system(size: 25))
                                    //.background(.red)
                                        .frame(width: 50)
                                    
                                    Spacer()
                                    
                                    Text("Edit")
                                        .foregroundColor(Color("c_text"))
                                        .font(.system(size: 20, weight: .regular))
                                    
                                    Spacer().frame(width: 60)
                                }
                            }
                        }
                        
                        Button {
                            exportToPDF {
                                ResultView()
                            } complition: { status, url in
                                if let url = url,status{
                                    viewModel.pdfURL = url
                                    viewModel.showShareSheet.toggle()
                                }else{
                                    print("failed to produce pdf file")
                                }
                            }
                            
                            
                        } label: {
                            ZStack{
                                Color.white
                                    .frame(width: 70, height: 60)
                                    .cornerRadius(8)
                                
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(Color("c_continue_button"))
                                    .font(.system(size: 25))
                                
                            }
                        }
                        .sheet(isPresented: $viewModel.showShareSheet) {
                            viewModel.pdfURL = nil
                        } content: {
                            if let pdfURL = viewModel.pdfURL {
                                ShareSheet(urls: [pdfURL])
                            }
                        }
                    }
                }
            }
            .padding(20)
        }
        .frame(width: 300, height: 550)
        .padding(.top)
        .foregroundColor(.white)
    }
}

struct DetectCreatedCV: View{
    //@AppStorage("position") var position: String = ""
    
    @Binding var showSheet: Bool
    
    var position: String
    var workedPlacesArray: [WorkedPlaceModel]
    var dc: DesignColors
    var createdDate: Date
    
    var completed: Int
    
    var isCreated: Bool {
        if position.isEmpty{
            return false
        }else{
            return true
        }
    }
    
    var body: some View{
        ZStack{
            CustomNavLink(destination: NewCVView().customNavBarItems(dividerLineHidden: true)) {
                CreateNewCVCardView()
            }
            
            .opacity(isCreated ? 0 : 1)
            
            CVCardHomeView(position: position, workedPlacesArray: workedPlacesArray, dc: dc, createdDate: createdDate, completed: completed).opacity(isCreated ? 1 : 0)
                .onTapGesture {
                    showSheet = true
                }
        }
    }
}

class ShareSheetViewModel: ObservableObject{
    @Published var pdfURL: URL?
    @Published var showShareSheet: Bool = false
}
