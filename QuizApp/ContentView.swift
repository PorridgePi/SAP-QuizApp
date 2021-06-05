//
//  ContentView.swift
//  QuizApp
//
//  Created by Porridge on 5/6/21.
//

import SwiftUI

struct ContentView: View {

    var questions = [Question(title: "What day is it?",
                              option1: "Monday",
                              option2: "Saturday",
                              option3: "Wednesday",
                              option4: "Friday"),
                     Question(title: "What framework are we using?",
                              option1: "UIKit",
                              option2: "SwiftUI",
                              option3: "React Native",
                              option4: "Flutter"),
                     Question(title: "Which company created Swift?",
                              option1: "Google",
                              option2: "Apple",
                              option3: "Pear",
                              option4: "Tinkercademy"),
                     Question(title: "When is the end of the world?",
                              option1: "Tomorrow",
                              option2: "You wouldn't live to see it",
                              option3: "I don't care",
                              option4: "The world is immortal"),
                     Question(title: "Never?",
                              option1: "Gonna",
                              option2: "Give",
                              option3: "You",
                              option4: "Up"),
                     Question(title: "What is the best version of Never Gonna Give You Up?",
                              option1: "The Original",
                              option2: "Earrape",
                              option3: "Silence",
                              option4: "Remixed"),
                     Question(title: "How much money do you have on you?",
                              option1: "Why you asking me?",
                              option2: "I'm broke",
                              option3: "Ya need cash bro?",
                              option4: "$10")]

    @State var currentQuestion = 0

    @State var isAlertPresented = false
    @State var isCorrect = false

    @State var correctAnswers = 0
    @State var isModalPresented = false

    // State variables for Animations
    @State var questionSize: CGFloat = 0.1
    @State var questionRotation: Angle = .zero
    @State var questionOpacity: Double = 0
    @State var tapToContinueOffset: CGFloat = 50
    @State var showTitle = true

    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()

            VStack {
                Text("You have 3 seconds to answer this question!")
                    .font(.system(size: 40))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding()

                if showTitle {
                    Text(questions[currentQuestion].title)
                        .font(.system(size: 24))
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .foregroundColor(.blue)
                        .padding()
                        .scaleEffect(questionSize)
                        .rotationEffect(questionRotation)
                        .opacity(questionOpacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                questionSize = 1
                                questionRotation = Angle(degrees: 360 * 2)
                                questionOpacity = 1
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    showTitle = false
                                }
                            }
                        }
                        .onDisappear {
                            questionSize = 0.1
                            questionRotation = .zero
                            questionOpacity = 0
                        }
                }

                HStack {
                    VStack {
                        Button(questions[currentQuestion].option1) {
                            didTapOption(optionNumber: 1)
                        }
                        .multilineTextAlignment(.center)
                        .frame(width: 150)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding()

                        Button(questions[currentQuestion].option2) {
                            didTapOption(optionNumber: 2)
                        }
                        .multilineTextAlignment(.center)
                        .frame(width: 150)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding()
                    }

                    VStack {
                        Button(questions[currentQuestion].option3) {
                            didTapOption(optionNumber: 3)
                        }
                        .multilineTextAlignment(.center)
                        .frame(width: 150)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding()

                        Button(questions[currentQuestion].option4) {
                            didTapOption(optionNumber: 4)
                        }
                        .multilineTextAlignment(.center)
                        .frame(width: 150)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding()
                    }
                }
                .padding()
            }
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text(isCorrect ? "Correct" : "Wrong"),
                      message: Text(isCorrect ? "Congrats, you are kinda smart." : "This is outrageous, with such easy questions, how can you be getting this wrong?!"),
                      dismissButton: .default(Text("OK")) {
                        currentQuestion += 1
                        showTitle = true

                        if currentQuestion == questions.count {
                            isModalPresented = true
                            currentQuestion = 0
                        }
                      })
            }
            .sheet(isPresented: $isModalPresented,
                   onDismiss: {
                    correctAnswers = 0
                   },
                   content: {
                    ScoreView(score: correctAnswers, totalQuestions: questions.count)
                   })
        }
    }

    func didTapOption(optionNumber: Int) {
        if optionNumber == 2 {
            print("Correct")
            isCorrect = true
            correctAnswers += 1
        } else {
            print("Wrong")
            isCorrect = false
        }
        isAlertPresented = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
