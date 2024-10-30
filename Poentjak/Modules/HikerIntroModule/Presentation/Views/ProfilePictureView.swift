//
//  ProfilePictureView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 29/10/24.
//

import SwiftUI
import PhotosUI

struct ProfilePictureView: View {
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    
    @StateObject var viewModel: HikerRegisViewModel
    @State private var isNextViewActive = false // Control navigation

//    @StateObject var authViewModel: AuthViewModel
    
    
    var body: some View {
        VStack {
            Spacer()
//            CustomIndicatorLongRectangle(totalCount: 4, currentIndex: viewModel.currentIndex ?? 1)
            Spacer()
            VStack(alignment: .leading){
                Text("Give us a selfie!")
                    .font(.title3Emphasized)
                Text("We need your profile picture to help rescuers\nidentify you quickly in an emergency!")
                    .font(.subheadlineRegular)
            }
            
//            Text("\(String(describing: viewModel.capturedImage))")
//            PhotoComponent()
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    if let selectedImage = viewModel.capturedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(width: 296, height: 296)
                        
                    }
                }
                
                if viewModel.capturedImage == nil {
                    VStack{
                        
    //                    Text("\(String(describing: viewModel.capturedImage))")
                        
                        TakePhotoComponent {
                            self.showCamera.toggle()
                            
                        }
                        .fullScreenCover(isPresented: self.$showCamera) {
                            accessCameraView(viewModel: viewModel)
                                .background(.black)
                        }
                    }
                } else {
                    
                    VStack{
    //                    Text("\(String(describing: viewModel.capturedImage))")
                        RetakePhotoComponent {
                            self.showCamera.toggle()
                        }
                        .padding(.bottom, -25)
                        .padding(.trailing, 10)
                        .fullScreenCover(isPresented: self.$showCamera) {
                            accessCameraView(viewModel: viewModel)
                                .background(.black)
                        }
                        
    //                    Text("Testing")
                    }
                    
                }
            }
            
            Spacer()
            
//            Text("\(String(describing: viewModel.fullName))")
//            Text("\(String(describing: selectedImage))")
//            NavigationLink(destination: NextTempView()){
            CustomLargeButtonComponent(state: (viewModel.capturedImage == nil) ? .disabled : .enabled, text: "Next") {
//                    viewModel.storeCurrentProfilePicture(capturedImage: selectedImage!)
                viewModel.updateCurrentIndex(currentIndex: (viewModel.currentIndex ?? 1 ) + 1)
                    isNextViewActive = true
                }
                
//                .allowsHitTesting(false)
//            }
            .disabled(viewModel.capturedImage == nil)
            
            
            
            
        }
        .navigationDestination(isPresented: $isNextViewActive){
            NextTempView(viewModel: viewModel)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    viewModel.currentIndex = (viewModel.currentIndex ?? 0) - 1
                }
            }
        }
        
    }
}

struct accessCameraView: UIViewControllerRepresentable {
    
//    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    @ObservedObject var viewModel: HikerRegisViewModel // Use @ObservedObject to observe the view model

    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .front
        imagePicker.cameraFlashMode = .off
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        //        print("\n\n\nIMAGEPICKER: \(imagePicker)")
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self, viewModel: viewModel)
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    var viewModel: HikerRegisViewModel

    
    init(picker: accessCameraView, viewModel: HikerRegisViewModel) {
        self.picker = picker
        self.viewModel = viewModel

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
//        self.picker.selectedImage = selectedImage
        self.viewModel.capturedImage = selectedImage // Update the view model's captured image
//        print("Image: \(String(describing: self.viewModel.capturedImage))")
        self.viewModel.storeCurrentProfilePicture(capturedImage: selectedImage)
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

//#Preview {
////    ProfilePictureView(authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
//    ProfilePictureView()
//}
