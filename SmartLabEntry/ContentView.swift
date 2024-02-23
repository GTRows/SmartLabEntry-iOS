//
//  ContentView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 24.10.2023.
//

import SwiftUI


struct ContentView: View {
    @State private var isLogin = 0

    @State private var password: String = ""
    @State private var secondPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isSecondPasswordVisible: Bool = false

    var body: some View {
        VStack {
            Spacer()
            Divider()

            Text("ai lab")
                .font(.custom("Comfortaa", size: 100))
                .fontWeight(.bold)
                .foregroundColor(Color("LightColor"))
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)

//            Login and Register
            VStack {
//                Selection login and register
                HStack {
                    Button(action: {
                        print("Login")
                        isLogin = 0
                    }, label: {
                        Text("Giriş Yap")
                            .font(.custom("Comfortaa", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(isLogin == 0 ? Color("DarkBlue") : Color("LightColor"))
                            .padding(.horizontal, 25)
                            .padding(.vertical, 10)
                            .background(isLogin == 0 ? Color("LightColor") : Color.clear)
                            .cornerRadius(15)
                    })
                    Button(action: {
                        print("Register")
                        isLogin = 1
                    }, label: {
                        Text("Kayıt Ol")
                            .font(.custom("Comfortaa", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(isLogin == 0 ? Color("LightColor") : Color("DarkBlue"))
                            .padding(.horizontal, 25)
                            .padding(.vertical, 10)
                            .background(isLogin == 0 ? Color.clear : Color("LightColor"))
                            .cornerRadius(15)
                    })
                }
                .frame(width: 320, height: 60)
                .background(Color("Blue"))
                .cornerRadius(20)
                .padding(.vertical)

                if isLogin == 0 {
                    //                Login
                    VStack {
                        TextField("Okul Numarası", text: .constant(""))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 17.0)
                                .stroke(Color("DarkBlue"), lineWidth: 2))
                            .frame(width: 320, height: 50)
                            .padding(.bottom, 10)

                        HStack {
                            if isPasswordVisible {
                                TextField("Şifre", text: $password)
                            } else {
                                SecureField("Şifre", text: $password)
                            }

                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color("DarkBlue"))
                            }
                            .padding(.trailing, 5)
                        }
                        .padding()
                        .frame(width: 320, height: 50)
                        .background(RoundedRectangle(cornerRadius: 17.0)
                            .stroke(Color("DarkBlue"), lineWidth: 2))

                        HStack {
                            Spacer()
                            Button {
                                print("Şifremi Unuttum")
                            } label: {
                                Text("Şifremi Unuttum")
                                    .font(.custom("Comfortaa", size: 12))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.gray)
                            }
                            .padding(.top, 2)
                            .padding(.horizontal, 40)
                        }

                        Button(action: {
                            print("Giriş Yap")
                        }, label: {
                            Text("Giriş Yap")
                                .font(.custom("Comfortaa", size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(Color("LightColor"))
                                .frame(width: 320, height: 60)
                                .background(Color("DarkBlue"))
                                .cornerRadius(15)
                        })
                        .padding(.top)
                    }
                } else if isLogin == 1 {
//                Register 1
                    VStack {
                        TextField("Ad", text: .constant(""))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 17.0)
                                .stroke(Color("DarkBlue"), lineWidth: 2))
                            .frame(width: 320, height: 50)
                            .padding(.bottom, 10)

                        TextField("Soyad", text: .constant(""))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 17.0)
                                .stroke(Color("DarkBlue"), lineWidth: 2))
                            .frame(width: 320, height: 50)
                            .padding(.bottom, 10)

                        TextField("Okul Numarası", text: .constant(""))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 17.0)
                                .stroke(Color("DarkBlue"), lineWidth: 2))
                            .frame(width: 320, height: 50)
                            .padding(.bottom, 10)

                        Button(action: {
                            print("İleri")
                            isLogin = 2
                        }, label: {
                            Text("İleri")
                                .font(.custom("Comfortaa", size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(Color("LightColor"))
                                .frame(width: 320, height: 60)
                                .background(Color("DarkBlue"))
                                .cornerRadius(15)
                        }).padding(.top)
                    }
                } else if isLogin == 2 {
//                    Register 2
                    VStack {
                        TextField("Kişisel E-posta", text: .constant(""))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 17.0)
                                .stroke(Color("DarkBlue"), lineWidth: 2))
                            .frame(width: 320, height: 50)
                            .padding(.bottom, 10)

                        HStack {
                            if isPasswordVisible {
                                TextField("Şifre", text: $password)
                            } else {
                                SecureField("Şifre", text: $password)
                            }

                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color("DarkBlue"))
                            }
                            .padding(.trailing, 5)
                        }
                        .padding()
                        .frame(width: 320, height: 50)
                        .background(RoundedRectangle(cornerRadius: 17.0)
                            .stroke(Color("DarkBlue"), lineWidth: 2))
                        .padding(.bottom, 10)
                        
                        HStack {
                            if isSecondPasswordVisible {
                                TextField("Şifre Onay", text: $secondPassword)
                            } else {
                                SecureField("Şifre Onay", text: $secondPassword)
                            }

                            Button(action: {
                                isSecondPasswordVisible.toggle()
                            }) {
                                Image(systemName: isSecondPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color("DarkBlue"))
                            }
                            .padding(.trailing, 5)
                        }
                        .padding()
                        .frame(width: 320, height: 50)
                        .background(RoundedRectangle(cornerRadius: 17.0)
                            .stroke(Color("DarkBlue"), lineWidth: 2))
                        .padding(.bottom, 10)

                        Button(action: {
                            print("Kayıt olundu")
                            isLogin = 2
                        }, label: {
                            Text("Kayıt Ol")
                                .font(.custom("Comfortaa", size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(Color("LightColor"))
                                .frame(width: 320, height: 60)
                                .background(Color("DarkBlue"))
                                .cornerRadius(15)
                        })
                        .padding(.top)
                    }
                    
                } else{
                    Text("Hata")
                }
                Spacer()
            }
            .frame(width: 350, height: isLogin == 0 ? 350 : 400)
            .background(Color("LightColor"))
            .cornerRadius(20)

            HStack {
                Button(action: {
                    print("Google ile giriş yap")
                }, label: {
                    Image("Google")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                })
                .frame(width: 105, height: 55)
                .background(Color("DarkBlue"))
                .cornerRadius(15)

                Button(action: {
                    print("Apple ile giriş yapıldı")
                }, label: {
                    Image("Apple")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                })
                .frame(width: 105, height: 55)
                .background(Color("DarkBlue"))
                .cornerRadius(15)

                Button(action: {
                    print("ai lab ile giriş yapıldı")
                }, label: {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                })
                .frame(width: 105, height: 55)
                .background(Color("DarkBlue"))
                .cornerRadius(15)
            }
            .frame(width: 350, height: 70)
            .background(Color("LightColor"))
            .cornerRadius(20)
            .padding(.vertical)
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("DarkBlue")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    ContentView()
}
