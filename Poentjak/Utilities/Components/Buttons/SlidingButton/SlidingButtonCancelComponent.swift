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
    case ltr1 = 0.9
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
    var buttonColor: Color
    
    @State var actionState: ActionState = .initial
    @State private var width: CGFloat = 70
    @State private var dragCompleted: Bool = false
    
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
                    if actionState == .initial && dragCompleted {
                        actionState = .loading
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            actionState = .finish
                            onActionCompleted()
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
                alignment: (slidingDirection == .ltr || slidingDirection == .ltr1) ? .trailing : .leading
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
                            onActionCompleted()
                        }
                    }
            )
            .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0), value: width)
    }
}

struct BackgroundView: View {
    let slidingDirection: SlidingDirection
    var text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(Color.white)
            .customShadow()
            .overlay(
                HStack {
                    if slidingDirection == .ltr {
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray.opacity(0.5))
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray.opacity(0.7))
                        Spacer()
                        Text(text)
                            .foregroundColor(Color.primaryGreen500)
                            .font(Font.title3Regular)
                    }else if slidingDirection == .ltr1 {
                        Spacer()
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray.opacity(0.9))
                            .bold()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray.opacity(0.7))
                            .bold()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .bold()
                        Spacer()
                        Text(text)
                            .foregroundColor(Color.primaryGreen500)
                            .font(Font.title3Regular)
                        Spacer()
                    }
                    else {
                        Text(text)
                            .foregroundColor(Color.primaryGreen500)
                            .font(Font.title3Regular)
                        Spacer()
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.gray.opacity(0.5))
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.gray.opacity(0.7))
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
    var trailingIcon: String = "checkmark"
    var text: String
    var onActionCompleted: () -> Void
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: (slidingDirection == .ltr || slidingDirection == .ltr1) ? .leading : .trailing) {
                BackgroundView(slidingDirection: slidingDirection, text: text)
                
                DraggableView(
                    maxDraggableWidth: geometry.size.width,
                    slidingDirection: slidingDirection,
                    leadingView: Image(systemName: slidingDirection == .ltr || slidingDirection == .ltr1 ? "arrowshape.right.fill" : "arrowshape.left.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white),
                    trailingView: Image(systemName: trailingIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white),
                    buttonColor: slidingDirection == .ltr || slidingDirection == .ltr1 ? Color.primaryGreen500 : Color.accentRedSos,
                    onActionCompleted: onActionCompleted
                )
            }
        }
        .frame(height: 70)
    }
}

#Preview {
    SlideToActionButton(
        slidingDirection: .rtl, text: "Slide to cancel", onActionCompleted: {
            print("Cancel action completed")
        }
    )
    .padding(.horizontal, 25)
    
    SlideToActionButton(
        slidingDirection: .ltr, text: "Finished evacuating", onActionCompleted: {
            print("Finish action completed")
        }
    )
    SlideToActionButton(
        slidingDirection: .ltr1, text: "Finish trip", onActionCompleted: {
            print("Finish action completed")
        }
    )
    .padding(.horizontal, 25)
}
