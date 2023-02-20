
//
//  ContentView.swift
//  WeSplit
//
//  Created by Bukhari Sani on 18/02/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDark = false
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 5
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = 0..<101
    
    var theWholeBill:  Double { //To calculate the grand total of bill
        _ = Double(numberOfPeople + 2)
        let tipSelection =  Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    
    var totalPerPerson: Double { //Calculate the total per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        VStack{
            NavigationView {
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format:
                                .currency(code: Locale.current.currency?.identifier ??
                                          "USD")) // Passing the string as money.
                        .keyboardType(.decimalPad) //This modifier brings up the keyboard of numbers rather than the conventional keyboard.
                        .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }
                    Section {
                        
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        //Segment view for block views
                    }   header: {Text("How much tip do you want to leave?") //Made it look more like a promt with this trailing closure.
                    }
                    Section {
                        Text(totalPerPerson, format: .currency(code:
                                                                Locale.current.currency?.identifier ?? "USD"))
                    }   header: {Text("Amount each person is paying")}
                    
                    Section {
                        Text(theWholeBill, format: .currency(code:
                                                                Locale.current.currency?.identifier ?? "USD"))}
                header: {Text("Total amount")}
                    
                }
                .navigationTitle("WeSplit")
                .toolbar{
                    ToolbarItem(placement:ToolbarItemPlacement
                        .navigationBarTrailing){
                            Button(action:{isDark.toggle()},label:{
                                isDark ? Label("Dark",systemImage:
                                                "moon.fill") :
                                Label("Dark",systemImage:
                                        "moon") }
                            )}
                }
                .environment(\.colorScheme, isDark ? .dark : .light)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Done") {
                            amountIsFocused = false //To dismiss the button when the done button is pressed.
                        }
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

