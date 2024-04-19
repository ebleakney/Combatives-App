import SwiftUI
 
struct CheckboxView: View {

    @Binding var checked: Bool

    var label: String

    var body: some View {

        Button(action: {

            self.checked.toggle()

        }) {

            HStack {

                Image(systemName: checked ? "checkmark.square.fill" : "square")

                    .foregroundColor(checked ? .green : .gray)

                Text(label)

            }

        }

        .foregroundColor(.black)

    }

}
 
struct MemoryPointsRowView: View {

    let points: Int

    @Binding var totalPoints: Int

    @Binding var lastTapped: Int?

    var body: some View {

        HStack {

            ForEach(0..<3) { index in
                ForEach(0..<3) { index in
                    CheckboxView(checked: self.bindingForPoint(index), label: "\(self.points)")
                }

            }

        }

    }

    private func bindingForPoint(_ index: Int) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                return self.lastTapped == self.points
            },
            set: { newValue in
                if newValue {
                    if self.lastTapped != self.points {
                        self.totalPoints += self.points
                        self.lastTapped = self.points
                    }
                } else {
                    if self.lastTapped == self.points {
                        self.totalPoints -= self.points
                        self.lastTapped = nil
                    }
                }
            }
        )
    }
}


 
struct StandingGradeCardView: View {

    @State private var blueCheckStates = Array(repeating: false, count: 4)

    @State private var silverCheckStates = Array(repeating: false, count: 4)

    @State private var blueTotalPoints: Int = 0

    @State private var silverTotalPoints: Int = 0

    @State private var lastBlueTapped: Int?

    @State private var lastSilverTapped: Int?

    var body: some View {

        VStack {

            VStack {

                Text("Standing Evaluation")

                    .font(.headline)

                Text("Total Score (of 25):")

                    .font(.subheadline)

                HStack {

                    CheckboxView(checked: $blueCheckStates[0], label: "7")

                    CheckboxView(checked: $blueCheckStates[1], label: "R")

                    CheckboxView(checked: $blueCheckStates[2], label: "3")

                    CheckboxView(checked: $blueCheckStates[3], label: "L")

                }

                .foregroundColor(.blue)

            }

            .padding()

            .background(Color.blue.opacity(0.2))

            VStack {

                Text("Memory Points (of 9):")

                    .font(.subheadline)

                VStack {

                    MemoryPointsRowView(points: 1, totalPoints: $blueTotalPoints, lastTapped: $lastBlueTapped)

                    MemoryPointsRowView(points: 2, totalPoints: $blueTotalPoints, lastTapped: $lastBlueTapped)

                    MemoryPointsRowView(points: 3, totalPoints: $blueTotalPoints, lastTapped: $lastBlueTapped)

                }

                .background(Color.blue.opacity(0.1))

                VStack {

                    MemoryPointsRowView(points: 1, totalPoints: $silverTotalPoints, lastTapped: $lastSilverTapped)

                    MemoryPointsRowView(points: 2, totalPoints: $silverTotalPoints, lastTapped: $lastSilverTapped)

                    MemoryPointsRowView(points: 3, totalPoints: $silverTotalPoints, lastTapped: $lastSilverTapped)

                }

                .background(Color.gray.opacity(0.1))

                HStack {

                    Text("Blue Total Points: \(blueTotalPoints)")

                    Spacer()

                    Text("Silver Total Points: \(silverTotalPoints)")

                }

                .padding(.horizontal)

            }

            VStack {

                Text("Standing Evaluation")

                    .font(.headline)

                Text("Total Score (of 25):")

                    .font(.subheadline)

                HStack {

                    CheckboxView(checked: $silverCheckStates[0], label: "B")

                    CheckboxView(checked: $silverCheckStates[1], label: "9")

                    CheckboxView(checked: $silverCheckStates[2], label: "P")

                    CheckboxView(checked: $silverCheckStates[3], label: "F")

                }

                .foregroundColor(.gray)

            }

            .padding()

            .background(Color.gray.opacity(0.2))

        }

        .padding()

    }

}
 
struct StandingGradeCardView_Previews: PreviewProvider {

    static var previews: some View {

        StandingGradeCardView()

    }

}
