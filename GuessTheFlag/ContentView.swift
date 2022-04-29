//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lucas Chae on 4/29/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var userSelection = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var questionCount = 0
    @State private var visibleQuestionNumber = 0
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.8, green: 0.3, blue: 0.3), location: 0.3),
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 20) {
                    VStack {
                        Text("Question \(visibleQuestionNumber + 1) of 8")
                            .foregroundStyle(.secondary)
                            .font(.title3.weight(.bold))
                        Text(countries[correctAnswer])
                            .foregroundColor(.primary)
                            .font(.largeTitle.weight(.semibold))
                            
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                             flagTapped(number: number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth:.infinity)
                .padding(.vertical, 40)
                .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 30))
                Spacer()
                Spacer()
                Text("Score: \(currentScore)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if (questionCount < 8) {
                Button("Continue", action: askQuestion)
            }
            else {
                Button("Restart", action: restartGame)
            }
            
            
        } message: {
            if (scoreTitle == "Correct" && questionCount < 8) {
                Text("Your score is \(currentScore)")
            }
            else if (scoreTitle == "Wrong" && questionCount < 8) {
                Text("What you chose is \(countries[userSelection]).")
            }
            else if (scoreTitle == "Wrong" && questionCount == 8) {
                Text("What you chose is \(countries[userSelection]). \n Your final score is \(currentScore)")
            }
            else {
                Text("Your final score is \(currentScore)")

            }
        }
    }
    
    func flagTapped(number: Int) {
        userSelection = number
        questionCount += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        visibleQuestionNumber += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        questionCount = 0
        currentScore = 0
        visibleQuestionNumber = -1
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
