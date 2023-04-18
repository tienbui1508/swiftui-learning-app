//
//  TestView.swift
//  LearningApp
//
//  Created by Tien Bui on 18/4/2023.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack (alignment: .leading) {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                // Question
                CodeTextView()
                    .padding(.horizontal, 20)
                
                // Answers
                ScrollView {
                    VStack {
                        ForEach (0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            Button {
                             
                                // Track the selected index
                                selectedAnswerIndex = index
                            } label: {
                                ZStack {
                                    if submitted == false {
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white, height: 48)
                                    }
                                    else {
                                        // Answer submitted
                                        if index == selectedAnswerIndex &&
                                            index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .green)
                                        }
                                        else if index == selectedAnswerIndex &&
                                            index != model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .red)
                                        }
                                        else if index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .green)

                                        }
                                        else {
                                            RectangleCard(color: .white)
                                        }
                                    }
                                    Text(model.currentQuestion!.answers[index])
                                }
                                
                            }
                            .disabled(submitted)
                            
                            
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                
                // Button
                Button {
                    // Submitted
                    submitted = true
                    
                   // Check the answer and increment the counter if corrent
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        numCorrect += 1
                    }
                } label: {
                    ZStack {
                        RectangleCard(color: .green)
                        Text("Submit")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)


            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
