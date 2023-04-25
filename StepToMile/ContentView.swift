//
//  ContentView.swift
//  StepToMile
//
//  Created by Bukhari Sani on 24/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = Activities()
    @State private var addingNewActivity
    
    var body: some View {
        NavigationView {
            List(data.activities) { activity in
                NavigationLink {
                    Text("Detail view")
                } label: {
                    HStack {
                        Text(activity.title)
                        Spacer()
                        Text(String(activity.completionCount))
                    }
                }
            }
            .navigationTitle("Step To Mile")
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
