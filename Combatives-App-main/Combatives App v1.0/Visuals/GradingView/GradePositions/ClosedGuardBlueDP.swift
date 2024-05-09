//
// ClosedGuardBlueDP.swift
// 
//

import SwiftUI

struct ClosedGuardBlueDPView: View {
    @State private var dpScoringItems: [ScoringItem] = [
        ScoringItem(description: "Guard passed", points: 0, isExtraPoints: false),
        ScoringItem(description: "Recovered CG, bottom 1/2, swept into silver's CG, or neutral", points: 3, isExtraPoints: false),
        ScoringItem(description: "Maintained", points: 5, isExtraPoints: false),
        ScoringItem(description: "Swept into top 1/2 guard", points: 7, isExtraPoints: false),
        ScoringItem(description: "Swept to top dominant", points: 10, isExtraPoints: false),
        ScoringItem(description: "RNC or Guillotine (extra points)", points: 10, isExtraPoints: true)
    ]
    
    @State private var ndpScoringItems: [ScoringItem] = [
        ScoringItem(description: "No pass; got swept to other NDP", points: 0, isExtraPoints: false),
        ScoringItem(description: "Pass to top 1/2, establish CG or bottom 1/2, escape to neutral", points: 3, isExtraPoints: false),
        ScoringItem(description: "Pass to side mount", points: 5, isExtraPoints: false),
        ScoringItem(description: "Pass to knee mount", points: 7, isExtraPoints: false),
        ScoringItem(description: "Pass to frount or rear mount", points: 10, isExtraPoints: false),
        ScoringItem(description: "RNC or Guillotine (extra points)", points: 10, isExtraPoints: true)
    ]
    
    @State private var timerIsRunning = false
    @State private var timeElapsed: TimeInterval = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var navigateToClosedGuardGreyView = false // State variable to control navigation to the next view

    var body: some View {
        VStack {
            Text(timerText)
                .font(.title)
                .padding()
                .onReceive(timer) { _ in
                    if self.timerIsRunning {
                        self.timeElapsed += 1
                    }
                }
            
            List {
                Section(header: Text("Closed Guard (DP)").foregroundColor(.black).padding().background(Color.blue)) {
                    ForEach(dpScoringItems.indices, id: \.self) { index in
                        ScoringRow(item: self.$dpScoringItems[index])
                    }
                }
                Section(header: Text("Closed Guard (NDP)").foregroundColor(.black).padding().background(Color.gray)) {
                    ForEach(ndpScoringItems.indices, id: \.self) { index in
                        ScoringRow(item: self.$ndpScoringItems[index])
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .background(Color(.systemGroupedBackground)) // Matches the typical background color for grouped lists
            
            HStack {
                Spacer()
                Button(action: {
                    self.timerIsRunning.toggle()
                }) {
                    Text(timerIsRunning ? "Stop Timer" : "Start Timer")
                        .padding()
                        .foregroundColor(.white)
                        .background(timerIsRunning ? Color.red : Color.green)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Button(action: {
                    self.timerIsRunning = false
                    self.timeElapsed = 0
                }) {
                    Text("Reset Timer")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(destination: ClosedGuardGreyDPView(), isActive: $navigateToClosedGuardGreyView) {
                    EmptyView() // Invisible link to NextView
                }
                
                Button(action: {
                    // Placeholder action for the next button
                    print("Next button tapped")
                    self.navigateToClosedGuardGreyView = true // Activate navigation to NextView
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
            .padding(.vertical)
        }
    }

    private var timerText: String {
        let minutes = Int(timeElapsed) / 60
        let seconds = Int(timeElapsed) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ClosedGuardBlueView_Previews: PreviewProvider {
    static var previews: some View {
        ClosedGuardBlueDPView()
    }
}
