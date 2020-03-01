//
//  MemoEditView.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/22.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI

struct MemoEditView: View {    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let memo:Memo
    @State var fact:String = ""
    @State var abstract:String = ""
    @State var product:String = ""
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                    
                }
                Spacer()
                Button(action: {
                    MemoController.update(memo: self.memo, fact: self.fact, abstract: self.abstract, product: self.product)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("保存")
                }
            }
            .padding(.horizontal, 16.0)
            .padding(.top, 16.0)
            
            VStack(alignment: .leading) {
                Text(MemoType.fact.rawValue)
                    .font(.headline).padding(.bottom, -5.0)
                MultilineField(text: $fact)
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.gray, lineWidth: 0.2)
                )
                
                Text(MemoType.abstract.rawValue)
                    .font(.headline).padding(.bottom, -5.0).padding(.top, 20)
                MultilineField(text: $abstract)
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.gray, lineWidth: 0.2)
                )
                
                Text(MemoType.product.rawValue)
                    .font(.headline).padding(.bottom, -5.0).padding(.top, 20)
                MultilineField(text: $product)
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.gray, lineWidth: 0.2)
                )

                Spacer()
            }
            .padding()
            .keyboardObserving()
        }
        .onAppear {
            if let unwrapped = self.memo.fact {
                self.fact = unwrapped.description
            }
            if let unwrapped = self.memo.abstract {
                self.abstract = unwrapped.description
            }
            if let unwrapped = self.memo.product {
                self.product = unwrapped.description
            }
        }
        .onTapGesture {
            self.endEditing()
        }
    }
}
