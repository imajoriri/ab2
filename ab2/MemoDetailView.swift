//
//  MemoDetailView.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/22.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI

struct MemoContent: View {
    let title:String
    let content:String
    @State var isEditView:Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(self.title)
                    .font(.title)
                    .foregroundColor(Color.gray)
                Spacer()
            }
            Text(self.content)
        }
        .padding()
    }
}

struct MemoDetailView: View {
    let memo:Memo
    @State var isEditView:Bool = false

    var body: some View {
        VStack {
            MemoContent(title: "fact", content: memo.fact!.description)
            MemoContent(title: "abstract", content: memo.abstract!.description)
            MemoContent(title: "product", content: memo.product!.description)
            Spacer()
        }
        .navigationBarItems(trailing: Button(action: {
            self.isEditView = true
        }){
            Text("edit")
        }
        .sheet(isPresented: $isEditView) {
            MemoEditView(memo: self.memo)
            }
        )
    }
}
