import SwiftUI

struct FourColumnView: View {
    // first column selector names
    @State private var cgGuardPassed: Bool = false
    @State private var cgRecoveredCG: Bool = false
    @State private var cgMaintained: Bool = false
    @State private var cgSwepttoTop: Bool = false
    @State private var cgSwepttoDominant: Bool = false
    @State private var cgRNC: Bool = false
    // second column selector names
    @State private var smLostposition: Bool = false
    @State private var smRecovered: Bool = false
    @State private var smMaintained: Bool = false
    @State private var smGainedKnee: Bool = false
    @State private var smGainedRear: Bool = false
    @State private var smRNC: Bool = false
    // third column selector names
    @State private var fmLostposition: Bool = false
    @State private var fmEstablished: Bool = false
    @State private var fmRecovered: Bool = false
    @State private var fmMaintained: Bool = false
    @State private var fmGainedRear: Bool = false
    @State private var fmRNC: Bool = false
    //fourth column selector names
    @State private var rmLostposition: Bool = false
    @State private var rmEstablished: Bool = false
    @State private var rmRecovered: Bool = false
    @State private var rmMaintained: Bool = false
    @State private var rmRNC: Bool = false
    @State private var rmGuillotine: Bool = false
    
    
    var body: some View {
        HStack(spacing: 0) { // Set spacing to 0
            // Blue Dominant Text Box
            VStack {
                Text("Blue Dominant")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .rotationEffect(.degrees(-90))
                    .frame(maxHeight: 350) // Extend to the bottom
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
            .frame(width: 200) // Fixed width

            // First Column
            VStack(alignment: .leading) {
                Text("Closed Guard (CG) (DP)")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                Text("Guard Passed")
                    .padding(.bottom, 4)
                    .border(cgGuardPassed == true ? .green : .black)
                    .onTapGesture {
                        cgGuardPassed = !cgGuardPassed
                    }

                Text("Recovered CG, bottom 1/2, swept into silver's CG, or neutral")
                    .padding(.bottom, 4)
                    .border(cgRecoveredCG == true ? .green : .black)
                    .onTapGesture {
                        cgRecoveredCG = !cgRecoveredCG
                    }

                Text("Maintained")
                    .padding(.bottom, 4)
                    .border(cgMaintained == true ? .green : .black)
                    .onTapGesture {
                        cgMaintained = !cgMaintained
                    }

                Text("Swept to top 1/2 guard")
                    .padding(.bottom, 4)
                    .border(cgSwepttoTop == true ? .green : .black)
                    .onTapGesture {
                        cgSwepttoTop = !cgSwepttoTop
                    }

                Text("Swept to top dominant")
                    .padding(.bottom, 4)
                    .border(cgSwepttoDominant == true ? .green : .black)
                    .onTapGesture {
                        cgSwepttoDominant = !cgSwepttoDominant
                    }

                Text("RNC or Guillotine")
                    .padding(.bottom, 4)
                    .border(cgRNC == true ? .green : .black)
                    .onTapGesture {
                        cgRNC = !cgRNC
                    }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .frame(width: 150) // Fixed width
            .frame(maxHeight: 400)

            // Second Column
            VStack(alignment: .leading) {
                Text("Side Mt (DP)")
                    .font(.headline)
                    .padding(.bottom, 8)

                Text("Lost Position or established closed or 1/2 guard (top/bottom)")
                    .padding(.bottom, 4)
                    .border(smLostposition == true ? .green : .black)
                    .onTapGesture {
                        smLostposition = !smLostposition
                    }

                Text("Recovered Side Mount")
                    .padding(.bottom, 4)
                    .border(smRecovered == true ? .green : .black)
                    .onTapGesture {
                        smRecovered = !smRecovered
                    }

                Text("Maintained")
                    .padding(.bottom, 4)
                    .border(smMaintained == true ? .green : .black)
                    .onTapGesture {
                        smMaintained = !smMaintained
                    }

                Text("Gained knee mount")
                    .padding(.bottom, 4)
                    .border(smGainedKnee == true ? .green : .black)
                    .onTapGesture {
                        smGainedKnee = !smGainedKnee
                    }

                Text("Gained ft or rear mount")
                    .padding(.bottom, 4)
                    .border(smGainedRear == true ? .green : .black)
                    .onTapGesture {
                        smGainedRear = !smGainedRear
                    }

                Text("RNC or Guillotine")
                    .padding(.bottom, 4)
                    .border(smRNC == true ? .green : .black)
                    .onTapGesture {
                        smRNC = !smRNC
                    }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .frame(width: 150) // Fixed width
            .frame(maxHeight: 400)


            // Third Column
            VStack(alignment: .leading) {
                Text("Front Mt (DP)")
                    .font(.headline)
                    .padding(.bottom, 8)

                Text("Lost Position or established closed or 1/2 guard (top/bottom)")
                    .padding(.bottom, 4)
                    .border(.black)

                Text("Established side or knee mount")
                    .padding(.bottom, 4)
                    .border(.black)

                Text("Recovered front mount")
                    .padding(.bottom, 4)
                    .border(.black)

                Text("Maintained")
                    .padding(.bottom, 4)
                    .border(.black)

                Text("Gained rear mount")
                    .padding(.bottom, 4)
                    .border(.black)

                Text("RNC or Guillotine")
                    .padding(.bottom, 4)
                    .border(.black)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .frame(width: 150) // Fixed width
            .frame(maxHeight: 400)


            // Fourth Column
            VStack(alignment: .leading) {
                Text("Rear Mt (DP)")
                    .font(.headline)
                    .padding(.bottom, 8)

                Text("Lost Position or established closed or 1/2 guard (top/bottom)")
                    .padding(.bottom, 4)
                    .border(.black)

                Text("Established frount, knee, or side mount")
                    .padding(.bottom, 4)
                    .border(.black)

                Text("Recovered rear mount")
                    .padding(.bottom, 4)
                    .border(.black)

                Text("Maintained")
                    .padding(.bottom, 4)
                    .border(.black)

                Text("Rear Naked Choke (RNC)")
                    .padding(.bottom, 4)
                    .border(.black)

                Text("Guillotine")
                    .padding(.bottom, 4)
                    .border(.black)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .frame(width: 150) // Fixed width
            .frame(maxHeight: 400)

        }
        .background(Color.white)
        .padding()
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FourColumnView()
    }
}
