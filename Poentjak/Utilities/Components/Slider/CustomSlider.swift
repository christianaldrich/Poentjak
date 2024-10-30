//
//  CustomSlider.swift
//  Poentjak
//
//  Created by Shan Havilah on 29/10/24.
//


import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var step: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background track
                Rectangle()
                    .fill(Color.neutralGrayQuaternaryGray)
                    .frame(height: 6)
                    .cornerRadius(12)

                // Active track (left side)
                Rectangle()
                    .fill(Color.primaryGreen500)
                    .frame(width: activeTrackWidth(in: geometry.size.width), height: 6)
                    .cornerRadius(12)

                // Thumb
                Circle()
                    .fill(Color.primaryGreen500)
                    .frame(width: 19, height: 19)
                    .offset(x: thumbPosition(in: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let newValue = value(for: gesture.location.x, in: geometry.size.width)
                                value = newValue
                                print("Thumb position: \(thumbPosition(in: geometry.size.width))") // Print the thumb position
                            }
                    )
                
                // Custom numbers below the slider
                ForEach(1...5, id: \.self) { number in
                    Text("\(number)")
                        .font(.customFootNote)
                        .foregroundColor(Color.primaryGreen500)
                        .position(x: numberPosition(for: number, in: geometry.size.width), y: 40) // Adjust the y position as needed
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(height: 16) // Adjust height for the slider
    }

    // Calculate the active track width based on the value
    private func activeTrackWidth(in totalWidth: CGFloat) -> CGFloat {
        let percentage = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
        return totalWidth * percentage
    }

    // Calculate thumb position based on value
    private func thumbPosition(in width: CGFloat) -> CGFloat {
        let percentage = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
        return (width * percentage) - 12 // Center the thumb
    }

    // Calculate value from drag location
    private func value(for locationX: CGFloat, in width: CGFloat) -> Double {
        let percentage = Double(locationX / width)
        let newValue = range.lowerBound + (range.upperBound - range.lowerBound) * percentage
        let clampedValue = max(range.lowerBound, min(range.upperBound, newValue)) // Ensure the value is within range
        return round(clampedValue / step) * step // Snap to step
    }

    // Calculate the x position of the number based on its index
    private func numberPosition(for number: Int, in width: CGFloat) -> CGFloat {
        let totalNumbers = 5 // Number of labels
        let stepWidth = width / CGFloat(totalNumbers - 1) // Calculate width for each step
        return CGFloat(number - 1) * stepWidth // Position each number based on its index
    }
}
