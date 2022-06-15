//
//  test.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 28/05/2022.
//

import SwiftUI
import Combine


//struct test: View {
//    @State private var text: String = ""
//    @State private var keyboardHeight: CGFloat = 0
//
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            
//            TextField("Enter something", text: $text)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//        }
//        .padding()
//        .keyboardAdaptive() // Apply the modifier
//    }
//}
//
//struct test_Previews: PreviewProvider {
//    static var previews: some View {
//        test()
//    }
//}
//
//
//extension Publishers {
//    // 1.
//    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
//        // 2.
//        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
//            .map { $0.keyboardHeight }
//        
//        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
//            .map { _ in CGFloat(0) }
//        
//        // 3.
//        return MergeMany(willShow, willHide)
//            .eraseToAnyPublisher()
//    }
//}
//extension Notification {
//    var keyboardHeight: CGFloat {
//        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
//    }
//}
//
//
//extension View {
//    func keyboardAdaptive() -> some View {
//        ModifiedContent(content: self, modifier: KeyboardAdaptive())
//    }
//}
//extension UIResponder {
//    static var currentFirstResponder: UIResponder? {
//        _currentFirstResponder = nil
//        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
//        return _currentFirstResponder
//    }
//
//    private static weak var _currentFirstResponder: UIResponder?
//
//    @objc private func findFirstResponder(_ sender: Any) {
//        UIResponder._currentFirstResponder = self
//    }
//
//    var globalFrame: CGRect? {
//        guard let view = self as? UIView else { return nil }
//        return view.superview?.convert(view.frame, to: nil)
//    }
//}
//struct KeyboardAdaptive: ViewModifier {
//    @State private var bottomPadding: CGFloat = 0
//    
//    func body(content: Content) -> some View {
//        // 1.
//        GeometryReader { geometry in
//            content
//                .padding(.bottom, self.bottomPadding)
//                // 2.
//                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
//                    // 3.
//                    let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
//                    // 4.
//                    let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
//                    // 5.
//                    self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom)
//            }
//            // 6.
//            .animation(.easeOut(duration: 0.16))
//        }
//    }
//}
