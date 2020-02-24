//
//  MemoListView.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/22.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI



enum MemoListType {
    case all
    case unfinished
    case product
}

struct MemoListView: View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.createdAt, ascending: false)], animation: nil) var memos: FetchedResults<Memo>
    @State var isCreateView:Bool = true
    @State var deleteAlert:Bool = false
    @State var deleteMemo: MemoId?
    @State var segmentPicker:MemoListType = .all
    
    func showDeleteAlert(offsets: IndexSet) {
        self.deleteMemo = MemoId(id: String(offsets.first!), memo: self.memos[offsets.first!])
    }
    
    struct MemoId: Identifiable {
        var id:String
        var memo:Memo
    }
    
    func isShowMemo(memo: Memo, listType: MemoListType) -> Bool {
        switch listType {
        case .all:
            return true
        case .unfinished:
            if let unwrappedProduct = memo.product {
                return unwrappedProduct.description.isEmpty
            }
            return true
        case .product:
            if let unwrappedProduct = memo.product {
                return !unwrappedProduct.description.isEmpty
            }
            return false
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $segmentPicker, label: Text("none")) {
                    Text("全て").tag(MemoListType.all)
                    Text("未達成").tag(MemoListType.unfinished)
                    Text("プロダクト ").tag(MemoListType.product)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 16.0)
                
                List {
                    ForEach(memos, id: \.self) { memo in
                        Group {
                            if self.isShowMemo(memo: memo, listType: self.segmentPicker) {
                                NavigationLink(destination: MemoDetailView(memo: memo)) {
                                    MemoListRow(memo: memo)
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
                            })
                    }
                }
                .navigationBarTitle(Text("メモ"))
                .navigationBarItems(trailing: Button(action: {
                    self.isCreateView = true
                }, label: {
                    Text("add")
                })
                    .sheet(isPresented: $isCreateView) {
                        MemoCreateView()
                })
            }
        }
    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        return MemoTag(text: "事実", systemName: "paperclip")
    }
}
