//
//  MemoListView.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/22.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI

struct MemoTag: View {
    let text:String
    let systemName:String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
            Text(text)
                .offset(x: -5)
        }
    }
}

struct MemoListView: View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.createdAt, ascending: false)], animation: nil) var memos: FetchedResults<Memo>
    @State var isCreateView:Bool = true
    @State var deleteAlert:Bool = false
    @State var deleteMemo: MemoId?
    
    func showDeleteAlert(offsets: IndexSet) {
        self.deleteMemo = MemoId(id: String(offsets.first!), memo: self.memos[offsets.first!])
    }
    
    struct MemoId: Identifiable {
        var id:String
        var memo:Memo
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(memos, id: \.self) { memo in
                    NavigationLink(destination: MemoDetailView(memo: memo)) {
                        VStack(alignment: .leading) {
                            Text(memo.fact!.description)
                                .fontWeight(.bold)
                            
                            HStack {
                                if !memo.fact!.description.isEmpty {
                                    MemoTag(text: "事実", systemName: "pencil")
                                }
                                if !memo.abstract!.description.isEmpty {
                                    MemoTag(text: "抽象化", systemName: "paperclip")
                                }
                                if !memo.product!.description.isEmpty {
                                    MemoTag(text: "プロダクト", systemName: "heart")
                                }
                                Spacer()
                            }
                            .frame(width: 300)
                        }
                        
                    }
                    
                }
                .onDelete(perform: showDeleteAlert)
                .alert(item: self.$deleteMemo) { memo in
                    Alert(title: Text("削除しますか？"),
                          primaryButton: .destructive(Text("Delete")) {
                            if let unwrappedDeleteMemo = self.deleteMemo {
                                MemoController.delete(memo: unwrappedDeleteMemo.memo)
                            }
                            
                        },
                          secondaryButton: .cancel() {
                            
                        })
                }
                
            }
            .navigationBarTitle(Text("Today"))
            .navigationBarItems(trailing: Button(action: {
                self.isCreateView = true
            }, label: {
                Text("add")
            })
            .sheet(isPresented: $isCreateView) {
                MemoCreateView()
            })
        }
        .onAppear(perform: {
            self.isCreateView = true
        })
        
    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
    }
}
