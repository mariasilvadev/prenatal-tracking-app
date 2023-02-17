//
//  ProfileView.swift
//  Capstone4
//
//  Created by Maria Silva on 2/1/23.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct CurrentLogIn {
    let id, email, password, name, twitter, site: String
    let selectedDueDate: Date
    var selectedDueDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: selectedDueDate)
    }
}

class ProfileViewModel: ObservableObject {
    @Published var errorMsg = ""
    @Published var currentLogIn: CurrentLogIn?
    
    func getUser() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                if let userId = Auth.auth().currentUser?.uid {
                    let db = Firestore.firestore()
                    db.collection("users").whereField("id", isEqualTo: userId).getDocuments {(querySnapshot, err) in
                        
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                let data = document.data()
                                let id = data["id"] as? String ?? ""
                                let email = data["email"] as? String ?? ""
                                let password = data["password"] as? String ?? ""
                                let name = data["name"] as? String ?? ""
                                
                                let twitter = data["twitter"] as? String ?? ""
                                let site = data["site"] as? String ?? ""
                                //                    let selectedDueDate = data["selectedDueDate"] as? Date ?? .now
                                let selectedDueDate = (data["selectedDueDate"] as? Timestamp)?.dateValue() ?? Date()
                                self.currentLogIn = CurrentLogIn(id: id, email: email, password: password, name: name, twitter: twitter, site: site, selectedDueDate: selectedDueDate)
                            }
                        }
                    }
                    
                }
                else {
                    self.errorMsg = "Could not find firebase uid"
                    return
                }
                
                
            } else {
                print("No user logged in")
            }
        }
    }
}

struct ProfileView: View {
    @State private var showContentView: Bool = false
    @State private var showWeeksView: Bool = false
    @ObservedObject var registrationService = RegistrationService()
    @ObservedObject private var mv = ProfileViewModel()

    
    var body: some View {
        ZStack {
            Color("dull-pink").ignoresSafeArea()
//            Image("background-2")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("gold"))
                                .frame(width: 66, height: 66, alignment: .center)
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("pink"))
                                .font(.system(size: 24, weight: .medium, design: .rounded))
                        }
                        .frame(width: 66, height: 66, alignment: .center)
                        VStack(alignment: .leading) {
                            Text("\(mv.currentLogIn?.name ?? "No name")")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                            Button {
                                showWeeksView.toggle()
                            } label: {
                                Text("View profile")
                                    .foregroundColor(Color("gold2"))
//                                    .foregroundColor(.white.opacity(0.7))
                                    .font(.footnote)
                            }
                        }
                        Spacer()
            
                        Button {
//                            showSettingsView.toggle()

                        }label: {TextfieldIcon(iconName: "gearshape.fill", editing: .constant(true), passedImage: .constant(nil))

                        }
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.1))
                    
                    HStack {
                        Text("Due date:")
                            .foregroundColor(.white)
                        Text("\(mv.currentLogIn?.selectedDueDateString ?? "No due date")")
                            .foregroundColor(.white)
                            .font(.headline.bold())
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.1))
                    
                    HStack(spacing: 16) {
                        Image("Twitter")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24, alignment: .center)
                        Image(systemName: "link")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                        Text("\(mv.currentLogIn?.site ?? "No site added")")
                            .foregroundColor(.white)
                            .font(.footnote)
                        
                    }
                    
                }
                .padding(16)
            }
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.2))
                    .background(Color(.white).opacity(0.3))
//                    .background(Color("dull-pink").opacity(0.5))
//                    .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding(.horizontal)
            VStack {
                Spacer()
                Button(action: {
                    signout()
                }, label: {
                    Image(systemName: "arrow.turn.up.forward.iphone.fill")
                        .foregroundColor(Color("gold2"))
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 0.0, z: 1.0))
                        .background(
                            Circle()
                                .stroke(Color("gold2"), lineWidth: 1)
//                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                .frame(width: 42, height: 42, alignment: .center))
                })
            }
            .padding(.bottom, 64)
        }
        .colorScheme(.dark)
        .fullScreenCover(isPresented: $showWeeksView) {
            WeeksView()
        }
        .fullScreenCover(isPresented: $showContentView) {
                ContentView()
        }
        
    }
    func signout() {
        do {
            try Auth.auth().signOut()
            showContentView.toggle()
            print("User signed out")
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    init() {
        mv.getUser()
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
