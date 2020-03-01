//
//  MemoListRow.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/24.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI

struct MemoListRow: View {
    let memo: Memo
    let showMemoType:Int
    var fact:String
    var abstract:String
    var product:String
    
    init(memo:Memo, showMemoType: Int) {
        self.memo = memo
        self.showMemoType = showMemoType
        self.fact = memo.fact != nil ? memo.fact!.description : ""
        self.abstract = memo.abstract != nil ? memo.abstract!.description : ""
        self.product = memo.product != nil ? memo.product!.description : ""
    }
    
    func showText() -> String {
        switch self.showMemoType {
        case 0:
            return self.fact
        case 1:
            return self.fact
        case 2:
            return self.abstract
        case 3:
            return self.product
        default:
            return self.fact
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.showText())
                .fontWeight(.regular)
                .lineLimit(1)
            
            HStack {
                if !self.fact.isEmpty {
                    MemoTag(text: MemoType.fact.rawValue, systemName: MemoSystemNameType.fact.rawValue)
                }
                if !self.abstract.isEmpty {
                    MemoTag(text: MemoType.abstract.rawValue, systemName: MemoSystemNameType.abstract.rawValue)
                }
                if !self.product.isEmpty {
                    MemoTag(text: MemoType.product.rawValue, systemName: MemoSystemNameType.product.rawValue)
                }
                Spacer()
            }
            .padding(.top, -8.0)
            .frame(width: 300)
        }
        .padding(.vertical, 10.0)
    }
}

//struct MemoListRow_Previews: PreviewProvider {
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.createdAt, ascending: false)], animation: nil) var memos: FetchedResults<Memo>
//
//    static var previews: some View {
//        MemoListRow(memo: memos.first)
//    }
//}
