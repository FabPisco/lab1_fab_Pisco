//
//  ContentView.swift
//  Lab1_Fab_Pisco
//
//  Created by Fabricio Pisco on 2025-02-11.
//


import SwiftUI

struct ContentView: View {
    @State private var number: Int = Int.random(in: 1...100)
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var attempts = 0
    @State private var showAlert = false
    @State private var result: String? = nil
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .padding()
            
            Button("Prime") {
                checkAnswer(isPrime: true)
            }
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .padding()
            
            Button("Not Prime") {
                checkAnswer(isPrime: false)
            }
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .padding()
            
            if let result = result {
                Text(result)
                    .font(.title)
            }
            
            Text("Correct: \(correctAnswers) | Wrong: \(wrongAnswers)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .padding()
        }
        .onAppear {
            startTimer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Results"),
                  message: Text("Correct: \(correctAnswers)\nWrong: \(wrongAnswers)"),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    func checkAnswer(isPrime: Bool) {
        if isPrime == isPrimeNumber(number) {
            correctAnswers += 1
            result = "✅"
        } else {
            wrongAnswers += 1
            result = "❌"
        }
        nextNumber()
    }
    
    func nextNumber() {
        attempts += 1
        if attempts % 10 == 0 {
            showAlert = true
        }
        number = Int.random(in: 1...100)
        startTimer()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            wrongAnswers += 1
            nextNumber()
        }
    }
    
    func isPrimeNumber(_ n: Int) -> Bool {
        if n < 2 { return false }
        for i in 2..<n {
            if n % i == 0 { return false }
        }
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

