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
            LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("DarkBlue")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .alert(isPresented: $alertService.isPresenting) {
            alertService.alert
        }
    }

    var headerView: some View {
        Text("ai lab")
            .font(.custom("Comfortaa", size: 100))
            .fontWeight(.bold)
            .foregroundColor(Color("LightColor"))
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
            else { Text("Error") }
            Spacer()
        }
        .frame(width: 350, height: authenticationViewHeight) // Dinamik yükseklik
        .background(Color("LightColor"))
        .cornerRadius(20)
    }

    var authenticationViewHeight: CGFloat {
        switch viewModel.isLogin {
        case 0:
            return 350 // loginView için yükseklik
        case 1, 2:
            return 400 // registerFirstView ve registerSecondView için yükseklik
        case 3:
            return 250 // forgotPasswordView için yükseklik
        default:
            return 350 // Varsayılan yükseklik
        }
    }

    var toggleLoginRegisterView: some View {
        HStack {
            AuthButton(title: "Login", isSelected: viewModel.isLogin == 0) {
                withAnimation {
                    viewModel.isLogin = 0
                }
            }
            AuthButton(title: "Register", isSelected: viewModel.isLogin == 1 || viewModel.isLogin == 2) { withAnimation {
                viewModel.isLogin = 1
            } }
        }
        .frame(width: 320, height: 60)
        .background(Color("Blue"))
        .cornerRadius(20)
        .padding(.vertical)
    }

    func AuthButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.custom("Comfortaa", size: 20))
                .fontWeight(.bold)
                .foregroundColor(isSelected ? Color("DarkBlue") : Color("LightColor"))
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .background(isSelected ? Color("LightColor") : Color.clear)
                .cornerRadius(15)
        }
    }

    var loginView: some View {
        VStack {
            authTextField("Email", text: $viewModel.email)
            passwordField(text: $viewModel.password, isVisible: $isPasswordVisible)
            forgotPasswordButton
            actionButton("Login") { print("Giriş Yap") }
        }
    }

    var registerFirstView: some View {
        VStack {
            authTextField("Name", text: $viewModel.name)
            authTextField("Surname", text: $viewModel.surname)
            authTextField("School ID", text: $viewModel.schoolId)
            actionButton("Next") { withAnimation { viewModel.isLogin = 2 } }
        }
    }

    var registerSecondView: some View {
        VStack {
            authTextField("Personal Email", text: $viewModel.email)
            passwordField(text: $viewModel.password, isVisible: $isPasswordVisible)
            passwordField(text: $viewModel.confirmPassword, isVisible: $isSecondPasswordVisible, placeholder: "Confirm Password")
            actionButton("Register") { print("Kayıt olundu") }
        }
    }

    var forgotPasswordView: some View {
        VStack {
            authTextField("Email", text: $viewModel.email)
            actionButton("Send") { print("Şifre sıfırlama maili gönderildi") }
        }
    }

    func authTextField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .foregroundStyle(.black)
            .padding()
            .background(RoundedRectangle(cornerRadius: 17.0)
                .stroke(Color("DarkBlue"), lineWidth: 2))
            .frame(width: 320, height: 50)
            .padding(.bottom, 10)
    }

    func passwordField(text: Binding<String>, isVisible: Binding<Bool>, placeholder: String = "Password") -> some View {
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
            .stroke(Color("DarkBlue"), lineWidth: 2))
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
                Text("Forgot Password")
                    .font(.custom("Comfortaa", size: 12))
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
                alertService.showString(title: "Error", message: "Unknown error occurrer.\nCode: 0x0001")
            }

        } label: {
            Text(title)
                .font(.custom("Comfortaa", size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color("LightColor"))
                .frame(width: 320, height: 60)
                .background(Color("DarkBlue"))
                .cornerRadius(15)
        }
        .frame(width: 320, height: 50)
        .padding(.top, 20)
    }

    var socialAuthButtonsView: some View {
        HStack(spacing: 10) {
            SocialButton(name: "Instagram") { print("Google ile giriş yap") }
            SocialButton(name: "Linkedin") { print("Apple ile giriş yap") }
            SocialButton(name: "Logo") { print("Apple ile giriş yap") }
        }
        .frame(width: 350, height: 70)
        .background(Color("LightColor"))
        .cornerRadius(20)
        .padding(.top)
    }

    func SocialButton(name: String, action: @escaping () -> Void) -> some View {
        Button{
            switch name{
                case "Instagram":
                UIApplication.shared.open(URL(string: "https://www.instagram.com/ktunailab/")!)
                case "Linkedin":
                UIApplication.shared.open(URL(string: "https://www.linkedin.com/company/ktun-ai-lab/")!)
                case "Logo":
                UIApplication.shared.open(URL(string: "https://ktunailab.com/")!)
                default:
                    print("Social Button Error: \(name) is not a valid social provide")
            }
        }label: {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 37, height: 37)
                .frame(width: 105, height: 55)
                .background(Color("DarkBlue"))
                .cornerRadius(15)
        }
    }
}

#Preview {
    AuthView()
}
