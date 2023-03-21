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
    @State private var questionCounter = 1
    @State private var showScore = false
    @State private var range = 10
    @State private var numberOfQuestions = 15
    
    var body: some View {
        ZStack {
            RadialGradient(gradient:
                            Gradient(colors: [.blue, .black]),
                           center:  .center,  startRadius: 2,
                           endRadius: 900)
                .ignoresSafeArea()
            
            VStack {
                Stepper("Range: \(range)", value: $range, in: 1...20)
                    .padding()
                Stepper("Questions: \(numberOfQuestions)", value: $numberOfQuestions, in: 1...50)
                    .padding()
                // Display a stepper that allows the user to adjust the range of questions.
                
    
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 80))
                
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
            }
        }
        .alert(isPresented: $showScore) {
            if questionCounter == 10 {
                return Alert(title: Text("Game Over"), message: Text("Your final score is \(score)"), primaryButton: .default(Text("Restart"), action: {
                    restartGame()
                }), secondaryButton: .cancel())
            } else {
                return Alert(title: Text("Correct"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Next Question"), action: {
                    generateAnswers()
                }))
            }
        }
        .onAppear(perform: generateAnswers)
    }
    
    func answerIsCorrect(answer: Int) {
        let isCorrect = answer == correctAnswer ? true : false
        
        if isCorrect {
            self.score += 1
        } else {
            self.score -= 2
        }
        
        questionCounter += 1
        
        if questionCounter == 10 {
            showScore = true
        }
    }
    
    func restartGame() {
        firstNumber = Int.random(in: 0...(difficulty/2))
        secondNumber = Int.random(in: 0...(difficulty/2))
        correctAnswer = firstNumber * secondNumber
        questionCounter = 1
        score = 0
        
        generateAnswers()
    }
    func noQuestions() {
        
    }
    
    func generateAnswers() {
        // Use the selected range to generate new multiplication questions
        firstNumber = Int.random(in: 0...range)
        secondNumber = Int.random(in: 0...range)
        
        var answerList = [Int]()
        correctAnswer = firstNumber * secondNumber
        
        for _ in 0...2 {
            answerList.append(Int.random(in: 0...(range*2)))
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

