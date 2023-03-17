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
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            //after creating a function to load everything for the game, I need to call it here. SwiftUI gives a dedicated view modifier for running a closure when a view is shown.
            .onAppear(perform: startGame)
            
            }
        }
    
    func addNewWord () {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {return}
        
        withAnimation {
            usedWords.insert(answer, at:0)
        }
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
                return
            }
        }
        //if I am here *here* then there was a problem - trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
