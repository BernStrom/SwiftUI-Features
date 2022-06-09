//
//  ContentView.swift
//  Animations
//
//  Created by Bern N on 6/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var animationAmount2 = 0.0
    @State private var animationAmount3 = 0.0
    @State private var animationPulse = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            
            Button("Tap Me") {
                withAnimation {
                    animationAmount += 360
                }
            }
            .padding(50)
            .background(.cyan)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
            
            Spacer()
            
            Button("Tap Me") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    animationAmount2 += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationPulse)
                    .opacity(2 - animationPulse)
                    .animation(
                        .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: animationPulse)
            )
            .rotation3DEffect(.degrees(animationAmount2), axis: (x: 1, y: 0, z: 1))
            .onAppear {
                animationPulse += 2
            }
            
            Spacer()
            
            Button("Tap Me") {
                withAnimation {
                    animationAmount3 += 360
                }
            }
            .padding(50)
            .background(.mint)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmount3), axis: (x: 1, y: 0, z: 0))
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
