//
//  PhotoComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 29/10/24.
//

import SwiftUI

struct PhotoComponent: View {
    
    @StateObject private var viewModel = HikerRegisViewModel()
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    
    var body: some View {
//        ZStack(alignment: .bottomTrailing) {
//            VStack {
//                if let selectedImage = viewModel.capturedImage {
//                    Image(uiImage: selectedImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .frame(width: 296, height: 296)
//                    
//                }
//            }
//            
//            if viewModel.capturedImage == nil {
//                VStack{
//                    
////                    Text("\(String(describing: viewModel.capturedImage))")
//                    
//                    TakePhotoComponent {
//                        self.showCamera.toggle()
//                        
//                    }
//                    .fullScreenCover(isPresented: self.$showCamera) {
//                        accessCameraView(viewModel: viewModel)
//                            .background(.black)
//                    }
//                }
//            } else {
//                
//                VStack{
////                    Text("\(String(describing: viewModel.capturedImage))")
//                    RetakePhotoComponent {
//                        self.showCamera.toggle()
//                    }
//                    .padding(.bottom, -25)
//                    .padding(.trailing, 10)
//                    .fullScreenCover(isPresented: self.$showCamera) {
//                        accessCameraView(viewModel: viewModel)
//                            .background(.black)
//                    }
//                    
////                    Text("Testing")
//                }
//                
//            }
//        }
        Text("ASDAS")
    }
}

//struct accessCameraView: UIViewControllerRepresentable {
//    
////    @Binding var selectedImage: UIImage?
//    @Environment(\.presentationMode) var isPresented
//    @ObservedObject var viewModel: HikerRegisViewModel // Use @ObservedObject to observe the view model
//
//    
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = .camera
//        imagePicker.cameraDevice = .front
//        imagePicker.cameraFlashMode = .off
//        imagePicker.allowsEditing = true
//        imagePicker.delegate = context.coordinator
//        //        print("\n\n\nIMAGEPICKER: \(imagePicker)")
//        
//        return imagePicker
//    }
//    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//        
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(picker: self, viewModel: viewModel)
//    }
//}
//
//// Coordinator will help to preview the selected image in the View.
//class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//    var picker: accessCameraView
//    var viewModel: HikerRegisViewModel
//
//    
//    init(picker: accessCameraView, viewModel: HikerRegisViewModel) {
//        self.picker = picker
//        self.viewModel = viewModel
//
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let selectedImage = info[.originalImage] as? UIImage else { return }
////        self.picker.selectedImage = selectedImage
//        self.viewModel.capturedImage = selectedImage // Update the view model's captured image
////        print("Image: \(String(describing: self.viewModel.capturedImage))")
//        self.viewModel.storeCurrentProfilePicture(capturedImage: selectedImage)
//        self.picker.isPresented.wrappedValue.dismiss()
//    }
//}

#Preview {
    PhotoComponent()
}
