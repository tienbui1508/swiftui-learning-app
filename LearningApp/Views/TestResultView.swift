//
//  TestResultView.swift
//  LearningApp
//
//  Created by Tien Bui on 20/4/2023.
//

import SwiftUI

struct TestResultView: View {
    @EnvironmentObject var model: ContentModel
    var numCorrect: Int
    var resultHeading: String {
        guard model.currentModule != nil else {
            return ""
        }
        let pct = (Double)(numCorrect)/(Double)(model.currentModule!.test.questions.count)
        if pct > 0.5 {
            return "Awesome!"
        }
        else if pct > 0.2 {
            return "Doing great!"
        }
        else {
            return "Keep learning!"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(resultHeading)
                .font(.title)
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0)")
            
            Button {
                // Send user back to the homeview
                model.currentTestSelected = nil
            } label: {
                ZStack {
                    RectangleCard(color: .green)
                    Text("Compelete")
                }
                .foregroundColor(.white)
                .bold()
                .padding()
            }
            

        }
        
        
    }
}

