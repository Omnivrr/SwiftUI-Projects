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
    @State private var animation = 0.0
    
    var body: some View {
        ZStack {
            RadialGradient(gradient:
                            Gradient(colors: [.blue, .black]),
                           center:  .center,  startRadius: 2,
                           endRadius: 900)
                .ignoresSafeArea()
            
            VStack {
                // Display two stepper views to adjust game settings
                Stepper("Range: \(range)", value: $range, in: 1...20)
                    .padding()
                Stepper("Questions: \(numberOfQuestions)", value: $numberOfQuestions, in: 1...50)
                    .padding()
                // Display a stepper that allows the user to adjust the range of questions.
                
                // Display an image and a multiplication question
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
                    // Display two rows of answer buttons
                    ForEach(0..<2) { index in
                        Button {
                            answerIsCorrect(answer: choiceArray[index])
                            generateAnswers()
                        } label: {
                            answerButton(number: choiceArray[index])
                                .rotation3DEffect(.degrees(animation), axis: (x: 0, y: 1, z: 0))
                        }
                    }
                }
                
                HStack {
                    // Display two rows of answer buttons
                    ForEach(2..<4) { index in
                        Button {
                            answerIsCorrect(answer: choiceArray[index])
                            generateAnswers()
                            animation += 360
                            
                        } label: {
                            answerButton(number: choiceArray[index])
                                .rotation3DEffect(.degrees(animation), axis: (x: 0, y: 1, z: 0))
                        }
                    }
                }
                // Display the user's score
                Text("Score: \(score)")
                    .font(.headline)
                    .bold()
            }
        }
        // Define an alert to display the game's score when the game is over
        .alert(isPresented: $showScore) {
            if questionCounter == 10 {
                return Alert(title: Text("Game Over"), message: Text("Your final score is \(score)"), primaryButton: .default(Text("Restart"), action: {
                    restartGame()
                }), secondaryButton: .cancel())
            } else {
                // The Alert view that will be shown when the user selects the correct answer for the current question
                return Alert(title: Text("Correct"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Next Question"), action: {
                    // Generate new multiplication questions for the next question
                    generateAnswers()
                }))
            }
        }
        // Generate the multiplication questions when the view appears
        .onAppear(perform: generateAnswers)
    }
    // Check if the answer is correct and update the score accordingly
    func answerIsCorrect(answer: Int) {
        let isCorrect = answer == correctAnswer ? true : false
        
        // Increase the score by 1 if the answer is correct
        if isCorrect {
            self.score += 1
        } else {
            self.score -= 2
        }
        
        // Increase the question counter by 1 for each question
        questionCounter += 1
        
        if questionCounter == 10 {
            showScore = true
        }
    }
    
    // Restart the game with new multiplication questions and reset the score and question counter
    func restartGame() {
        firstNumber = Int.random(in: 0...(difficulty/2))
        secondNumber = Int.random(in: 0...(difficulty/2))
        correctAnswer = firstNumber * secondNumber
        questionCounter = 1
        score = 0
        // Generate new multiplication questions
        generateAnswers()
    }
    
    // Generate new multiplication questions and answer choices
    func generateAnswers() {
        // Use the selected range to generate new multiplication questions
        firstNumber = Int.random(in: 0...range)
        secondNumber = Int.random(in: 0...range)
        
        var answerList = [Int]()
        correctAnswer = firstNumber * secondNumber
        
        // Generate 3 random answer choices for the current question
        for _ in 0...2 {
            answerList.append(Int.random(in: 0...(range*2)))
        }
        // Add the correct answer to the list of answer choices
        answerList.append(correctAnswer)
        
        // Shuffle the answer choices
        choiceArray = answerList.shuffled()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
