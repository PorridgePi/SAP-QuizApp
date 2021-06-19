//
//  ContentView.swift
//  QuizApp
//
//  Created by Porridge on 5/6/21.
//

import SwiftUI

struct ContentView: View {
    
    var questions = [Question(title: "What day is it?",
                              options: [
                                "Monday",
                                "Friday",
                                "Wednesday",
                                "Saturday"
                              ],
                              correctOption: 4),
                     Question(title: "What framework are we using?",
                              options: [
                                "UIKit",
                                "React Native",
                                "SwiftUI",
                                "Flutter"
                              ],
                              correctOption: 3),
                     Question(title: "Which company created Swift?",
                              options: [
                                "Apple",
                                "Google",
                                "Pear",
                                "Tinkercademy"
                              ],
                              correctOption: 1),
                     Question(title: "When is the end of the world?",
                              options: [
                                "Tomorrow",
                                "I don't care",
                                "The world is immortal",
                                "You wouldn't live to see it",
                              ],
                              correctOption: 4),
                     Question(title: "Never?",
                              options: [
                                "Gonna",
                                "Give",
                                "You",
                                "Up"
                              ],
                              correctOption: 2),
                     Question(title: "What is the best version of Never Gonna Give You Up?",
                              options: [
                                "The Original",
                                "Silence",
                                "Earrape",
                                "Remixed"
                              ],
                              correctOption: 3),
                     Question(title: "How much money do you have on you?",
                              options: [
                                "I'm broke",
                                "Why you asking me?",
                                "Ya need cash bro?",
                                "$10"
                              ],
                              correctOption: 1)]
    
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
    @State var showButtons = false
    @State var quizStarted = false
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 1.00, green: 0.81, blue: 0.31, alpha: 1.00)) // #fecf50
                .ignoresSafeArea()
            
            if quizStarted {
                VStack {
                    if showTitle {
                        Text("You have 3 seconds to read the question!")
                            .font(.system(size: 36))
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        Text("Answer the question!")
                            .font(.system(size: 36))
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    if showTitle {
                        Text(questions[currentQuestion].title)
                            .font(.system(size: 24))
                            .multilineTextAlignment(.center)
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
                                        showButtons = true
                                    }
                                }
                            }
                            .onDisappear {
                                questionSize = 0.1
                                questionRotation = .zero
                                questionOpacity = 0
                            }
                    }
                    
                    VStack {
                        HStack {
                            if showButtons {
                                optionButton(option: questions[currentQuestion].options[0], optionNumber: 1)
                                optionButton(option: questions[currentQuestion].options[1], optionNumber: 2)
                            }
                        }
                        
                        HStack {
                            if showButtons {
                                optionButton(option: questions[currentQuestion].options[2], optionNumber: 3)
                                optionButton(option: questions[currentQuestion].options[3], optionNumber: 4)
                            }
                        }
                    }
                    .padding()
                    ProgressView(value: Double(currentQuestion), total: Double(questions.count))
                    .padding()
                }
                .frame(width: 400)
                .alert(isPresented: $isAlertPresented) {
                    Alert(title: Text(isCorrect ? "Correct" : "Wrong"),
                          message: Text(isCorrect ? "Congrats, you are kinda smart." : "This is outrageous, with such easy questions, how can you be getting this wrong?!"),
                          dismissButton: .default(Text("OK")) {
                            showTitle = true
                            showButtons = false
                            currentQuestion += 1
                            
                            if currentQuestion == questions.count {
                                isModalPresented = true
                                currentQuestion = 0
                            }
                          })
                }
                .sheet(isPresented: $isModalPresented,
                       onDismiss: {
                        correctAnswers = 0
                        quizStarted = false
                       },
                       content: {
                        ScoreView(score: correctAnswers, totalQuestions: questions.count)
                       })
            } else {
                VStack {
                    Text("A Random Quiz")
                        .font(.system(size: 36))
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            quizStarted = true
                        }
                    }) {
                        Text("Start Quiz")
                            .multilineTextAlignment(.center)
                            .frame(width: 125, height: 40)
                            .padding()
                            .background(Color(UIColor(red: 1.00, green: 0.61, blue: 0.13, alpha: 1.00))) // #ff9b21
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
        }
    }
    
    func didTapOption(optionNumber: Int) {
        if optionNumber == questions[currentQuestion].correctOption {
            print("Correct")
            isCorrect = true
            correctAnswers += 1
        } else {
            print("Wrong")
            isCorrect = false
        }
        isAlertPresented = true
    }
    // questions[currentQuestion].option4
    fileprivate func optionButton(option: String, optionNumber: Int) -> some View {
        return Button(
                    action: {
                        didTapOption(optionNumber: optionNumber)
                    }
                )
                {
                if optionNumber==1{
                    Image(systemName: "square.fill")
                        .padding(.leading)
                        .foregroundColor(.white)
                }else if optionNumber==2{
                    Image(systemName: "triangle.fill")
                        .padding(.leading)
                        .foregroundColor(.white)
                }else if optionNumber==3{
                    Image(systemName: "circle.fill")
                        .padding(.leading)
                        .foregroundColor(.white)
                }else if optionNumber==4{
                    Image(systemName: "diamond.fill")
                        .padding(.leading)
                        .foregroundColor(.white)
                }
                Text(option)
                    .lineLimit(2)
                    .minimumScaleFactor(0.4)
                    .multilineTextAlignment(.center)
                    .frame(width: 125, height: 40)
                    .foregroundColor(Color.white)
                }
                    .padding(.all)
                    .background(Color(UIColor(red: 1.00, green: 0.61, blue: 0.13, alpha: 1.00))) // #ff9b21
                    .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
