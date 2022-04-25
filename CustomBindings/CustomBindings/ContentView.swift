//
//  ContentView.swift
//  CustomBindings
//
//  Created by Bern N on 4/25/22.
//

import SwiftUI

struct ContentView: View {
    @State var agreedToTerms = false
    @State var agreedToPrivacyPolicy = false
    @State var agreedToEmails = false
    
    var body: some View {
       let agreedToAll = Binding<Bool>(
            get: {
                agreedToTerms && agreedToPrivacyPolicy && agreedToEmails
            },
            set: {
                agreedToTerms = $0
                agreedToPrivacyPolicy = $0
                agreedToEmails = $0
            }
        ) // An example of a custom binding that get & set all the policies value at once.
        
        return NavigationView {
            ZStack {
                Color.brown
                
                VStack(spacing: 10) {
                    Toggle("Agree to Terms", isOn: $agreedToTerms)
                    Toggle("Agree to Privacy Policy", isOn: $agreedToPrivacyPolicy)
                    Toggle("Agree to Receive Shipping Emails", isOn: $agreedToEmails)
                    Toggle("Agree to All", isOn: agreedToAll)
                    // No dollar sign required for the two-way binding for agreedToAll because it already is one.
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
