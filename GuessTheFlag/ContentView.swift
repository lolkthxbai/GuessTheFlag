//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Junior Garcia on 10/17/26.
//

import SwiftUI

struct ContentView: View {
	static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
	
	@State private var countries = allCountries.shuffled()
	@State private var showingResults = false
	@State private var showingScore = false
	@State private var correctAnswer = Int.random(in: 0...2)
	@State private var alertMessage = ""
	@State private var scoreTitle = ""
	@State private var score = 0
	@State private var questionCounter = 1

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
				Text("Score: \(score)")
					.foregroundStyle(.white)
					.font(.title.bold())
				
				Spacer()
			}
			.padding()
		}
		.alert(scoreTitle, isPresented: $showingScore) {
			Button("Continue", action: askQuestion)
		} message: {
			Text(alertMessage)
		}
		.alert("Game over!", isPresented: $showingResults) {
			Button("New Game", action: newGame)
		} message: {
			Text(alertMessage)
		}
	}
	
	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			scoreTitle = "Correct!"
			score += 1
			alertMessage = "Your score is now \(score)"
		} else {
			scoreTitle = "Incorrect"
			let needsThe = ["UK", "US"]
			let playerAnswer = countries[number]

			if needsThe.contains(playerAnswer) {
				alertMessage = "That's the flag of the \(playerAnswer)"
			} else {
				alertMessage = "That's the flag of \(playerAnswer)"
			}
			
			if score > 0 {
				score -= 1
			}
		}
		if questionCounter == 8 {
			showingResults = true
		} else {
			showingScore = true
		}
	}
	
	func askQuestion() {
		countries.remove(at: correctAnswer)
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
		questionCounter += 1
	}
	
	func newGame() {
		questionCounter = 0
		score = 0
		countries = Self.allCountries
		askQuestion()
	}
}

#Preview {
	ContentView()
}
