//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Junior Garcia on 10/17/26.
//

import SwiftUI

struct ContentView: View {
	@State private var showingScore = false
	@State private var scoreTitle = ""
	@State private var playerScore = 0
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	@State private var scoreMessage = ""
	@State private var showingGameOver = false
	@State private var playerTurn = 0

	var body: some View {
		ZStack {
			
			RadialGradient(stops: [
				.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
				.init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
			], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
			
			VStack {
				Spacer()
				Text("Guess the Flag")
					.font(.largeTitle.bold())
					.foregroundStyle(.white)
				
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
							playerTurn += 1
							flagTapped(number)
							
						} label: {
							Image(countries[number])
								.clipShape(.capsule)
								.shadow(radius: 5)
						}
						
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 20)
				.background(.regularMaterial)
				.clipShape(.rect(cornerRadius: 20))
				
				
				Spacer()
				Spacer()
				Text("Score: \(playerScore)")
					.foregroundStyle(.white)
					.font(.title.bold())
				
				Spacer()
			}
			.padding()
		}
		.alert(scoreTitle, isPresented: $showingScore) {
			Button("Continue", action: askQuestion)
		} message: {
			Text(scoreMessage)
		}
		.alert("Final Score", isPresented: $showingGameOver) {
			Button("New Game") {
				playerScore = 0
				playerTurn = 0
				askQuestion()
			}
		} message: {
			Text("Your final score is \(playerScore)!")
		}
	}
	
	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			scoreTitle = "Correct!"
			playerScore += 1
			scoreMessage = "Your score is \(playerScore)"
		} else {
			scoreTitle = "Wrong!"
			playerScore -= 1
			scoreMessage = "That’s the flag of \(countries[number])"
		}
		if playerTurn == 8 {
			showingGameOver = true
		} else {
			showingScore = true
		}
	}
	
	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
}

#Preview {
	ContentView()
}
