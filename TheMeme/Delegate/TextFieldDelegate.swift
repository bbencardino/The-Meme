import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {

    var viewModel = MemeViewModel()

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == viewModel.topDefaultText || textField.text == viewModel.bottomDefaultText {
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
