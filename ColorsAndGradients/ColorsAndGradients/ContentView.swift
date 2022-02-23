//
//  ContentView.swift
//  ColorsAndGradients
//
//  Created by Bern N on 2/23/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }

            Text("Your content")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()

        ZStack {
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .white, location: 0.45),
                .init(color: .black, location: 0.55),
            ]), startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()

        ZStack {
            RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)
        }
        .ignoresSafeArea()
                
        ZStack {
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
