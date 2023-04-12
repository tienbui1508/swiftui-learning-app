//
//  HomeViewRow.swift
//  LearningApp
//
//  Created by Tien Bui on 12/4/2023.
//

import SwiftUI

struct HomeViewRow: View {
    var image: String
    var title: String
    var description: String
    var count: String
    var time: String
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            HStack() {
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .bold()
                    Text(description)
                        .padding(.bottom, 20.0)
                        .font(Font.system(size: 10))
                    
                    
                    HStack {
                        Image(systemName: "text.book.closed")
                        Text(count)
                        Spacer()
                        Image(systemName: "clock")
                        Text(time)
                        
                    } .font(Font.system(size: 10))
                    
                }.padding()
            }
            .padding()
        }
        .padding()
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "some description", count: "10 Lessons", time: "2 hours")
            .environmentObject(ContentModel())
    }
}
