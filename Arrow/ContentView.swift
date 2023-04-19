//
//  ContentView.swift
//  Arrow
//
//  Created by Bukhari Sani on 11/04/2023.

import SwiftUI

// Define a custom shape called "Arrow" that conforms to the Shape protocol
struct Arrow: Shape {
    
    // This method is required by the Shape protocol, and returns a Path object
    func path(in rect: CGRect) -> Path {
        
        // Create a new empty Path object
        return Path { path in
            
            // Move the starting point of the path to the center of the top edge of the rectangle
            path.move(to: CGPoint(x: rect.midX, y: 0))
            
            // Add a line from the current point to the center of the right edge of the rectangle
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            // Add a line from the current point to the point 50 units to the right of the center of the rectangle
            path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.midY))
            
            // Add a line from the current point to the bottom edge of the rectangle, 50 units to the right of the center
            path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.maxY))
            
            // Add a line from the current point to the bottom edge of the rectangle, 50 units to the left of the center
            path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.maxY))
            
            // Add a line from the current point to the point 50 units to the left of the center of the rectangle
            path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.midY))
            
            // Add a line from the current point back to the center of the top edge of the rectangle, completing the shape
            path.addLine(to: CGPoint(x: 0, y: rect.midY))
            
            // Close the subpath, completing the shape
            path.closeSubpath()
        }
    }
}

// Define a SwiftUI view called ContentView
struct ContentView: View {
    
    // The body property is required by the View protocol, and returns the view hierarchy
    var body: some View {
        
        // Display an instance of the Arrow shape with a purple fill
        Arrow()
            .fill(.purple)
    }
}

// Define a preview for the ContentView
struct ContentView_Previews: PreviewProvider {
    
    // The body property is required by the PreviewProvider protocol, and returns the view hierarchy
    static var previews: some View {
        
        // Display an instance of the ContentView
        ContentView()
    }
}
