//
//  DraggingComponent.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 14/10/24.
//

import SwiftUI

struct DraggingComponent: View {
    let maxWidth: CGFloat
    private let minWidth = CGFloat(50)
    
    @State private var width = CGFloat(50)
    @Binding var isLocked: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.blue)
            .opacity(width / maxWidth)
            .frame(width: width)
            .overlay(
                ZStack {
                    image(name: "lock", isShown: isLocked)
                    image(name: "lock.open", isShown: !isLocked)
                }
                    .buttonStyle(BaseButtonStyle())
                    .disabled(!isLocked),
                alignment: .trailing
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        guard isLocked else { return }
                        // Update width based on drag
                        if value.translation.width > 0 {
                            
                            width = min(max(value.translation.width + minWidth, minWidth), maxWidth)
                        }
                    }
                    .onEnded { value in
                        guard isLocked else { return }
                        // If dragging exceeds max width, unlock
                        if width >= maxWidth {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            withAnimation(.spring().delay(0.5)) {
                                isLocked = false
                            }
                        } else {
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            withAnimation {
                                width = minWidth // Reset to minimum width
                            }
                        }
                    }
            )
            .simultaneousGesture(
                DragGesture()
            )
            .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0), value: width)
    }
    
    private func image(name: String, isShown: Bool) -> some View {
        Image(systemName: name)
            .font(.system(size: 20, weight: .regular, design: .rounded))
            .foregroundColor(Color.blue)
            .frame(width: 42, height: 42)
            .background(Circle().fill(Color.white))
            .padding(4)
            .opacity(isShown ? 1 : 0)
            .scaleEffect(isShown ? 1 : 0.01)
    }
}

#Preview {
    @State var isLocked = true
    return DraggingComponent(maxWidth: 300, isLocked: $isLocked)
}

