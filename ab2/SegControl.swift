//
//  SegControl.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/28.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI

struct SegControl: UIViewRepresentable {

    func makeUIView(context: Context) -> UISegmentedControl {
        return UISegmentedControl(items: ["One", "Two"])
    }

    func updateUIView(_ uiView: UISegmentedControl, context: Context) {
        uiView.center = uiView.center
        uiView.selectedSegmentIndex = 0
        uiView.layer.frame = CGRect(x: 150, y: 100, width: 300, height: 150)
    }

}
