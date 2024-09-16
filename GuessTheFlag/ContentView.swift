//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mobile on 9/11/24.
//

import SwiftUI

struct ContentView: View 
{
    @State private var round = 1
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var streak = 0
    @State private var highStreak = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View
    {
        ZStack
        {
            LinearGradient(stops: [
                .init(color: .mint, location: 0.05),
                .init(color: .green, location: 0.95),
            ], startPoint: .top, endPoint: .bottom)
            
            if round < 9
            {
                VStack(spacing: 15)
                {
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                    
                    VStack(spacing: 30)
                    {
                        VStack(spacing: 5)
                        {
                            Text("**Tap the flag of:**")
                            Text("**\(countries[correctAnswer])**")
                                .font(.largeTitle.weight(.semibold))
                        }
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(Color(red: 0.00, green: 0.60, blue: 0.85, opacity: 0.3))
                        .clipShape(.rect(cornerRadius: 10))
                        
                        ForEach(0..<3)
                        { number in
                            Button
                            {
                                flagPressed(number)
                            }
                            label:
                            {
                                Image(countries[number])
                                    .clipShape(.rect(cornerRadius: 15))
                                    .shadow(radius: 25)
                            }
                        }
                    }
                    .frame(maxWidth: 250)
                    .foregroundStyle(.secondary)
                    .padding(30)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    HStack(spacing: 50)
                    {
                        Text("Score: \(score)")
                            .foregroundStyle(.white)
                            .font(.title)
                        
                        Text("Round \(round)/8")
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                }
                .padding()
            }
            else
            {
                VStack(spacing: 40)
                {
                    VStack(spacing: 5)
                    {
                        Text("**Results**")
                            .font(.largeTitle.weight(.semibold))
                    }
                    .foregroundStyle(.white)
                    .padding(12)
                    .background(Color(red: 0.00, green: 0.60, blue: 0.85, opacity: 0.2))
                    .clipShape(.rect(cornerRadius: 10))
                    
                    VStack(spacing: 25)
                    {
                        VStack(alignment: .leading, spacing: 15)
                        {
                            Text("Score: \(score)")
                            Text("Highest Streak: \(highStreak)")
                        }
                        .foregroundStyle(.white)
                        .font(.title)
                        
                        VStack
                        {
                            if score == 8
                            {
                                Text("You're a flag genius!")
                            }
                            else if score > 5
                            {
                                Text("Great job!")
                            }
                            else if score > 2
                            {
                                Text("Great effort!")
                            }
                            else
                            {
                                Text("You'll do better next time:)")
                            }
                        }
                        .foregroundStyle(.white)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                    }
                    
                    Button
                    {
                        restart()
                    }
                    label:
                    {
                        Text("Play Again")
                            .foregroundStyle(.white)
                            .font(.title.weight(.heavy))
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.00, green: 0.70, blue: 0.70, opacity: 0.6))
                }
                .frame(maxWidth: 250)
                .foregroundStyle(.secondary)
                .padding(30)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
        }
        .ignoresSafeArea()
        .alert(scoreTitle, isPresented: $showingScore) 
        {
            Button("Continue", action: askQuestion)
        } 
        message:
        {
            if streak > 2
            {
                Text("Your score is \(score)\nYou have a streak of \(streak)!")
            }
            else
            {
                Text("Your score is \(score)")
            }
        }
    }
    
    func restart()
    {
        countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
        score = 0
        round = 1
        streak = 0
        highStreak = 0
        correctAnswer = Int.random(in: 0...2)
    }
    
    func checkStreak()
    {
        if streak > highStreak
        {
            highStreak = streak
        }
    }
    
    func flagPressed(_ number: Int)
    {
        if number == correctAnswer 
        {
            if round == 8
            {
                scoreTitle = "Congrats! You finished!"
            }
            else
            {
                scoreTitle = "Correct!"
            }
            streak += 1
            score += 1
            checkStreak()
        }
        else 
        {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            streak = 0
        }

        showingScore = true
    }
    
    func askQuestion() 
    {
        round += 1
        countries.remove(at: correctAnswer)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview 
{
    ContentView()
}
