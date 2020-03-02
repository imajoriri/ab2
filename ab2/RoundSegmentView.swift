//
//  RoundSegmentView.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/03/01.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI



struct RoundSegmentView: View {
    @Binding var selection:Int
    let labels:[String]
    @State var x:CGFloat = CGFloat(0)
    @State var capWidth:CGFloat = CGFloat(100)
    var backgroundColor:Color
    @State var selectedText:String = ""
    
    init(selection: Binding<Int>, labels: [String]) {
        self._selection = selection
        self.labels = labels
        self.backgroundColor = Color(red: 241/255, green: 241/255, blue: 243/255)
    }
    
    func buttonFrameWidth() -> CGFloat {
        return CGFloat((UIScreen.main.bounds.width / CGFloat(self.labels.count)) - 10)
    }
    
    var body: some View {
        ZStack {
            HStack {
                ForEach(0..<self.labels.count, id: \.self) {index in
                    GeometryReader { geometry in
                    Button(action: {
                        self.selectedText = ""
                        self.selection = index
                        self.x = geometry.frame(in: .named("myCoordination")).minX
                            - (UIScreen.main.bounds.width / CGFloat(2))
                            + (geometry.size.width / CGFloat(2))
                        self.selectedText = self.labels[index]
                        self.capWidth = geometry.size.width
                    }) {
                        Text(self.labels[index])
                            .font(.system(size: 16.0))
                            .foregroundColor(ColorCode.main.color())
                    }
                    .frame(width: self.buttonFrameWidth(), height: 32)
                    }
                }
            }
            
            .frame(width: UIScreen.main.bounds.width - 16, height: 38)
            .padding(.horizontal, 4.0)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(backgroundColor)
            )
            
            ZStack {
                Capsule().fill(ColorCode.main.color())
                Text(self.selectedText).foregroundColor(Color.white)
            }
            .frame(width: self.capWidth, height: 36)
            .offset(x: self.x)
            .animation(Animation.easeInOut.speed(2.0))
                
        }
        .coordinateSpace(name: "myCoordination")
        .onAppear {
            self.x = CGFloat(0) - (UIScreen.main.bounds.width / CGFloat(2))
                + (UIScreen.main.bounds.width / CGFloat(self.labels.count) / CGFloat(2))
            self.selectedText = self.labels.first ?? ""
            self.capWidth = self.buttonFrameWidth()
        }
    }
}

struct RoundSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        RoundSegmentView(selection: .constant(0), labels: ["全て", "事実", "抽象的", "プロダクト"])
    }
}













//struct RoundSegmentView: View {
//    @Binding var selection:Int
//    let labels:[String]
//
//    let backgroundColor:Color = Color(red: 241/255, green: 241/255, blue: 243/255)
//
//    func buttonFrameWidth() -> CGFloat {
//        return CGFloat((UIScreen.main.bounds.width / CGFloat(self.labels.count)) - 10)
//    }
//
//    var body: some View {
//        HStack {
//            ForEach(0..<self.labels.count, id: \.self) {index in
//                Button(action: {
//                    self.selection = index
//                }) {
//                    Text(self.labels[index])
//                        .font(.system(size: 16.0))
//                        .foregroundColor(self.selection == index ? Color.white : ColorCode.main.color())
//                        .frame(width: self.buttonFrameWidth(), height: 32)
//                        .background(
//                            RoundedRectangle(cornerRadius: 30)
//                                .fill(self.selection == index ? ColorCode.main.color() : self.backgroundColor)
//                    )
//                }
//            }
//        }
//        .frame(width: UIScreen.main.bounds.width - 16, height: 38)
//        .padding(.horizontal, 4.0)
//        .background(
//            RoundedRectangle(cornerRadius: 30)
//            .fill(backgroundColor)
//        )
//    }
//}
//
//struct RoundSegmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoundSegmentView(selection: .constant(0), labels: ["全て", "事実", "抽象的", "プロダクト"])
//    }
//}
