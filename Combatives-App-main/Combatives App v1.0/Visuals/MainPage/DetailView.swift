//
//  DetailView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI


//DetailView is supposed to contain the details for a class when you select on it
// this is redundant to ClassView so we should get rid of it in the future

struct DetailView: View {
    let selection: Int
    var body: some View {
        Text("Detail view for selection \(selection)")
        //RearMountBlueDPView()
    }
}
