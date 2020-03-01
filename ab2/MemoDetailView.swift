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
    let systemName:String
    @State var isEditView:Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: systemName)
                    .resizable()
                    .frame(width: 11.0, height: 11.0)
                    .foregroundColor(Color.gray)
                
                Text(self.title)
                    .offset(x: -5)
                    .font(.system(size: 16.0))
                    .foregroundColor(Color.gray)
                    
                Spacer()
            }
            
            Text(self.content)
            .font(.system(size: 18.0))
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
            MemoContent(title: MemoType.fact.rawValue, content: self.fact, systemName: MemoSystemNameType.fact.rawValue)
            Divider().padding(.horizontal, 16.0)
            
            MemoContent(title: MemoType.abstract.rawValue, content: self.abstract, systemName: MemoSystemNameType.abstract.rawValue)
                .padding(.top, -15.0)
            Divider().padding(.horizontal, 16.0)
            
            MemoContent(title: MemoType.product.rawValue, content: self.product, systemName: MemoSystemNameType.product.rawValue)
            .padding(.top, -15.0)
            Spacer()
        }
        .navigationBarItems(trailing: Button(action: {
            self.isEditView = true
        }){
            Text("編集").foregroundColor(ColorCode.main.color())
        }
        .sheet(isPresented: $isEditView) {
            MemoEditView(memo: self.memo)
            }
        )
    }
}
