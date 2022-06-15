//
//  MultilineTextfield.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 31/05/2022.
//

import SwiftUI

struct MultilineTextfield: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String
    
    init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .clear
        textView.autocapitalizationType = .sentences
        textView.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        textView.textColor = UIColor.placeholderText
        textView.text = placeholder
        
        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        if self.text == "" {
            textView.text = placeholder
            textView.textColor = UIColor.placeholderText
        } else {
            textView.text = text
            textView.textColor = UIColor.label
        }
    }
    

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: MultilineTextfield

        init(_ textView: MultilineTextfield) {
            self.parent = textView
        }
        
        func getSubstring(_ text: String?) -> String {
            if let str = text {
                return String(str.prefix(1))
            } else {
                return ""
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
                if textView.textColor == UIColor.placeholderText {
                    if textView.text.count < parent.placeholder.count {
                        textView.text = parent.placeholder
                        parent.text = ""
                    } else {
                        textView.text = getSubstring(textView.text)
                        textView.textColor = UIColor.label
                        parent.text = textView.text ?? ""
                    }
                    
                } else if textView.markedTextRange == nil {
                    parent.text = textView.text ?? ""
                }
        }
        
        func textViewDidChangeSelection(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.selectedRange = NSMakeRange(0, 0)
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = UIColor.placeholderText
            }
        }
    }
}
