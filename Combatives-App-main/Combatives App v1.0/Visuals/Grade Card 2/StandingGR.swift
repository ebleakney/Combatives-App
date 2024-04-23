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
                CheckboxView(checked: self.bindingForPoint(index), label: "\(self.points)")
            }
            // Add labels indicating the outcome of each point
            Text(outcome(for: points * 2)) // "Won", "Tied", or "Lost"
            Text(outcome(for: points)) // "Won", "Tied", or "Lost"
            Text("Tied")
        }
    }

    private func outcome(for points: Int) -> String {
        guard let lastTapped = lastTapped else { return "Tied" }
        return lastTapped == points ? "Won" : "Lost"
    }

    private func bindingForPoint(_ index: Int) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                return self.lastTapped == self.points * index
            },
            set: { newValue in
                if newValue {
                    self.totalPoints += self.points * index
                    self.lastTapped = self.points * index
                } else {
                    if self.lastTapped == self.points * index {
                        self.totalPoints -= self.points * index
                        self.lastTapped = nil
                    }
                }
            }
        )
    }
}

struct StandingGradeCardView: View {
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
                    CheckboxView(checked: .constant(false), label: "7")
                    CheckboxView(checked: .constant(false), label: "R")
                    CheckboxView(checked: .constant(false), label: "3")
                    CheckboxView(checked: .constant(false), label: "L")
                }
                .foregroundColor(.blue)
            }
            .padding()
            .background(Color.blue.opacity(0.2))

            VStack {
                Text("Memory Points (of 9):")
                    .font(.subheadline)

                VStack {
                    MemoryPointsRowView(points: 2, totalPoints: $blueTotalPoints, lastTapped: $lastBlueTapped)
                    MemoryPointsRowView(points: 1, totalPoints: $blueTotalPoints, lastTapped: $lastBlueTapped)
                    MemoryPointsRowView(points: 0, totalPoints: $blueTotalPoints, lastTapped: $lastBlueTapped)
                }
                .background(Color.blue.opacity(0.1))

                VStack {
                    MemoryPointsRowView(points: 2, totalPoints: $silverTotalPoints, lastTapped: $lastSilverTapped)
                    MemoryPointsRowView(points: 1, totalPoints: $silverTotalPoints, lastTapped: $lastSilverTapped)
                    MemoryPointsRowView(points: 0, totalPoints: $silverTotalPoints, lastTapped: $lastSilverTapped)
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
                    CheckboxView(checked: .constant(false), label: "B")
                    CheckboxView(checked: .constant(false), label: "9")
                    CheckboxView(checked: .constant(false), label: "P")
                    CheckboxView(checked: .constant(false), label: "F")
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
