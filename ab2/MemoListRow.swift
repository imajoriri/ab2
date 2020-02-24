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
        VStack(alignment: .leading) {
            Text(memo.fact!.description)
                .fontWeight(.bold)
            
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
            .frame(width: 300)
        }
    }
}

//struct MemoListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MemoListRow()
//    }
//}
