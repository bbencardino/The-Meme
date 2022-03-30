import UIKit

class MemeViewController: UIViewController {

    var viewModel = MemeViewModel()
    var textFieldDelegate = TextFieldDelegate()

    @IBOutlet weak var editorView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!

    var imagePicker: ImagePickerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        topField.defaultTextAttributes = viewModel.memeTextAttributes
        bottomField.defaultTextAttributes = viewModel.memeTextAttributes

        topField.delegate = textFieldDelegate
        bottomField.delegate = textFieldDelegate

        topField.textAlignment = .center
        bottomField.textAlignment = .center

        imagePicker = ImagePickerDelegate(onCompletion: { [weak self] image in
            self?.imageView.image = image
            self?.imageView.contentMode = .scaleAspectFill

            self?.topField.text = self?.viewModel.topDefaultText
            self?.bottomField.text = self?.viewModel.bottomDefaultText
        })
    }

    @IBAction func addButton(_ sender: Any) {

        let libraryController = UIImagePickerController()
        imagePicker.choose(from: .photoLibrary, with: libraryController)
        present(libraryController, animated: true)

//        let cameraController = UIImagePickerController()
//        imagePicker.choose(from: .camera, with: cameraController)
//        present(cameraController, animated: true)

    }

    @IBAction func saveButton(_ sender: Any) {}
}

