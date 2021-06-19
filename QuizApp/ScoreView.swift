//
//  ScoreView.swift
//  QuizApp
//
//  Created by Porridge on 5/6/21.
//

import SwiftUI

struct ScoreView: View {
    
    var score: Int
    var totalQuestions: Int
    @State var progressSize: CGFloat = 0.1
    @State var progressRotation: Angle = .zero
    @State var progressOpacity: Double = 0

    
    var body: some View {
        ZStack {
            Color(UIColor(red: 1.00, green: 0.81, blue: 0.31, alpha: 1.00)) // #fecf50
                .ignoresSafeArea()
            VStack {
                
                CircularProgressView(progress: CGFloat(score) / CGFloat(totalQuestions))
                    .frame(width: 150, height: 150)
                    .scaleEffect(progressSize)
                    .rotationEffect(progressRotation)
                    .opacity(progressOpacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.0)) {
                            progressSize = 1
                            progressRotation = Angle(degrees: 360 * 2)
                            progressOpacity = 1
                        }
                        
                    }
                if score > totalQuestions/2 {
                    Text("Congrats! You got")
                        .font(.system(size: 36))
                        .multilineTextAlignment(.center)
                } else {
                    Text("Oh no! You got")
                        .font(.system(size: 36))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Text("\(score)/\(totalQuestions)")
                    .font(.system(size: 48))
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: 2, totalQuestions: 3)
    }
}
