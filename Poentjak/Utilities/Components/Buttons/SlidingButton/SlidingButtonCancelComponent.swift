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
    var buttonColor: Color = Color.red
    
    @State var actionState: ActionState = .initial
    @State private var width: CGFloat = 70
    @State private var dragCompleted: Bool = false
    
    // New property for the action closure
    var onActionCompleted: () -> Void
    
    private let minWidth: CGFloat = 70
    private let imagePadding: CGFloat = 4
    private let buttonDiameter: CGFloat = 58
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(buttonColor)
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
                        leadingView
                            .foregroundColor(.white)
                    case .loading:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    case .finish:
                        trailingView
                    }
                })
                .buttonStyle(CustomButtonStyle())
                .disabled(actionState != .initial)
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .frame(width: buttonDiameter, height: buttonDiameter)
                .background(
                    Circle()
                        .fill(buttonColor)
                )
                .padding(.all, imagePadding),
                alignment: (slidingDirection == .ltr) ? .trailing : .leading
            )
            .highPriorityGesture(
                DragGesture()
                    .onChanged { value in
                        guard actionState == .initial else { return }
                        if slidingDirection == .rtl {
                            let newWidth = max(minWidth, min((value.translation.width * slidingDirection.rawValue * 3) + minWidth, maxDraggableWidth))
                            width = max(min(newWidth, maxDraggableWidth), minWidth)
                        } else {
                            if value.translation.width * slidingDirection.rawValue > 0 {
                                width = min((value.translation.width * slidingDirection.rawValue) + minWidth, maxDraggableWidth)
                            }
                        }
                    }
                    .onEnded { _ in
                        guard actionState == .initial else { return }
                        if width < maxDraggableWidth {
                            width = minWidth
                            dragCompleted = false
                            return
                        }
                        
                        dragCompleted = true
                        withAnimation(.spring().delay(0.5)) {
                            actionState = .loading
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            actionState = .finish
                            onActionCompleted() // Call the action closure here
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
                    if slidingDirection == .ltr {
                        // LTR: Chevron > > and "Finished Evacuating" text
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray.opacity(0.5)) // First chevron
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray.opacity(0.7)) // Second chevron
                        
                        Spacer()
                        
                        Text("Finished Evacuating")
                            .foregroundColor(Color.black)
                            .font(.title3)
                    } else {
                        // RTL: Chevron < < and "Slide to Cancel" text
                        Text("Slide to Cancel")
                            .foregroundColor(Color.black)
                            .font(.title3)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.gray.opacity(0.5)) // First chevron
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.gray.opacity(0.7)) // Second chevron
                        
                        Spacer()
                    }
                }
                .padding()
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundStyle(Color.white.opacity(0.6)),
                alignment: .center
            )
    }
}

struct SlideToActionButton: View {
    
    let slidingDirection: SlidingDirection
    var buttonColor: Color = .red
    var leadingIcon: String = "xmark"
    var trailingIcon: String = "checkmark"
    
    // New property for the action closure
    var onActionCompleted: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: (slidingDirection == .ltr) ? .leading : .trailing) {
                BackgroundView(slidingDirection: slidingDirection)
                
                // Draggable view with predefined icons
                DraggableView(
                    maxDraggableWidth: geometry.size.width,
                    slidingDirection: slidingDirection,
                    leadingView: Image(systemName: leadingIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white),
                    trailingView: Image(systemName: trailingIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white),
                    buttonColor: buttonColor,
                    onActionCompleted: onActionCompleted // Pass the closure to the draggable view
                )
            }
        }
        .frame(height: 70)
    }
}


#Preview {
    SlideToActionButton(
        slidingDirection: .rtl,
        buttonColor: .red, onActionCompleted: {
            print("hi")
        } // Set button color to red
    )
    .padding(.horizontal, 25)
    
    SlideToActionButton(
        slidingDirection: .ltr,
        buttonColor: .green , onActionCompleted: {
            print("hi")
        }// Set button color to red
    )
    .padding(.horizontal, 25)
}
