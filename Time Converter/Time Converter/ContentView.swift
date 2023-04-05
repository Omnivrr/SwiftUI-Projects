//
//  ContentView.swift
//  Time Converter
//
//  Created by Bukhari Sani on 05/03/2023.
//

import SwiftUI



struct ContentView: View {
    @State private var timeInput = 60.0
    let theTimeInput = ["Second", "Minute", "Hour", "Day"]
    @State private var selectedInput  = "Second"
    let theTimeOutput = ["Second", "Minute", "Hour", "Day"]
    @State private var selectedOutput = "Minute"
    @FocusState private var amountIsFocused: Bool
    
    func timeConverter() -> Double {
        var output: Double
        if selectedInput == "Second" && selectedOutput == "Minute" {
            output = (timeInput / 60.0)
            return output
        } else if selectedInput == "Second" && selectedOutput == "Hour" {
            output = (timeInput / 3600)
            return output
        } else if selectedInput == "Second" && selectedOutput == "Day" {
            output = (timeInput / 864000)
            return output
        } else if selectedInput == "Minute" && selectedOutput == "Second" {
            output = (timeInput * 60)
            return output
        } else if selectedInput == "Minute" && selectedOutput == "Hour" {
            output = (timeInput / 60)
            return output
        } else if selectedInput == "Minute" && selectedOutput == "Day" {
            output = (timeInput / 864000)
            return output
        } else if selectedInput == "Hour" && selectedOutput == "Second" {
            output = (timeInput * 3600)
            return output
        } else if selectedInput == "Hour" && selectedOutput == "Minute" {
            output = (timeInput * 60)
            return output
        } else if selectedInput == "Hour" && selectedOutput == "Day" {
            output = (timeInput / 24 )
            return output
            
        } else if selectedInput == "Day" && selectedOutput == "Hour" {
            output = (timeInput * 24)
            return output
        } else if selectedInput == "Day" && selectedOutput == "Minute" {
            output = (timeInput * 24 * 60)
            return output
        } else if selectedInput == "Day" && selectedOutput == "Second" {
            output = (timeInput * 24 * 60 * 60)
            return output
        } else {
            return timeInput
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select Time Unit", selection: $selectedInput) {
                        ForEach(theTimeInput, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }    header: {
                    Text("Select the time unit you want to convert")
                }
                
                Section {
                    TextField("Enter the time", value: $timeInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
            header: {
                Text("Time in \(selectedInput)")
            }
                
                Section {
                    Picker("Select time unit to convert to", selection: $selectedOutput){
                        ForEach(theTimeOutput, id: \.self) {
                            Text($0)
                        }
                    }
                }.pickerStyle(.segmented)
            header: do {
                Text("Result of your converted unit")
            }
                Section {
                    Text(timeConverter(), format: .number)
                header: do {
                    Text("Time in \(selectedOutput)s")
                }
                    
                }
                .navigationTitle("Time Converter")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done")  {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}


