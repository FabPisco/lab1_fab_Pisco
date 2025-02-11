//
//  ContentView.swift
//  Lab1_Fab_Pisco
// #100296834
//  Created by Fabricio Pisco on 2025-02-11.
// https://github.com/FabPisco/lab1_fab_Pisco


import SwiftUI // this is for impoting the Framework


// all the variables I keep for this project to track data
struct ContentView: View {
    @State private var number: Int = Int.random(in: 1...100)
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var attempts = 0
    @State private var showAlert = false
    @State private var result: String? = nil
    @State private var timer: Timer? = nil
    
    var body: some View{
        VStack {
            //style for the number
            Text("\(number)")
                .font(.custom("Snell Roundhand", size: 50)) // the script font with size
                .fontWeight(.bold)
                .foregroundColor(.green)// changed the text color to green
                .padding()
            
            // The user selecting the prime number
            Button("Prime") {
                checkAnswer(isPrime: true)
            }
            // styles for the button test
                .font(.custom("Snell Roundhand", size: 50))// the script font with size
                .fontWeight(.bold)
                .foregroundColor(.green)// changed the text color to green
                .padding()
            
            // This also is for user to select non prime number
            Button("Not Prime") {
                checkAnswer(isPrime: false)
            }
            //style for text of non prime number
                .font(.custom("Snell Roundhand", size: 50)) // the script font with size
                .fontWeight(.bold)
                .foregroundColor(.green) // changed the text color to green
                .padding()
            
            //to display the results of check right or error
            if let result = result {
                Text(result)
                    .font(.title)
            }
            
            // this part is showing me the correct or wrong count
            Text("Correct: \(correctAnswers) | Wrong: \(wrongAnswers)")
                .font(.custom("Snell Roundhand", size: 35)) // the script font with size
                .fontWeight(.bold)
                .foregroundColor(.green)// changed the text color to green
                .padding()
        }
        .onAppear {
            startTimer() //starts the time
        }
        .alert(isPresented: $showAlert) {
            
        //showing me final score of 10 times
            Alert(title: Text("Results"),
                  message: Text("Correct: \(correctAnswers)\nWrong: \(wrongAnswers)"),
                  dismissButton: .default(Text("OK")))
        }
    }
    // The functions to see if the user answers are right or wrong
    func checkAnswer(isPrime: Bool) {
        if isPrime == isPrimeNumber(number) {
            correctAnswers += 1
            result = "✅" // if right
        } else {
            wrongAnswers += 1
            result = "❌" //if wrong
        }
        nextNumber() // this part is generating the new number
    }
    
    // next random number, tracking attemps
    func nextNumber() {
        attempts += 1
        if attempts % 10 == 0 {
            showAlert = true // showing every 1o times
        }
        number = Int.random(in: 1...100) // random number
        startTimer() // timer restarts for next number
    }
    
    // starting at 5 second timer
    func startTimer() {
        timer?.invalidate() // stops existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            wrongAnswers += 1  // Auto records a wrong answer
            nextNumber()
        }
    }
    // checking if my number is prime
    func isPrimeNumber(_ n: Int) -> Bool {
        if n < 2 { return false } // tells it if numbers are < 2 than not prime
        for i in 2..<n {
            if n % i == 0 { return false } // not a prime if divisible by any number
        }
        return true // not divisible , it is a prime
    }
}
// for the SwiftUI preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

