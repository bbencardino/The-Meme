import UIKit

class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //the parameter is the result(image) when the image is picked
    let onCompletion: (UIImage)->()

    init(onCompletion: @escaping (UIImage)->()) {
        self.onCompletion = onCompletion
    }

    func choose(from source: UIImagePickerController.SourceType,
                with controller: UIImagePickerController) {
        controller.delegate = self
        controller.sourceType = source
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[.originalImage] as? UIImage {
            onCompletion(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
