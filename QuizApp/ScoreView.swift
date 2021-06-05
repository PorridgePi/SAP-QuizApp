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
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 1.00, green: 0.81, blue: 0.31, alpha: 1.00)) // #fecf50
                .ignoresSafeArea()
            VStack {
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
