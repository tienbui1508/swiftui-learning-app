//
//  ContentView.swift
//  LearningApp
//
//  Created by Tien Bui on 11/4/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                ScrollView {
                    LazyVStack  {
                        ForEach(model.modules) { module in
                            VStack (spacing: 20) {
                                NavigationLink (
                                    destination:
                                        ContentView()
                                        .onAppear {
                                            model.beginModule(module.id)
                                        },
                                    tag: module.id,
                                    selection: $model.currentContentSelected,
                                    label: {
                                        // Learning Card
                                        HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                    })
                                
                                NavigationLink (
                                    destination:
                                        TestView()
                                        .onAppear {
                                            model.beginTest(module.id)
                                            
                                        },
                                    tag: module.id,
                                    selection: $model.currentTestSelected,
                                    label: {
                                        
                                        // Test Card
                                        HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                                    })
                                
                                NavigationLink  {
                                    EmptyView()
                                } label: {
                                    EmptyView()
                                }

                            }
                            
                        }
                    }
                    .padding()
                    .accentColor(.black)
                }
            }
            .navigationTitle("Get Started")
            .onChange(of: model.currentContentSelected) { changedValue in
                if changedValue == nil {
                    model.currentModule = nil
                }
            }
            .onChange(of: model.currentTestSelected) { changedValue in
                if changedValue == nil {
                    model.currentModule = nil
                }
            }
            
            
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
