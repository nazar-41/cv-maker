//
//  HomeView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 20/05/2022.
//

import SwiftUI
//import SwiftfulSaving

struct HomeView: View {
    //@State private var isCreated: Bool = false
    var isCreated: Bool {
        if position.isEmpty{
            return false
        }else{
            return true
        }
    }
    
    
    @State private var profileImage: UIImage? = nil
    
    
    
    //MARK: - Personal Info
    @AppStorage("fullName") var fullName: String = ""
    @AppStorage("birthDate") var birthDate: Date = Date()
    
    @AppStorage("email") var email: String = ""
    @AppStorage("phone") var phone: String = ""
    @AppStorage("address") var address: String = ""
    @AppStorage("postcode") var postcode: String = ""
    @AppStorage("city") var city: String = ""
    @AppStorage("region") var region: String = ""
    @AppStorage("country") var country: String = ""
    
    
    //MARK: - Career Objective
    @AppStorage("personalStatement") var personalStatement: String = ""
    @AppStorage("position") var position: String = ""
    
    //MARK: - Professional Experience
    @AppStorage("workedPlacesArray") var workedPlacesArray: [WorkedPlaceModel] = []
    
    //MARK: - Education
    @AppStorage("educationArray") var educationArray: [EducationModel] = []
    
    //MARK: - Skills
    @AppStorage("skillsArray") var skillsArray: [SkillModel] = []
    
    //MARK: - Languages
    @AppStorage("languagesArray") var languagesArray: [LanguageModel] = []
    
    //MARK: - Hobbies
    @AppStorage("hobbiesArray") var hobbiesArray: [HobbiesModel] = []
    
    //MARK: - Certificates
    @AppStorage("certificatesArray") var certificateArray: [CertificateModel] = []
    
    
    @State private var showSheet: Bool = false
    
    var calculate: Int {
        var totalScore: Int = 3
        
        if !fullName.isEmpty{
            totalScore += 1
        }
        if !birthDate.rawValue.isEmpty{
            totalScore += 1
        }
        if !email.isEmpty{
            totalScore += 1
        }
        if !phone.isEmpty{
            totalScore += 1
        }
        if !address.isEmpty{
            totalScore += 1
        }
        if !postcode.isEmpty{
            totalScore += 1
        }
        if !city.isEmpty{
            totalScore += 1
        }
        if !region.isEmpty{
            totalScore += 1
        }
        if !country.isEmpty{
            totalScore += 1
        }
        if !personalStatement.isEmpty{
            totalScore += 1
        }
        if !position .isEmpty{
            totalScore += 1
        }
        if !workedPlacesArray.isEmpty{
            totalScore += 1
        }
        if !educationArray.isEmpty{
            totalScore += 1
        }
        if !skillsArray.isEmpty{
            totalScore += 1
        }
        if !languagesArray.isEmpty{
            totalScore += 1
        }
        if !hobbiesArray.isEmpty{
            totalScore += 1
        }
        if !certificateArray .isEmpty{
            totalScore += 1
        }
        
        
        return Int(totalScore * 5)
    }
    
    
    var body: some View {
        CustomNavView {
            
            VStack {
                CustomNavLink(destination: ProfileView().customNavBarItems(dividerLineHidden: true)) {
//                    ProfileIconView(profileImage: profileImage)
                    HStack{
                        Spacer()
                        
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
                
                DetectCreatedCV(showSheet: $showSheet, completed: calculate)
                
            }
            .customNavBarItems(backButtonHidden: true, dividerLineHidden: true)
            
            Spacer()
        }
        .sheet(isPresented: $showSheet) {
            ResultView()
        }
        .onAppear {
            print(PublicData().something)
            PublicData().something = "new data"
            print(PublicData().something)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
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
    
    @AppStorage("position") var position: String = ""
    @AppStorage("workedPlacesArray") var workedPlacesArray: [WorkedPlaceModel] = []
    
    @StateObject var viewModel = ShareSheetViewModel()
    //MARK: Pdf properties

    @AppStorage("designColor") var dc: DesignColors = .d1
    
    @AppStorage("createdDate") var createdDate: Date = .now

    var completed: Int
    
    var body: some View{
        ZStack {
            Color(dc.rawValue)
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
                    
                       // .frame(maxWidth: .infinity, alignment: .trailing)
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
                                        .foregroundColor(Color(dc.rawValue))
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
                                    .foregroundColor(Color(dc.rawValue))
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
    @AppStorage("position") var position: String = ""
    
    @Binding var showSheet: Bool
    
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
            
            CVCardHomeView(completed: completed).opacity(isCreated ? 1 : 0)
                .onTapGesture {
                    showSheet = true
                }
        }
    }
}


struct ShareSheet: UIViewControllerRepresentable{
    var urls: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}


class ShareSheetViewModel: ObservableObject{
    @Published var pdfURL: URL?
    @Published var showShareSheet: Bool = false
}
