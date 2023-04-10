//
//  ContentView.swift
//  MoreAnimation
//
//  Created by Bukhari Sani on 10/04/2023.

import SwiftUI

struct ContentView: View {
    // Declare a state variable to track the amount of the slider
    @State private var amount = 0.0
    
    var body: some View {
        // Define the UI of the view
        VStack {
            // A vertical stack to hold the ZStack and the Slider
            ZStack {
                // Three circles with different colors and blend modes, positioned with offsets
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))  // Red color
                    .frame(width: 200 * amount)  // Update the width of the circle based on the amount variable
                    .offset(x: -50, y: -80)  // Position the circle with an offset
                    .blendMode(.screen)  // Set the blend mode to screen
                
                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))  // Blue color
                    .frame(width: 200 * amount)  // Update the width of the circle based on the amount variable
                    .offset(x: 50, y: -80)  // Position the circle with an offset
                    .blendMode(.screen)  // Set the blend mode to screen
                
                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))  // Green color
                    .frame(width: 200 * amount)  // Update the width of the circle based on the amount variable
                    .blendMode(.screen)  // Set the blend mode to screen
            }
            .frame(width: 300, height: 300)  // Set the frame of the ZStack
            
            // A slider to adjust the amount variable
            Slider(value: $amount)
                .padding()  // Add some padding to the slider
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Set the frame of the VStack to fill the screen
        .background(.black)  // Set the background color to black
        .ignoresSafeArea()  // Ignore the safe area insets
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



/*This code defines a SwiftUI View called ContentView. It creates a colorful animation using three circles and a slider. The @State property wrapper is used to track the amount variable, which is bound to the Slider view using $amount.
 
 The main body of the ContentView is a VStack that contains a ZStack and a Slider.
 
 The ZStack contains three Circle views that are layered on top of each other to create the final animation. Each Circle has a different color (red, blue, and green) and is positioned using the offset modifier. The blendMode modifier is used to blend the colors of the circles together.
 
 The Slider allows the user to adjust the amount variable, which controls the size of the circles. When the slider is moved, the frame modifier on each Circle view updates to create the animation.
 
 Finally, the ContentView is wrapped in several modifiers to make it full-screen, set a black background, and ignore the safe area.
 
 The ContentView_Previews struct defines a preview for the ContentView.
 */
