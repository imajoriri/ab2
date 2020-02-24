//
//  MemoTag.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/24.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI

struct MemoTag: View {
    let text:String
    let systemName:String
    
    var body: some View {
        HStack {
            HStack {
            Image(systemName: systemName)
                .resizable()
                .frame(width: 11.0, height: 11.0)
            Text(text)
                .offset(x: -5)
                .font(.system(size: 11.0))
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8.0)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color.gray, lineWidth: 0.2)
        )
    }
}
