import UIKit

class MemeViewController: UIViewController {

    var viewModel = MemeViewModel()

    @IBOutlet weak var editorView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        topField.defaultTextAttributes = viewModel.memeTextAttributes
        bottomField.defaultTextAttributes = viewModel.memeTextAttributes

        topField.delegate = viewModel.textFieldDelegate
        bottomField.delegate = viewModel.textFieldDelegate

        topField.text = viewModel.topText
        bottomField.text = viewModel.bottomText
    }

    @IBAction func addButton(_ sender: Any) {}
    @IBAction func saveButton(_ sender: Any) {}
}

