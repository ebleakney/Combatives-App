import SwiftUI

struct FourColumnView: View {
    var body: some View {
        HStack {
            // First Column
            VStack(alignment: .leading) {
                Text("Column 1 Header")
                    .font(.headline)
                    .padding(.bottom, 8)

                Text("Column 1, Row 1")
                Text("Column 1, Row 2")
                Text("Column 1, Row 3")
            }
            .padding()
            .overlay(Rectangle().frame(height: 1).padding(.top, 8), alignment: .bottom)

            // Second Column
            VStack(alignment: .leading) {
                Text("Column 2 Header")
                    .font(.headline)
                    .padding(.bottom, 8)

                Text("Column 2, Row 1")
                Text("Column 2, Row 2")
                Text("Column 2, Row 3")
            }
            .padding()
            .overlay(Rectangle().frame(height: 1).padding(.top, 8), alignment: .bottom)

            // Third Column
            VStack(alignment: .leading) {
                Text("Column 3 Header")
                    .font(.headline)
                    .padding(.bottom, 8)

                Text("Column 3, Row 1")
                Text("Column 3, Row 2")
                Text("Column 3, Row 3")
            }
            .padding()
            .overlay(Rectangle().frame(height: 1).padding(.top, 8), alignment: .bottom)

            // Fourth Column
            VStack(alignment: .leading) {
                Text("Column 4 Header")
                    .font(.headline)
                    .padding(.bottom, 8)

                Text("Column 4, Row 1")
                Text("Column 4, Row 2")
                Text("Column 4, Row 3")
            }
            .padding()
            .overlay(Rectangle().frame(height: 1).padding(.top, 8), alignment: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FourColumnView()
    }
}
