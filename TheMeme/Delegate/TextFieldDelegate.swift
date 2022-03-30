import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {

    let topDefaultText = "TOP TEXT"
    let BottomDefaultText = "BOTTOM TEXT"

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == topDefaultText || textField.text == BottomDefaultText {
            textField.text = ""
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
