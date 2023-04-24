//
//  ContentView.swift
//  MTable
//
//  Created by Bukhari Sani on 19/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var correctAnswer = 0
    @State private var choiceArray = [0, 1, 2, 3]
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var difficulty = 55
    @State private var score = 0
    var body: some View {
        ZStack {
            RadialGradient(gradient:
                            Gradient(colors: [.blue, .black]),
                           center:  .center,  startRadius: 2,
                           endRadius: 900)
            .ignoresSafeArea()
                
            
            VStack {
                Image(systemName: "brain.head.profile")
                .font(.system(size: 65))
                
                Text("\(firstNumber) x \(secondNumber)")
                    .frame(width: 275, height: 100)
                    .font(.system(size: 40, weight: .bold))
                    .background(Color.blue)
                    .foregroundColor(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .padding()
                
                HStack {
                    ForEach(0..<2) { index in
                        Button {
                            answerIsCorrect(answer: choiceArray[index])
                            generateAnswers()
                        } label: {
                            answerButton(number: choiceArray[index])
                        }
                    }
                }
                
                HStack {
                    ForEach(2..<4) { index in
                        Button {
                            answerIsCorrect(answer: choiceArray[index])
                            generateAnswers()
                        } label: {
                            answerButton(number: choiceArray[index])
                        }
                    }
                }
                Text("Score: \(score)")
                    .font(.headline)
                    .bold()
            }.onAppear(perform: generateAnswers)
        }
    }
    //function to check if the answer picked is correct
    func answerIsCorrect(answer: Int) {
        let isCorrect = answer == correctAnswer ? true : false
        
        if isCorrect {
            self.score += 1
        } else {
            self.score -= 2
        }
    }
    
    func generateAnswers() {
        firstNumber = Int.random(in: 0...(difficulty/2))
        secondNumber = Int.random(in: 0...(difficulty/2))
        var answerList = [Int]()
        
        correctAnswer = firstNumber * secondNumber
        
        for _ in 0...2 {
            answerList.append(Int.random(in: 0...difficulty))
        }
        answerList.append(correctAnswer)
        choiceArray = answerList.shuffled()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
