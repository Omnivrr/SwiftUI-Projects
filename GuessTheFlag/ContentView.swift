//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Bukhari Sani on 09/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false // An alert to keep track of progress
    @State private var scoreTitle = "" //To store alert messages
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled() //to randomize the array
    @State private var correctAnswer = Int.random(in: 0...2) //There'll be 3 different flags at the same time, the correct one is either 0, 1 or 2
    @State private var totalScore = 0
    @State private var tappedFlag = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            //Flag was  tapped
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .cornerRadius(20 )
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                
                Text("Score: \(totalScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(totalScore)")
                    .foregroundColor(.white)
                
            }
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            totalScore += 2
        } else {
            scoreTitle = "Wrong! that's the flag of \(countries[number])"
            totalScore -= 2
        }
        
        showingScore = true //to show alert of either being right or wrong
        
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
