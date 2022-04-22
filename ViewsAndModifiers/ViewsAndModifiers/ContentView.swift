//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Bern N on 4/22/22.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
} // An example above of creating a custom Title modifier that conforms to the ViewModifier protocol. This has only one requirement, which is a method called body that accepts whatever content it’s being given to work with, and must return some View.

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
} // A custom Watermark view modifier that embeds the view in a stack and adds another Text view.

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
} // An example above of breaking down complex views into smaller views by creating a custom view. This means splitting up one large view into multiple smaller views, and SwiftUI takes care of reassembling them for us without incurring much, if any, performance impact.

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
} // When working with custom modifiers, it’s usually a smart idea to create extensions on View that make them easier to use. For example, we might wrap the Title modifier in an extension.

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
} // An extension wrapper for the Watermark modifier.

struct ContentView: View {
    @State private var useRedText = false
    
    // An example of creating text views as properties.
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    
    // An example of creating text views as computed properties.
    // NOTE: Unlike the body property, Swift won’t automatically apply the @ViewBuilder attribute here.
    var motto3: some View {
        Text("Draco dormiens")
    }
    
    // An example of creating multiple views as computed properties, using a stack.
    var spells: some View {
        VStack {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    
    // An example of creating multiple views as computed properties, using a Group.
    var spells2: some View {
        Group {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    
    // An example of creating multiple views as computed properties, by adding the @ViewBuilder attribute yourself.
    // NOTE: @ViewBuilder mimics the way body works.
    @ViewBuilder var spells3: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.red)
        
        Text("Hello, world!")
            .padding()
            .background(.red)
            .padding()
            .background(.blue)
            .padding()
            .background(.green)
            .padding()
            .background(.yellow)
        
        Text("Hello, world!")
            .titleStyle()
    
        Button("Hello, world!") {
            print(type(of: self.body))
        }
        .frame(width: 150, height: 50)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
        Button("Toggle Me Colors!") {
            useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue) // An example of conditional modifiers.
        
        VStack {
            Text("Gryffindor")
                .font(.largeTitle)
            // font() is an environment modifier, which means the Gryffindor text view can override it with a custom font.
            
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title)
        
        VStack {
            Text("Gryffindor")
                .blur(radius: 10)
            // blur() is a regular modifier, so any blurs applied to child views are added to the VStack blur rather than replacing it.
            
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .blur(radius: 5)
        
        VStack {
            motto1
                .foregroundColor(.red)
            motto2
                .foregroundColor(.blue)
        }
        
        VStack(spacing: 10) {
            CapsuleText(text: "First")
                .foregroundColor(.white)
            CapsuleText(text: "Second")
                .foregroundColor(.yellow)
        } // An example of using the custom CapsuleText view with custom modifiers, as normal. Both stored modifiers and the ones on instances creation (such as the .foregroundColor() example above) will be applied.
        
        Color.blue
            .frame(width: 300, height: 200)
            .watermarked(with: "App Roastery")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// NOTES:
// What some View lets us do is say “this will a view, such as Button or Text, but I don’t want to say what.” So, the hole that View has will be filled by a real view object, but we aren’t required to write out the exact long type.

// struct ContentView: View {
//    var body: Text {
//        Text("Hello World")
//    }
//  }

// The above example says the body is returning a Text View, which works fine because Swift knows what exactly View that is. However, it is hideously painful to figure out exactly waht every single View is and the simple truth is that we don’t care because it’s all internal SwiftUI stuff.

// Creating a VStack with two text views inside silently creates a TupleView to contain those two views – a special type of view that holds exactly two views inside it.

// A TupleView that tracks ten different kinds of content: TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)>
// Above example also shows why SwiftUI doesn’t allow more than 10 views inside a parent.

// If we send back two views directly from our body property without wrapping them in a stack, Swift silently applies a special attribute to the body property called @ViewBuilder. This has the effect of silently wrapping multiple views in one of those TupleView containers, so that even though it looks like we’re sending back multiple views they get combined into one TupleView.
