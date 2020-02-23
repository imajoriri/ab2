//
//  MemoEntity.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/22.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI

class MemoEntity {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.createdAt, ascending: true)], animation: nil) var memos: FetchedResults<Memo>
    
//    static func fetchAll() -> FetchedResults<Memo> {
//        @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.createdAt, ascending: true)], animation: nil) var memos: FetchedResults<Memo>
//        return memos
//    }
}
