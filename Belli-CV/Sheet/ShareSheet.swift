//
//  Share.swift
//  Belli-CV
//
//  Created by Belli's MacBook on 15/06/2022.
//

import Foundation
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable{
    var urls: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
