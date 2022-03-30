import UIKit

struct MemeViewModel {

    let topDefaultText = "TOP TEXT"
    let bottomDefaultText = "BOTTOM TEXT"

    let memeTextAttributes: [NSAttributedString.Key: Any] = [.strokeColor: UIColor.black,
                                                             .foregroundColor: UIColor.white,
                                                             .font: UIFont(name: "HelveticaNeue-CondensedBlack",size: 40)!,
                                                             .strokeWidth: -5]
}
