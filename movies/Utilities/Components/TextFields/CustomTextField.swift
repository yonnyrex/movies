//
//  CustomTextField.swift
//  movies
//
//  Created by Yonny on 30/11/24.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    
    // MARK: - Properties
    let placeholder: String
    var isPassword: Bool = false

    // MARK: - PropertyWrappers
    @State var showPassword = false
    @Binding var text: String
    
    // MARK: - Body
    var body: some View {
        ZStack (alignment: .leading) {
            Text(placeholder)
                .font(
                    .system(
                        size: self.text.isEmpty ? 16 : 12,
                        weight: .regular,
                        design: .rounded
                    )
                )
                .foregroundColor(
                    Color("Black")
                        .opacity(0.2)
                )
                .padding(
                    .horizontal,
                    self.text.isEmpty ? 0 : 10
                )
                .background(
                    Color("White")
                )
                .offset(
                    y: self.text.isEmpty ? 0 : -28
                )
                .scaleEffect(
                    self.text.isEmpty ? 1 : 0.9,
                    anchor: .leading
                )
            
            if isPassword {
                HStack {
                    if showPassword {
                        TextField(
                            "",
                            text: self.$text
                        )
                        .font(
                            .system(
                                size: 16,
                                weight: .regular,
                                design: .rounded
                            )
                        )
                        .foregroundColor(
                            Color("Black")
                        )
                    } else {
                        SecureField(
                            "",
                            text: self.$text
                        )
                        .font(
                            .system(
                                size: 16,
                                weight: .regular,
                                design: .rounded
                            )
                        )
                        .foregroundColor(
                            Color("Black")
                        )
                    }
                  
                    Button(action: {
                        self.showPassword.toggle()
                    }) {
                        Image(systemName: "eye")
                        .foregroundColor(.secondary)
                    }
                }
                
            } else {
                TextField(
                    "",
                    text: self.$text
                )
                .font(
                    .system(
                        size: 16,
                        weight: .regular,
                        design: .rounded
                    )
                )
                .foregroundColor(
                    Color("Black")
                )
            }
        }
        .animation(.easeOut, value: !text.isEmpty)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .stroke(self.text.isEmpty ? Color("Black").opacity(0.2) : Color("Black").opacity(0.2), lineWidth: 1)
                .frame(height: 55)
        )
    }
    
}
