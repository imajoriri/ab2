//
//  MemoListView.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/22.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI



enum MemoListType:Int {
    case all = 0
    case fact = 1
    case abstract = 2
    case product = 3
}

struct MemoListView: View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.createdAt, ascending: false)], animation: nil) var memos: FetchedResults<Memo>
    @State var isCreateView:Bool = true
    @State var deleteAlert:Bool = false
    @State var deleteMemo: MemoId?
    @State var segmentSelection:Int = 0
    
    func showDeleteAlert(offsets: IndexSet) {
        self.deleteMemo = MemoId(id: String(offsets.first!), memo: self.memos[offsets.first!])
    }
    
    struct MemoId: Identifiable {
        var id:String
        var memo:Memo
    }
    
    func isShowMemo(memo: Memo, listType: Int) -> Bool {
        switch listType {
        case MemoListType.all.rawValue:
            return true
        case MemoListType.fact.rawValue:
            return true
        case MemoListType.abstract.rawValue:
            if let unwrappedAbstract = memo.abstract {
                return !unwrappedAbstract.description.isEmpty
            }
            return false
        case MemoListType.product.rawValue:
            if let unwrappedProduct = memo.product {
                return !unwrappedProduct.description.isEmpty
            }
            return false
        default:
            return true
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    ForEach(memos, id: \.self) { memo in
                        Group {
                            if self.isShowMemo(memo: memo, listType: self.segmentSelection) {
                                NavigationLink(destination: MemoDetailView(memo: memo)) {
                                    MemoListRow(memo: memo, showMemoType: self.segmentSelection)
                                }
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
                            }
                        )
                    }
                }
                .navigationBarTitle(Text("メモ"))
                .navigationBarItems(trailing: Button(action: {
                    self.isCreateView = true
                }, label: {
                    Text("作成").foregroundColor(ColorCode.main.color())
                })
                    .sheet(isPresented: $isCreateView) {
                        MemoCreateView()
                })
                
                RoundSegmentView(selection: self.$segmentSelection, labels: ["全て", "事実", "抽象的", "プロダクト"])
                .padding(.bottom, 20.0)
            }
        }
    }
}

struct MemoListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return MemoListView().environment(\.managedObjectContext, context)
    }
}
