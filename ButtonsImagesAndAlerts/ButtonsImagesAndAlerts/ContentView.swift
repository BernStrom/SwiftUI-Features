//
//  ContentView.swift
//  ButtonsImagesAndAlerts
//
//  Created by Bern N on 2/23/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Add selection", action: addSelection)
                .buttonStyle(.bordered)
                .tint(.mint)
            
            Button("Delete selection", role: .destructive, action: executeDelete)
                .buttonStyle(.borderedProminent)
            
            Button {
                print("Button was tapped")
            } label: {
                Text("Tap me!")
                    .padding()
                    .foregroundColor(.black)
                    .background(.yellow)
            }
            
            Button {
                print("Delete folder button was tapped")
            } label: {
                Image(systemName: "folder.fill.badge.minus")
                    .renderingMode(.original)
            }
            
            Button {
                editSelection()
            } label: {
                Label("Edit", systemImage: "pencil")
                    .tint(.indigo)
            }
            
            Button("Show alert") {
                showingAlert = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .alert("Important Message", isPresented: $showingAlert) {
                Button("Accept", role: .cancel) { }
                Button("Cancel", role: .destructive) { }
            } message: {
                Text("Please accept our terms & conditions.")
            }
        }
    }
    
    func addSelection() {
        print("Adding selection...")
    }
    
    func editSelection() {
        print("Editing selection...")
    }
    
    func executeDelete() {
        print("Deleting selection...")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
