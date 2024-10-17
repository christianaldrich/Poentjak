//
//  SlidingButton-Cancel-Component.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 14/10/24.
//

import SwiftUI

enum ActionState {
    case initial
    case loading
    case finish
}

enum SlidingDirection: CGFloat {
    case ltr = 1
    case rtl = -1
}

private struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(1)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .animation(.default, value: configuration.isPressed)
    }
}

struct DraggableView<LeadingView: View, TrailingView: View>: View {
    
    let maxDraggableWidth: CGFloat
    let slidingDirection: SlidingDirection
    
    let leadingView: LeadingView
    let trailingView: TrailingView
    
    // New property for button color
    var buttonColor: Color = Color.red
    
    @State var actionState: ActionState = .initial
    @State private var width: CGFloat = 70
    
    private let minWidth: CGFloat = 70
    private let imagePadding: CGFloat = 4
    private let buttonDiameter: CGFloat = 58 // Set diameter for the button
    
    var body: some View {
        let opacity: Double = (width / maxDraggableWidth)
        
        // Set background color to red and overlay with white
        RoundedRectangle(cornerRadius: 50)
            .fill(buttonColor) // Use red background
            .padding(4)
            .frame(width: width)
            .overlay(
                Button(action: {
                    if actionState == .initial {
                        actionState = .loading
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            actionState = .finish
                        }
                    }
                }, label: {
                    switch actionState {
                    case .initial:
                        leadingView // Ensure leadingView is colored correctly
                            .foregroundColor(.white) // Set leading view color to white
                    case .loading:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white)) // Use white for loading indicator
                    case .finish:
                        trailingView
                    }
                })
                .buttonStyle(CustomButtonStyle())
                .disabled(actionState != .initial)
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .foregroundColor(.white) // Ensure button text is white
                .frame(width: buttonDiameter, height: buttonDiameter) // Circle button
                    .background(
                        Circle()
                            .fill(Color.red) // Red background for button
                    )
                    .padding(.all, imagePadding),
                alignment: (slidingDirection == .ltr) ? .trailing : .leading
            )
            .highPriorityGesture(
                DragGesture()
                    .onChanged { value in
                        guard actionState == .initial else { return }
                        
                        // Calculate new width based on translation
                        if slidingDirection == .rtl {
                            let newWidth = max(minWidth, min((value.translation.width * slidingDirection.rawValue * 5) + minWidth, maxDraggableWidth))
                            width = max(min(newWidth, maxDraggableWidth), minWidth) // Right to Left
                        } else {
                            if value.translation.width * slidingDirection.rawValue > 0 {
                                width = min((value.translation.width * slidingDirection.rawValue) + minWidth, maxDraggableWidth)
                            }
                        }
                    }
                    .onEnded { _ in
                        guard (actionState == .initial) else { return }
                        
                        if width < maxDraggableWidth {
                            width = minWidth
                            return
                        }
                        withAnimation(.spring().delay(0.5)) {
                            actionState = .loading
                        }
                        
                        // Simulate doing something by transitioning to the finish state
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            actionState = .finish
                        }
                    }
            )
            .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0), value: width)
    }
}

struct BackgroundView: View {
    let slidingDirection: SlidingDirection
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(Color.white)
            .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 4)
            .overlay(
                HStack {
                    
                    Spacer()
                    Spacer()
                    Image(systemName: (slidingDirection == .ltr) ? "chevron.right" : "chevron.left.2")
                        .foregroundColor(Color.gray.opacity(0.5)) // Gray for first chevron
                    Image(systemName: (slidingDirection == .ltr) ? "chevron.right" : "chevron.left.2")
                        .foregroundColor(Color.gray.opacity(0.7)) // Slightly lighter gray for second
                    Spacer()
                    
                    Text(slidingDirection == .ltr ? "Finished Evacuating" : "Slide to Cancel")
                        .foregroundColor(Color.black)
                        .font(.title3)
                }
                    .padding()
                
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundStyle(Color.white.opacity(0.6)),
                alignment: .center
            )
        
    }
}

struct SlideToActionButton<LeadingView: View, TrailingView: View>: View {
    
    let slidingDirection: SlidingDirection
    
    let leadingView: LeadingView
    let trailingView: TrailingView
    
    // Add buttonColor property
    var buttonColor: Color = .red
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: (slidingDirection == .ltr) ? .leading : .trailing) {
                BackgroundView(slidingDirection: slidingDirection)
                DraggableView(maxDraggableWidth: geometry.size.width,
                              slidingDirection: slidingDirection,
                              leadingView: leadingView,
                              trailingView: trailingView,
                              buttonColor: buttonColor) // Pass the buttonColor
            }
        }
        .frame(height: 70)
    }
}

#Preview {
    return SlideToActionButton(
        slidingDirection: .rtl,
        leadingView: Image(systemName: "xmark")
            .resizable() // Make the image resizable
            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
            .frame(width: 30, height: 30) // Set the size of the "X" icon
            .foregroundColor(.white), // Set the X button color to white
        trailingView: Image(systemName: "checkmark"),
        buttonColor: .red // Set button color to red
    )
    .padding(.horizontal, 25)
}
