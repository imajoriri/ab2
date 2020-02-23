//
//  MemoEditView.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/22.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI

struct MemoEditView: View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
                    Image(systemName: "multiply.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                    
                }
                Spacer()
                VStack {
                    Divider().overlay(
                        RoundedRectangle(cornerRadius: 1)
                            .stroke(Color.gray, lineWidth: 3)
                    )
                }
                .frame(width: 100.0)
                Spacer()
                Button(action: {
                    self.memo.fact = self.fact
                    self.memo.abstract = self.abstract
                    self.memo.product = self.product
                    do {
                        try self.context.save()
                    } catch {
                        print(error)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("save")
                }
            }
            .padding(.horizontal, 16.0)
            .padding(.top, 16.0)
            
            VStack(alignment: .leading) {
                Text("事実")
                    .font(.headline).padding(.bottom, -5.0)
                MultilineField(text: $fact)
                    .onAppear {
                        self.fact = self.memo.fact!.description
                }
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.gray, lineWidth: 0.2)
                )
                
                Text("抽象的")
                    .font(.headline).padding(.bottom, -5.0).padding(.top, 20)
                MultilineField(text: $abstract)
                    .onAppear {
                        self.abstract = self.memo.abstract!.description
                }
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.gray, lineWidth: 0.2)
                )
                
                Text("プロダクト")
                    .font(.headline).padding(.bottom, -5.0).padding(.top, 20)
                MultilineField(text: $product)
                    .onAppear {
                        self.product = self.memo.product!.description
                }
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
        .onTapGesture {
            self.endEditing()
        }
    }
}

//struct MemoEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemoEditView()
//    }
//}
