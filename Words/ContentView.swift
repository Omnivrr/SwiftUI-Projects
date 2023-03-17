//
//  ContentView.swift
//  Words
//
//  Created by Bukhari Sani on 17/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var playerScore = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) {word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word) // this goes through the used words and displays them in the section
                        }
                    }
                }
                Section("Score") {
                    Text("\(playerScore)")
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord) //after a player types in a word and enters it, the word that is entered get added to the array.

            
            .onAppear(perform: startGame)  //after creating a function to load everything for the game, I need to call it here. SwiftUI gives a dedicated view modifier for running a closure when a view is shown.
            //this alert modifier will allow title, message and error to be passed directly to swiftui
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("New Game", action: startGame)
            
            }
        }
    }
    
    func addNewWord () {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just them up, you know!")
            return
        }
    
        guard answer.count >= 3 else {
            wordError(title: "Word is too short", message: "Enter a word that is t least 4 characters long!")
            return
            
        }
        
        withAnimation {
            usedWords.insert(answer, at:0)
        }
        scoreCalculation()
        newWord = ""
    }
    
    func startGame() {
        //find the url for start.txt in the app
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                //split the string up into an array of strings , splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                //pick a random word or use "silkworm as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                //arriving here means everything worked, so we I exit.
                usedWords = [String]()
                //this reset our used word array
                return
            }
        }
        //if I am here *here* then there was a problem - trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
        
    }
    
    //to accept a string as the only parameter
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
        //will return true if we've used the word already
        
    }
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        
    }
    //creating a method that sets title and message based on parameter received and then flips showing error to true
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
        
    }
    func scoreCalculation() {
        playerScore += (newWord.count + 1)
        //if a player enters a correct word, the plater earns a point + the points equal to the length of given word.
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
