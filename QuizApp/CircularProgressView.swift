//
//  CircularProgressView.swift
//  QuizApp
//
//  Created by rgs on 19/6/21.
//
import SwiftUI

struct CircularProgressView: View {
    var progress: CGFloat
    
    var body: some View {
        ZStack {
            if progress < 0.3 {
                Circle() // Background
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor(red: 0.42, green: 0.09, blue: 0.04, alpha: 1.00))) // #6a180a
                
                Circle() // Progress
                    .trim(from: 0, to: progress)
                    .stroke(style:
                                .init(
                                    lineWidth: 20.0,
                                    lineCap: .round,
                                    lineJoin: .round
                                ))
                    .foregroundColor(Color(UIColor(red: 0.42, green: 0.09, blue: 0.04, alpha: 1.00))) // #6a180a
                    .rotationEffect(Angle(degrees: 270))
            } else if progress < 0.7 {
                Circle() // Background
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor(red: 0.93, green: 0.41, blue: 0.01, alpha: 1.00))) // #ee6802
                
                Circle() // Progress
                    .trim(from: 0, to: progress)
                    .stroke(style:
                                .init(
                                    lineWidth: 20.0,
                                    lineCap: .round,
                                    lineJoin: .round
                                ))
                    .foregroundColor(Color(UIColor(red: 0.93, green: 0.41, blue: 0.01, alpha: 1.00))) // #ee6802
                    .rotationEffect(Angle(degrees: 270))
            } else {
                Circle() // Background
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor(red: 0.00, green: 0.48, blue: 0.47, alpha: 1.00)))
                
                Circle() // Progress
                    .trim(from: 0, to: progress)
                    .stroke(style:
                                .init(
                                    lineWidth: 20.0,
                                    lineCap: .round,
                                    lineJoin: .round
                                ))
                    .foregroundColor(Color(UIColor(red: 0.00, green: 0.48, blue: 0.47, alpha: 1.00)))
                    .rotationEffect(Angle(degrees: 270))
            }
        }
        .padding()
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0.25)
    }
}
