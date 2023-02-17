//
//  ContentView.swift
//  Capstone4
//
//  Created by Maria Silva on 2/1/23.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextfield: Bool = false
    @State private var editingPasswordTextfield: Bool = false
    @State private var passwordIconBounce: Bool = false
    @State private var showProfileView: Bool = false
    @State private var showSettingsView: Bool = false
    @State private var userIsLoggedIn = false
    @ObservedObject var registrationService = RegistrationService()
    
    var body: some View {
        ZStack {
            Color("pink3").ignoresSafeArea()
            VStack{
                Text("Prenatal Tracking")
                    .font(Font.largeTitle.bold())
//                    .padding(.bottom, 60)
                    .foregroundColor(Color("pink4"))
                Text("App")
                    .font(Font.largeTitle.bold())
                    .padding(.bottom, 50)
                    .foregroundColor(Color("pink4"))
                VStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Sign in")
                            .font(Font.largeTitle.bold())
                            .foregroundColor(.white)
                        Text("Keep track of all your prenatal visits.")
                            .font(.subheadline)
                            .foregroundColor(Color.white.opacity(2))
                        
                        HStack(spacing: 12.0) {
                            TextfieldIcon(iconName: "envelope.open.fill", editing: $editingEmailTextfield, passedImage: .constant(nil))
                            TextField("email", text: $email) { isEditing in
                                editingEmailTextfield = isEditing
                                editingPasswordTextfield = false
                            }
                            .colorScheme(.dark)
    //                        .foregroundColor(Color("tan"))
                            .foregroundColor(Color.black.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.emailAddress)
                        }
                        .frame(height: 52)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 1.0)
                                .blendMode(.overlay)
                        )
                        .background(
                            Color("dull-teal")
                                .cornerRadius(16.0)
                                .opacity(0.2)
                        )
                        
                        HStack(spacing: 12.0) {
                            TextfieldIcon(iconName: "key.fill", editing: $editingPasswordTextfield, passedImage: .constant(nil))
                            SecureField("Password", text: $password)
                                .colorScheme(.dark)
                                .foregroundColor(Color.black.opacity(0.7))
                                .autocapitalization(.none)
                                .textContentType(.password)
                        }
                        .frame(height: 52)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 1.0)
                                .blendMode(.overlay)
                        )
                        .background(
                            Color("dull-teal")
                                .cornerRadius(16.0)
                                .opacity(0.2)
                        )
                        .onTapGesture {
                            editingEmailTextfield = false
                            editingPasswordTextfield = true
                        }
                        GradientButton(buttonTitle: "Sign in") {
                            SignIn()
                            showProfileView.toggle()
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.white.opacity((0.5)))
                        VStack(alignment: .leading, spacing: 16) {
                                HStack(spacing: 4) {
                                    Text("Don't have an account?")
                                        .font(.footnote)
                                        .foregroundColor(Color.white.opacity(1))
                                    Button {
                                        showSettingsView.toggle()
                                    } label: {
                                        GradientText(text: "Sign up")
                                            .font(Font.footnote.bold())
                                        
                                    }
                                    
                                    
                                }
                                Button {
                                    print("Send reset password email")
                                } label: {
                                    HStack(spacing: 4) {
                                        Text("Forgot password?")
                                            .font(.footnote)
                                            .foregroundColor(Color.white.opacity(1))
                
                                            GradientText(text: "Reset password")
                                                .font(Font.footnote.bold())
                                            
                                        
                                        
                                    }
                                }
                        }
                    
                    }
                    .padding(20)
                }
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.2))
                        .background(Color(.white).opacity(0.2))
                        .shadow(color: Color(.white).opacity(0.5), radius: 60, x: 0, y: 30)
                )
                .cornerRadius(30.0)
            .padding(.horizontal)
            }
            .padding(.bottom, 60)
        }
        .fullScreenCover(isPresented: $showProfileView) {
                ProfileView()
        }
        .fullScreenCover(isPresented: $showSettingsView) {
                SettingsView()
        }
    
    }
    func SignIn() {
            Auth.auth().signIn(withEmail: email, password: password) {
                result, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                print("User is signed in")
            }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self
            .overlay(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(self)
    }
}

struct GradientText: View {
    
    var text: String = "Text here"
    
    var body: some View {
        Text(text)
            .gradientForeground(colors: [Color("gold2"), Color("gold2")])
    }
}
