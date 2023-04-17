//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Tien Bui on 14/4/2023.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            // Only show video if we get a valid URL
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // TODO: Description
            CodeTextView()
            
            
            //Next lesson button if there is a next lesson
            
            if model.hasNextLesson() {
                Button {
                    // Advance the lesson
                    model.nextLesson()
                } label: {
                    
                    ZStack {
                        RectangleCard(color: .green)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                
            }
            else {
                // Show the complete button instead
                Button {
                    // Take the user back to the homeview
                    model.currentContentSelected = nil
                } label: {
                    
                    ZStack {
                        RectangleCard(color: .blue)
                        
                        Text("Complete")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                
            }
        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
   
        
        
        
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
