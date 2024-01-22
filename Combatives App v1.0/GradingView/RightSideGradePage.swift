import SwiftUI

struct FourColumnView: View {
    var body: some View {
        HStack {
            // Blue Dominant Text Box
            VStack {
                Text("Blue Dominant")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .rotationEffect(.degrees(-90))
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)

            // First Column
            VStack(alignment: .leading) {
                Text("Closed Guard (CG) (DP)")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                Text("Guard Passed")
                Text("Recovered CG, bottom 1/2, swept into silver's CG, or neutral")
                Text("Maintained")
                Text("Swept to top 1/2 guard")
                Text("Swept to top dominant")
                Text("RNC or Guillotine")
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)

            // Second Column
            VStack(alignment: .leading) {
                Text("Side Mt (DP)")
                    .font(.headline)
                    .padding(.bottom, 8)

                ForEach(0..<5) { row in
                    Text("Column 2, Row \(row + 1)")
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)

            // Third Column
            VStack(alignment: .leading) {
                Text("Front Mt (DP)")
                    .font(.headline)
                    .padding(.bottom, 8)

                ForEach(0..<5) { row in
                    Text("Column 3, Row \(row + 1)")
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)

            // Fourth Column
            VStack(alignment: .leading) {
                Text("Rear Mt (DP)")
                    .font(.headline)
                    .padding(.bottom, 8)

                ForEach(0..<5) { row in
                    Text("Column 4, Row \(row + 1)")
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
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
