//
//  MemoModel.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/23.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI

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
}
