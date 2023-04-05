// This is a SwiftUI view that creates a circle with multiple strokes around it, each with a different color.

import SwiftUI
struct ColorCyclingCircle: View {
    // The amount determines the hue shift of the colors.
    var amount = 0.0
    // The number of steps determines how many strokes are around the circle.
    var steps = 100
    
    // The body of the view returns a ZStack with multiple circles, each with a different color.
    var body: some View {
        ZStack {
            // Use a loop to create multiple circles with different colors.
            ForEach(0..<steps) { value in
                // Create a circle with a certain inset and stroke color.
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }
    
    // This function calculates the color for each stroke based on a value and brightness.
    func color(for value: Int, brightness: Double) -> Color {
        // Calculate the target hue based on the value and amount properties.
        var targetHue = Double(value) / Double(steps) + amount
        
        // If the target hue is greater than 1, subtract 1 to keep the hue within the 0-1 range.
        if targetHue > 1 {
            targetHue -= 1
        }
            
        // Create and return a Color object with the calculated hue, 100% saturation, and the provided brightness.
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

// This is the main view of the app.
struct ContentView: View {
    // Use @State to create a binding to a value that can be modified and trigger a view update.
    @State private var colorCycle = 0.0
    
    // The body of the view returns a VStack with a ColorCyclingCircle view and a slider to adjust the hue shift.
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}

// This is a preview provider for the ContentView view.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
