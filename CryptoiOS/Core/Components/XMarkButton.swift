//
//  XMarkButton.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 28.05.2024.
//

import SwiftUI

/// A button with an 'X' mark to dismiss the view.
struct XMarkButton: View {
    
    /// Presentation mode environment value.
    @Environment(\.presentationMode) var presentationMode
    
    /// The view for the XMarkButton.
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton()
}
