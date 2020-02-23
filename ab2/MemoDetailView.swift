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
    
    var fact:String
    var abstract:String
    var product:String
    
    init(memo:Memo) {
        self.memo = memo
        self.fact = memo.fact != nil ? memo.fact!.description : ""
        self.abstract = memo.abstract != nil ? memo.abstract!.description : ""
        self.product = memo.product != nil ? memo.product!.description : ""
    }

    var body: some View {
        VStack {
            MemoContent(title: "fact", content: self.fact)
            MemoContent(title: "abstract", content: self.abstract)
            MemoContent(title: "product", content: self.product)
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
