//
//  LandmarkRow.swift
//  SwiftUIDemo
//
//  Created by jackfrow on 2021/5/13.
//

import SwiftUI

struct LandmarkRow: View {
    
    var landmark: Landmark

    
    var body: some View {
        HStack{
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            
            Text(landmark.name)
            
            Spacer()
            
            if landmark.isFavorite{
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            
            
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    
    static var landmarks = ModelData().landmarks
    
    static var previews: some View {
        Group {
                   LandmarkRow(landmark: landmarks[0])
                   LandmarkRow(landmark: landmarks[1])
               }
               .previewLayout(.fixed(width: 300, height: 70))
    }
}
