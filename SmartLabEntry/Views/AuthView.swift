//
//  AuthView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 26.10.2023.
//

import SwiftUI

struct AuthView: View {
    @State private var isPasswordVisible: Bool = false
    @State private var isSecondPasswordVisible: Bool = false
    @StateObject var alertService = AlertService.shared
    @ObservedObject private var viewModel = AuthViewModel()

    var body: some View {
        VStack {
            Spacer()
            Divider()
            headerView
            authenticationView
            socialAuthButtonsView
            Spacer()
        }
        .background(
            AppTheme.backgroundGradientView
        )
        .alert(isPresented: $alertService.isPresenting) {
            alertService.alert
        }
    }

    var headerView: some View {
        Text(Localization.ailab)
            .font(.custom("Comfortaa", size: 100))
            .fontWeight(.bold)
            .foregroundColor(AppTheme.lightColor)
            .multilineTextAlignment(.center)
            .padding(.bottom, 20)
    }

    var authenticationView: some View {
        VStack {
            toggleLoginRegisterView
            
            if viewModel.isLogin == 0 { loginView }
            else if viewModel.isLogin == 1 { registerFirstView }
            else if viewModel.isLogin == 2 { registerSecondView }
            else if viewModel.isLogin == 3 { forgotPasswordView }
            else { Text(Localization.error) }
            Spacer()
        }
        .frame(width: 350, height: authenticationViewHeight)
        .background(AppTheme.lightColor)
        .cornerRadius(20)
    }

    var authenticationViewHeight: CGFloat {
        switch viewModel.isLogin {
        case 0:
            return 350
        case 1, 2:
            return 400
        case 3:
            return 250
        default:
            return 350
        }
    }

    var toggleLoginRegisterView: some View {
        HStack {
            AuthButton(title: Localization.Login, isSelected: viewModel.isLogin == 0) {
                withAnimation {
                    viewModel.isLogin = 0
                }
            }
            AuthButton(title: Localization.Register, isSelected: viewModel.isLogin == 1 || viewModel.isLogin == 2) { withAnimation {
                viewModel.isLogin = 1
            } }
        }
        .frame(width: 320, height: 60)
        .background(AppTheme.blueColor)
        .cornerRadius(20)
        .padding(.vertical)
    }

    func AuthButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(isSelected ? AppTheme.darkBlueColor : AppTheme.lightColor)
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .background(isSelected ? AppTheme.lightColor : Color.clear)
                .cornerRadius(15)
        }
    }

    var loginView: some View {
        VStack {
            authTextField(Localization.email, text: $viewModel.email)
            passwordField(text: $viewModel.password, isVisible: $isPasswordVisible)
            forgotPasswordButton
            actionButton(Localization.Login) { print("Login button pressed") }
        }
    }

    var registerFirstView: some View {
        VStack {
            authTextField(Localization.name, text: $viewModel.name)
            authTextField(Localization.surname, text: $viewModel.surname)
            authTextField(Localization.schoolid, text: $viewModel.schoolId)
            actionButton(Localization.next) { withAnimation { viewModel.isLogin = 2 } }
        }
    }

    var registerSecondView: some View {
        VStack {
            authTextField(Localization.personalEmail, text: $viewModel.email)
            passwordField(text: $viewModel.password, isVisible: $isPasswordVisible)
            passwordField(text: $viewModel.confirmPassword, isVisible: $isSecondPasswordVisible, placeholder: Localization.confirmPassword)
            actionButton(Localization.Register) { print("Register button pressed") }
        }
    }

    var forgotPasswordView: some View {
        VStack {
            authTextField(Localization.email, text: $viewModel.email)
            actionButton(Localization.send) { print("Şifre sıfırlama maili gönderildi") }
        }
    }

    func authTextField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .foregroundStyle(.black)
            .padding()
            .background(RoundedRectangle(cornerRadius: 17.0)
                .stroke(AppTheme.darkBlueColor, lineWidth: 2))
            .frame(width: 320, height: 50)
            .padding(.bottom, 10)
    }

    func passwordField(text: Binding<String>, isVisible: Binding<Bool>, placeholder: String = Localization.password) -> some View {
        HStack {
            if isVisible.wrappedValue {
                TextField(placeholder, text: text)
            } else {
                SecureField(placeholder, text: text)
            }

            Button(action: {
                isVisible.wrappedValue.toggle()
            }) {
                Image(systemName: isVisible.wrappedValue ? "eye.slash.fill" : "eye.fill"
                ).foregroundStyle(.darkBlue)
            }
            .padding(.trailing, 5)
        }
        .padding()
        .frame(width: 320, height: 50)
        .background(RoundedRectangle(cornerRadius: 17.0)
            .stroke(AppTheme.darkBlueColor, lineWidth: 2))
        .padding(.bottom, 10)
    }

    var forgotPasswordButton: some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    viewModel.isLogin = 3
                }
            } label: {
                Text(Localization.forgotPassword)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
            }
            .padding(.top, 2)
            .padding(.horizontal, 40)
        }
    }

    func actionButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button {
            if viewModel.isLogin == 0 {
                if viewModel.validateLoginPage() {
                    withAnimation {
                        viewModel.signIn()
                    }
                }
            } else if viewModel.isLogin == 1 {
                if viewModel.validateFirstPage() {
                    withAnimation {
                        viewModel.isLogin = 2
                    }
                }
            } else if viewModel.isLogin == 2 {
                if viewModel.validateSecondPage() {
                    withAnimation {
                        viewModel.signUp()
                    }
                }
            } else if viewModel.isLogin == 3 {
                viewModel.forgotPassword()
            } else {
                alertService.showString(title: Localization.error, message: Localization.unknownError + "0x0001")
            }

        } label: {
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(AppTheme.lightColor)
                .frame(width: 320, height: 60)
                .background(AppTheme.darkBlueColor)
                .cornerRadius(15)
        }
        .frame(width: 320, height: 50)
        .padding(.top, 20)
    }

    var socialAuthButtonsView: some View {
        HStack(spacing: 10) {
            SocialButton(name: AppTheme.instagramLogo) { print("Instagram button pressed") }
            SocialButton(name: AppTheme.linkedinLogo) { print("Linkedin button pressed") }
            SocialButton(name: AppTheme.Logo) { print("KTUN Ai Lab button pressed") }
        }
        .frame(width: 350, height: 70)
        .background(AppTheme.lightColor)
        .cornerRadius(20)
        .padding(.top)
    }

    func SocialButton(name: String, action: @escaping () -> Void) -> some View {
        Button{
            switch name{
            case AppTheme.instagramLogo:
                UIApplication.shared.open(Constants.instagramURL)
                case "Linkedin":
                UIApplication.shared.open(Constants.linkedinURL)
                case "Logo":
                UIApplication.shared.open(Constants.ktunAiLabURL)
                default:
                    print("Social Button Error: \(name) is not a valid social provide")
            }
        }label: {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 37, height: 37)
                .frame(width: 105, height: 55)
                .background(AppTheme.darkBlueColor)
                .cornerRadius(15)
        }
    }
}

#Preview {
    AuthView()
}
