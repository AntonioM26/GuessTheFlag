//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by António Almeida on 06/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreValue = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var numberOfQuestions = 0
    @State private var isGameOver = false
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.25, blue: 0.7), location: 0.3),
                .init(color: Color(red:0.1, green: 0.65, blue: 0.3), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 30){
                    VStack(spacing: 10){
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.headline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 8)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Your Score: \(scoreValue)")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is: \(scoreValue)")
        }
        .alert("Game finished!", isPresented: $isGameOver){
            Button("Start over", action: resetGame)
        } message: {
            Text("Final score: \(scoreValue)")
        }
    }
    
    func flagTapped (_ number: Int){
        if (number == correctAnswer){
            scoreTitle = "Correct!"
            scoreValue += 1
        } else {
            scoreTitle = "Wrong! That is \(countries[number])."
        }
        showingScore = true
        
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        numberOfQuestions += 1
        if (numberOfQuestions == 8){
                isGameOver = true
            }
    }
    func resetGame(){
        numberOfQuestions = 0
        scoreValue = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
