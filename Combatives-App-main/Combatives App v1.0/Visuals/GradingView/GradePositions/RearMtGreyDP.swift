//
// RearMtGreyDP.swift
//
//

//import SwiftUI
//
//
//struct RearMountGreyDPView: View {
//    
//    @State private var dpScoringItems: [ScoringItem] = [
//        ScoringItem(description: "Lost position or established closed or 1/2 guard (top/bottom)", points: 0, isExtraPoints: false),
//        ScoringItem(description: "Established front, knee, or side mount", points: 3, isExtraPoints: false),
//        ScoringItem(description: "Recovered rear mount", points: 5, isExtraPoints: false),
//        ScoringItem(description: "Maintained", points: 7, isExtraPoints: false),
//        ScoringItem(description: "Rear Naked Choke (RNC)", points: 10, isExtraPoints: false),
//        ScoringItem(description: "Guillotine (extra points)", points: 10, isExtraPoints: true)
//    ]
//    
//    @State private var ndpScoringItems: [ScoringItem] = [
//        ScoringItem(description: "Got choked", points: 0, isExtraPoints: false),
//        ScoringItem(description: "No escape", points: 3, isExtraPoints: false),
//        ScoringItem(description: "Escape to any other NDP or 1/2 guard (top/bottom)", points: 5, isExtraPoints: false),
//        ScoringItem(description: "Escape to neutral or establish closed guard DP", points: 7, isExtraPoints: false),
//        ScoringItem(description: "Escape to top dominant", points: 10, isExtraPoints: false),
//        ScoringItem(description: "RNC or Guillotine (extra points)", points: 10, isExtraPoints: true)
//    ]
//    
//    @State private var timerIsRunning = false
//    @State private var timeElapsed: TimeInterval = 0
//    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @State private var navigateToBlueGradeView = false // State variable to control navigation to the next view
//
//
//    var body: some View {
//        VStack {
//            Text(timerText)
//                .font(.title)
//                .padding()
//                .onReceive(timer) { _ in
//                    if self.timerIsRunning {
//                        self.timeElapsed += 1
//                    }
//                }
//            
//            List {
//                Section(header: Text("Rear Mt (DP)").foregroundColor(.black).padding().background(Color.gray)) {
//                    ForEach(dpScoringItems.indices, id: \.self) { index in
//                        ScoringRow(item: self.$dpScoringItems[index])
//                    }
//                }
//                Section(header: Text("Rear Mt (NDP)").foregroundColor(.black).padding().background(Color.blue)) {
//                    ForEach(ndpScoringItems.indices, id: \.self) { index in
//                        ScoringRow(item: self.$ndpScoringItems[index])
//                    }
//                }
//            }
//            .listStyle(GroupedListStyle())
//            .background(Color(.systemGroupedBackground)) // Matches the typical background color for grouped lists
//            
//            HStack {
//                Spacer()
//                Button(action: {
//                    self.timerIsRunning.toggle()
//                }) {
//                    Text(timerIsRunning ? "Stop Timer" : "Start Timer")
//                        .padding()
//                        .foregroundColor(.white)
//                        .background(timerIsRunning ? Color.red : Color.green)
//                        .cornerRadius(8)
//                }
//                .padding(.horizontal)
//                
//                Button(action: {
//                    self.timerIsRunning = false
//                    self.timeElapsed = 0
//                }) {
//                    Text("Reset Timer")
//                        .padding()
//                        .foregroundColor(.white)
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                }
//                .padding(.horizontal)
//                
//                Spacer()
//                
//                NavigationLink(destination: /*GradeSheetView()*/EmptyView(), isActive: $navigateToBlueGradeView) {
//                    EmptyView() // Invisible link to NextView
//                }
//                /*TODO*/
//                // NEEDS POINT TOTALING FOR THE INPUTS INTO THE GRADEVIEW
//                
//                Button(action: {
//                    // Placeholder action for the next button
//                    print("Next button tapped")
//                    self.navigateToBlueGradeView = true
//                }) {
//                    Image(systemName: "arrow.right.circle.fill")
//                        .resizable()
//                        .frame(width: 40, height: 40)
//                        .foregroundColor(.blue)
//                }
//                .padding(.trailing, 20)
//                .padding(.bottom, 20)
//            }
//            .padding(.vertical)
//        }
//    }
//
//    private var timerText: String {
//        let minutes = Int(timeElapsed) / 60
//        let seconds = Int(timeElapsed) % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//}
//
////struct RearMountGreyView_Previews: PreviewProvider {
////    static var previews: some View {
////        RearMountGreyDPView()
////    }
////}



import SwiftUI

struct RearMountGreyDPView: View {
    @State private var dpScoringItems: [ScoringItem] = [
        ScoringItem(description: "Lost position or established closed or 1/2 guard (top/bottom)", points: 0, isExtraPoints: false),
        ScoringItem(description: "Established front, knee, or side mount", points: 3, isExtraPoints: false),
        ScoringItem(description: "Recovered rear mount", points: 5, isExtraPoints: false),
        ScoringItem(description: "Maintained", points: 7, isExtraPoints: false),
        ScoringItem(description: "Rear Naked Choke (RNC)", points: 10, isExtraPoints: false),
        ScoringItem(description: "Guillotine (extra points)", points: 10, isExtraPoints: true)
    ]
    
    @State private var ndpScoringItems: [ScoringItem] = [
        ScoringItem(description: "Got choked", points: 0, isExtraPoints: false),
        ScoringItem(description: "No escape", points: 3, isExtraPoints: false),
        ScoringItem(description: "Escape to any other NDP or 1/2 guard (top/bottom)", points: 5, isExtraPoints: false),
        ScoringItem(description: "Escape to neutral or establish closed guard DP", points: 7, isExtraPoints: false),
        ScoringItem(description: "Escape to top dominant", points: 10, isExtraPoints: false),
        ScoringItem(description: "RNC or Guillotine (extra points)", points: 10, isExtraPoints: true)
    ]
    
    @State private var timerIsRunning = false
    @State private var timeElapsed: TimeInterval = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var navigateToBlueGradeView = false
    @State private var liveGrapplingPoints: Int = 0
    @State private var liveTotalPoints: Int = 0

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
                Section(header: Text("Rear Mt (DP)").foregroundColor(.black).padding().background(Color.gray)) {
                    ForEach(dpScoringItems.indices, id: \.self) { index in
                        ScoringRow(item: self.$dpScoringItems[index])
                    }
                }
                Section(header: Text("Rear Mt (NDP)").foregroundColor(.black).padding().background(Color.blue)) {
                    ForEach(ndpScoringItems.indices, id: \.self) { index in
                        ScoringRow(item: self.$ndpScoringItems[index])
                    }
                }
            }
            
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
                
                NavigationLink(destination: BlueGradeView(liveGrapplingPoints: $liveGrapplingPoints, liveTotalPoints: $liveTotalPoints), isActive: $navigateToBlueGradeView) {
                    EmptyView() // This stays as an invisible link
                }

                Button(action: {
                    // Calculate the total points before navigating
                    calculateTotalPoints()
                    self.navigateToBlueGradeView = true
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

    private func calculateTotalPoints() {
        // Implement the logic to calculate liveGrapplingPoints and liveTotalPoints
        // For demonstration:
        liveGrapplingPoints = dpScoringItems.reduce(0) { $0 + $1.points }
        liveTotalPoints = liveGrapplingPoints + ndpScoringItems.reduce(0) { $0 + $1.points }
    }
}
