//
//  SettingsView.swift
//  Capstone4
//
//  Created by Maria Silva on 2/7/23.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct SettingsView: View {
    @State private var selectedDueDate = Date()
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2023, month: 2, day: 9)
        let endComponents = DateComponents(year: 2024, month: 12, day: 31)
        return calendar.date(from:startComponents)!
        ...
        calendar.date(from:endComponents)!
    }()
    
    @State private var editingNameTextField: Bool = false
    @State private var editingTwitterTextField: Bool = false
    @State private var editingSiteTextField: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextfield: Bool = false
    @State private var editingPasswordTextfield: Bool = false
    
    @State private var name = ""
    @State private var twitter = ""
    @State private var site = ""
    
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    @ObservedObject private var registrationService = RegistrationService()
    @ObservedObject private var mv = ProfileViewModel()
    @State private var showProfileView: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Sign up")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.title)
                
                GradientTextfield(editingTextfield: $editingEmailTextfield, textfieldString: $email, textfieldPlaceholder: "Email", textfieldIconString: "envelope.open.fill")
                    .autocapitalization(.none)
                    .textContentType(.name)
                    .disableAutocorrection(true)
                
                GradientTextfield(editingTextfield: $editingPasswordTextfield, textfieldString: $password, textfieldPlaceholder: "Password", textfieldIconString: "key.fill")
                    .autocapitalization(.none)
                    .textContentType(.password)
                    .disableAutocorrection(true)
                
                GradientTextfield(editingTextfield: $editingNameTextField, textfieldString: $name, textfieldPlaceholder: "Name", textfieldIconString: "textformat.alt")
                    .autocapitalization(.words)
                    .textContentType(.name)
                    .disableAutocorrection(true)
                
                GradientTextfield(editingTextfield: $editingTwitterTextField, textfieldString: $twitter, textfieldPlaceholder: "Twitter Handle", textfieldIconString: "at")
                    .autocapitalization(.none)
                    .keyboardType(.twitter)
                    .disableAutocorrection(true)
                
                GradientTextfield(editingTextfield: $editingSiteTextField, textfieldString: $site, textfieldPlaceholder: "Website", textfieldIconString: "link")
                    .autocapitalization(.none)
                    .keyboardType(.webSearch)
                    .disableAutocorrection(true)
                
                DatePicker("Enter your due date", selection: $selectedDueDate, in: dateRange, displayedComponents: [.date])
                    .foregroundColor(.white)

                GradientButton(buttonTitle: "Create Account") {
                    SignUp()
                    showProfileView.toggle()
                }
                Spacer()
                .onAppear {
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if let currentUser = user {
                            registrationService.addUser(id: currentUser.uid, email: email, name: name, password: password, twitter: twitter, site: site, selectedDueDate: selectedDueDate)

                            } else {
                            print("Error saving user information")
                            }
                    }
                }
                
            }
            .padding()
            Spacer()
                .background(Color("settingsBackground")
                    .edgesIgnoringSafeArea(.all)
                )
        }
        .background(Color("settingsBackground")
            .edgesIgnoringSafeArea(.all)
        )
        .fullScreenCover(isPresented: $showProfileView) {
            ProfileView()
        }
    }
    func SignUp() {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                print("User signed up!")
            }
    }

    
}
struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
    }
}
