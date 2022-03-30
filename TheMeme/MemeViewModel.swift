import UIKit

struct MemeViewModel {

    let textFieldDelegate = TextFieldDelegate()
    
    lazy var topText = textFieldDelegate.topDefaultText
    lazy var bottomText = textFieldDelegate.BottomDefaultText

    let memeTextAttributes: [NSAttributedString.Key: Any] = [.strokeColor: UIColor.black,
                                                             .foregroundColor: UIColor.white,
                                                             .font: UIFont(name: "HelveticaNeue-CondensedBlack",size: 40)!,
                                                             .strokeWidth: -5]
}
