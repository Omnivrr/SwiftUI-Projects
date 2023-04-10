//
//  ContentView.swift
//  Drawing
//
//  Created by Bukhari Sani on 10/04/2023.
//

import SwiftUI


// Custom shape that draws a spirograph
struct Spirograph: Shape {
    // Properties that determine the size and shape of the spirograph
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double
    
    // Helper function to calculate the greatest common divisor of two numbers
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
            
        }
        return a
    }
    
    // Required function that returns the path of the spirograph shape
    func path(in rect: CGRect) -> Path {
        // Calculate the greatest common divisor of the inner and outer radii
        let divisor = gcd(innerRadius, outerRadius)
        
        // Convert properties to Double for use in calculations
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        
        // Calculate the endpoint of the spirograph
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount
        
        // Create a new Path object to store the spirograph shape
        var path = Path()
        
        // Iterate over theta values to create the spirograph
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            // Calculate x and y coordinates for the current theta value
            var x = difference * cos(theta) + distance * cos(difference /  outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            // Offset x and y coordinates to center the spirograph in the view
            x += rect.width / 2
            y += rect.height / 2
            
            // Move to the starting point of the path on the first iteration, then add a line to the current point on subsequent iterations
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        // Return the completed spirograph path
        return path
    }
}

// Main view that displays the spirograph and allows the user to adjust its properties
struct ContentView: View {
    // State properties that control the size and shape of the spirograph
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount = 1.0
    @State private var hue = 0.6
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Display the spirograph with the current property values
            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                .frame(width: 300, height: 300)
            
            Spacer()
            
            Group {
                Text("Inner radius: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Outter radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Distance: \(Int(innerRadius))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])
                
                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
