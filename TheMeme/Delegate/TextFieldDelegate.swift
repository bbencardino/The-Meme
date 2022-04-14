import UIKit

final class TextFieldDelegate: NSObject, UITextFieldDelegate {

    private let viewModel: MemeViewModel

    init(viewModel: MemeViewModel) {
        self.viewModel = viewModel
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        MemeViewController.activeTextField = textField

        if textField.text == viewModel.defaultText {
            textField.text = ""
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        MemeViewController.activeTextField = nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = textField.text ?? ""
        textField.text = (text as NSString).replacingCharacters(in: range,
                                                                with: string.uppercased())
        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
