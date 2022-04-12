import UIKit

extension MemeViewController {

    func subscribeToWillShowNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    func subscribeToWillHideNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    //MARK: -  Private Functions

    @objc private func keyboardWillShow(notification: NSNotification) {

        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        var shouldViewMoveUp = false

        // if active text field is not nil
        if let activeTextField = Self.activeTextField {

            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: view).maxY

            let topOfKeyboard = view.frame.height - keyboardSize.height

            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
                shouldViewMoveUp = true
            }
          }

          if(shouldViewMoveUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
          }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
