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
                    .foregroundColor(.red)
                
                Circle() // Progress
                    .trim(from: 0, to: progress)
                    .stroke(style:
                                .init(
                                    lineWidth: 20.0,
                                    lineCap: .round,
                                    lineJoin: .round
                                ))
                    .foregroundColor(.red)
                    .rotationEffect(Angle(degrees: 270))
            } else if progress < 0.7 {
                Circle() // Background
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.yellow)
                
                Circle() // Progress
                    .trim(from: 0, to: progress)
                    .stroke(style:
                                .init(
                                    lineWidth: 20.0,
                                    lineCap: .round,
                                    lineJoin: .round
                                ))
                    .foregroundColor(.yellow)
                    .rotationEffect(Angle(degrees: 270))
            } else {
                Circle() // Background
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.green)
                
                Circle() // Progress
                    .trim(from: 0, to: progress)
                    .stroke(style:
                                .init(
                                    lineWidth: 20.0,
                                    lineCap: .round,
                                    lineJoin: .round
                                ))
                    .foregroundColor(.green)
                    .rotationEffect(Angle(degrees: 270))
            }
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0.25)
    }
}
