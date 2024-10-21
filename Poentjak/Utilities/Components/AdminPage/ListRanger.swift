//
//  ListRanger.swift
//  Poentjak
//
//  Created by Felicia Himawan on 20/10/24.
//

import SwiftUI

enum ListRangerType {
case checkbox(inRescue: Bool, onToggle: () -> Void)
case edit(isEditing: Bool, rangerName: String, onDelete: () -> Void, onUpdate: ((String) -> Void)?) // Optional onUpdate for edit mode
}

struct ListRanger: View {
    var rangerName: String
    var type: ListRangerType
    
    @State private var isSelected: Bool = false
    
    var body: some View {
        HStack {
            switch type {
                
            case .checkbox(let inRescue, let onToggle):
                Text(rangerName)
                    .font(isSelected ? .calloutEmphasized : .calloutRegular)
                    .foregroundColor(isSelected ? Color.primaryGreen500 : Color.neutralBlack)
                
                if inRescue {
                    CustomLabelStatus(type: .inRescue)
                }
                
                Spacer()
                
                Button(action: {
                    isSelected.toggle()
                    onToggle()
                }) {
                    if isSelected {
                        Image.AdminIcon.checkboxChecked
                    } else {
                        Image.AdminIcon.checkboxUnchecked
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                
            case .edit(let isEditing, let rangerName, let onDelete, let onUpdate):
                if isEditing {
                    TextField("Ranger Name", text: Binding(
                        get: { rangerName },
                        set: { newName in
                            onUpdate?(newName)
                        })
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(0)
//                    .background(.red)
                    
                    Spacer()
                    
                    Button(action: {
                        onDelete()
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(Color.errorRed500)
                    }
                } else {
                    Text(rangerName)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        onDelete()
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(Color.errorRed500)
                    }
                }
            }
        }
        .padding(paddingForType())
        .frame(width: 340, alignment: .leading)
//        .background(Color(.systemGray6))
    }
    
    private func paddingForType() -> CGFloat {
            switch type {
            case .checkbox:
                return 8 // Add 8 points padding for checkbox case
            case .edit(let isEditing, _, _, _):
                return isEditing ? 0 : 8 // No padding in edit mode with TextField, 8 for regular view
            }
        }
}

#Preview {
    ListRanger(rangerName: "Ranger 1", type: .checkbox(inRescue: false, onToggle: { print("Toggled Ranger 1") }))
    
    ListRanger(rangerName: "Ranger 2", type: .checkbox(inRescue: true, onToggle: { print("Toggled Ranger 1") }))

    
    ListRanger(rangerName: "Ranger 3", type: .edit(isEditing: true, rangerName: "Ranger 2", onDelete: { print("Delete Ranger 2") }, onUpdate: { newName in print("Updated Ranger 2 to \(newName)") }))
    
    ListRanger(rangerName: "Ranger 4", type: .edit(isEditing: false, rangerName: "Ranger 3", onDelete: { print("Delete Ranger 3") }, onUpdate: nil))
}
