import UIKit

class MemeViewModel {

    var didTopTextFieldBeginEditing = false
    var didBottomTextFieldBeginEditing = false

    let defaultText = "TEXT"
    let memeTextAttributes: [NSAttributedString.Key: Any] = [.strokeColor: UIColor.black,
                                                             .foregroundColor: UIColor.white,
                                                             .font: UIFont(name: "HelveticaNeue-CondensedBlack",size: 40)!,
                                                             .strokeWidth: -5]

    //MARK: - Meme genenator
    func renderImage(from view: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }
    }
}
