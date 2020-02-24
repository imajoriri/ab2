//
//  MemoModel.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/23.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI

enum MemoType:String {
    case fact = "事実"
    case abstract = "抽象化"
    case product = "プロダクト"
}

enum MemoSystemNameType:String {
    case fact = "pencil"
    case abstract = "paperclip"
    case product = "heart"
}

struct MemoController {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func delete(memo: Memo) {
        context.delete(memo)
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    static func create(fact: String, abstract: String, product: String) {
        let memo = Memo(context: self.context)
        memo.fact = fact
        memo.abstract = abstract
        memo.product = product
        memo.createdAt = Date()
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    }
    
    static func update(memo: Memo, fact: String, abstract: String, product: String) {
        memo.fact = fact
        memo.abstract = abstract
        memo.product = product
        memo.createdAt = Date()
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    }
}
