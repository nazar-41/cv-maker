//
//  ProfileView.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 21/05/2022.
//

import SwiftUI
import Combine
import PhotosUI


struct ProfileView: View {
    @AppStorage("fullName") var fullName: String = ""
    @AppStorage("birthDate") var birthDate: Date = Date()
    
    @AppStorage("email") var email: String = ""
    @AppStorage("phone") var phone: String = ""
    
    @AppStorage("address") var address: String = ""
    @AppStorage("postcode") var postcode: String = ""
    @AppStorage("city") var city: String = ""
    @AppStorage("region") var region: String = ""
    @AppStorage("country") var country: String = ""
  
    
    @State private var showDatePicker: Bool = false
    
    @State private var showImagePicker: Bool = false
    
    @State private var profileImage: Image? = nil
    @State private var inputImage: UIImage? = nil
    
    let requiredIcon = Text("*").foregroundColor(.red)
    
    private var contactInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Contact Info")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }.padding(.vertical, 5)
    }
    
    private var locationInfoTitle: some View {
        VStack(alignment: .leading){
            Text("Location")
                .font(.title)
                .fontWeight(.medium)
            Divider()
            
        }.padding(.vertical, 5)
    }
    
    private var dateOfBirthItem: some View{
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 10){
                Text("Date of Birth ") + requiredIcon
                
                Text(birthDate, format: .dateTime.day().month().year())
                    .foregroundColor(.gray)

                if showDatePicker{
                    VStack(alignment: .leading, spacing: 0){
                        
                        DatePicker("", selection: $birthDate, in: ...Date.now, displayedComponents: .date)
                            .fixedSize()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .datePickerStyle(WheelDatePickerStyle())
                        
                    }
                }
                HStack{
                    Spacer()
                    
                    Image(systemName: "calendar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                
                Divider()
            }
            .background(.white)
            .onTapGesture {
                withAnimation{
                    showDatePicker.toggle()
                }
            }
        }.padding(.vertical, 5)
    }
    
    private func contactInfoItem(title: String, placeholder: String, bindingValue: Binding<String>, isRequred: Bool = false) -> some View{
        VStack(alignment: .leading){
            isRequred ? (Text("\(title) ") + requiredIcon) : Text("\(title)")
            TextField(placeholder, text: bindingValue)
                .submitLabel(.continue)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Divider()
        }.padding(.vertical, 5) // Full name
    }
    
    private func phoneNumbeInfoTitle(title: String, placeholder: String, bindingValue: Binding<String>) -> some View{
        VStack(alignment: .leading){
            Text(title)
            TextField(placeholder, text: bindingValue)
                .submitLabel(.continue)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .keyboardType(UIKeyboardType.phonePad)
            
            Divider()
        }.padding(.vertical, 5) // Full name
    }
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
        
        profileImage = Image(uiImage: inputImage)
    

    }
    
    var body: some View {
        VStack(spacing: 0){
                
                ScrollView(showsIndicators: false){
//                    HStack{
//                        ZStack{
//                            if let profileImage = profileImage {
//                                profileImage
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                            }else{
//                                Color.gray.opacity(0.15)
//                                Image(systemName: "camera")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 50, height: 50)
//                                    .foregroundColor(.gray.opacity(0.7))
//                            }
//                        }
//                        .frame(width: 170, height: 170, alignment: .center)
//                        .cornerRadius(20)
//                        .onTapGesture {
//                            showImagePicker = true
//                        }
//                    }
                    
                    VStack(alignment: .leading){
                        
                        Group{
                            contactInfoTitle // Contact Info
                            
                            contactInfoItem(title: "Full name",
                                            placeholder: "John Doe",
                                            bindingValue: $fullName,
                                            isRequred: true)
                            
                            dateOfBirthItem  // Date of Birth
                        
                            contactInfoItem(title: "Email",
                                            placeholder: "johndoe@gmail.com",
                                            bindingValue: $email) // Email
                            
                            phoneNumbeInfoTitle(title: "Phone", placeholder: "(+993) 65 123456", bindingValue: $phone) // Phone
                            
                        
                        }
                        
                        Spacer().frame(height: 40) // Some space
                        
                        Group{
                            locationInfoTitle // Location title
                            
                            contactInfoItem(title: "Address",
                                            placeholder: "457 54 St.",
                                            bindingValue: $address) // Adress
                            
                            contactInfoItem(title: "Postcode",
                                            placeholder: "10014",
                                            bindingValue: $postcode) // Postcode
                            
                            contactInfoItem(title: "City",
                                            placeholder: "New York",
                                            bindingValue: $city) // City
                            
                            contactInfoItem(title: "Region",
                                            placeholder: "NY",
                                            bindingValue: $region) // Region
                            
                            contactInfoItem(title: "Country",
                                            placeholder: "USA",
                                            bindingValue: $country) // Country
                            
                            
                        } // Location Info
                        
                        Spacer().frame(height: 40) // Some space
                        
                    }
                    .padding(.horizontal)
                    .foregroundColor(Color("c_text"))
                    
                    Spacer()
                    
                }
                .adaptsToKeyboard()

            
        }
        .onTapGesture {
            endEditing()
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct AdaptsToKeyboard: ViewModifier {
    @State var currentHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.currentHeight)
                .onAppear(perform: {
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
                        .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
                        .compactMap { notification in
                            withAnimation(.easeOut(duration: 0.1)) {
                                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                            }
                        }
                        .map { rect in
                            rect.height - geometry.safeAreaInsets.bottom + 20
                        }
                        .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                    
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
                        .compactMap { notification in
                            CGFloat.zero
                        }
                        .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                })
        }
    }
}

extension View {
    func adaptsToKeyboard() -> some View {
        return modifier(AdaptsToKeyboard())
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
//
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        var config = PHPickerConfiguration()
//        config.filter = .images
//        let picker = PHPickerViewController(configuration: config)
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//        let parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            picker.dismiss(animated: true)
//
//            guard let provider = results.first?.itemProvider else { return }
//
//            if provider.canLoadObject(ofClass: UIImage.self) {
//                provider.loadObject(ofClass: UIImage.self) { image, _ in
//                    self.parent.image = image as? UIImage
//                }
//            }
//        }
//    }
//}
