//
//  LoginView.swift
//  movies
//
//  Created by Yonny on 30/11/24.
//

import SwiftUI

struct LoginView: View {

    // MARK: - PropertyWrappers
    @ObservedObject private var viewModel: LoginViewModel

    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                welcomeTitle
                form
                Spacer()
                loginButton
            }
            .padding(.horizontal, 20)
            .alert(isPresented: $viewModel.displayError) {
                Alert(
                    title: Text(viewModel.error?.errorDescription ?? "Error"),
                    message: Text(viewModel.error?.failureReason ?? "Ocurrió un error inesperado."),
                    dismissButton: .cancel(Text("Ok"))
                )
            }
            .disabled(viewModel.isLoading)
        }
    }
    
    // MARK: - WelcomeTitle
    var welcomeTitle: some View {
        VStack(alignment: .leading) {
            Text("Bienvenido")
                .font(.system(size: 16, weight: .regular))
            Text("Inicia sesión")
                .font(.system(size: 30, weight: .bold))
        }
        .frame(
            maxWidth: .greatestFiniteMagnitude,
            alignment: .leading
        )
        .padding(.top, 100)
    }
    
    // MARK: - Form
    var form: some View {
        VStack(spacing: 40) {
            CustomTextField(placeholder: "Usuario", text: $viewModel.user)
            CustomTextField(placeholder: "Contraseña", isPassword: true, text: $viewModel.password)
        }.padding(.top, 31)
    }
    
    // MARK: - LoginButton
    var loginButton: some View {
        Button(
            action: {
                viewModel.login()
            },
            label: {
                Text("Ingresar")
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .center)
                    .foregroundColor(Color("White"))
                    .padding(15)
                    .frame(maxWidth: .greatestFiniteMagnitude)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color("Black"))
                    }
                    .padding(.bottom, 50)
            }
        )
    }
    
}

#Preview {
    LoginView()
}
