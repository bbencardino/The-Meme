import UIKit

class MemeViewController: UIViewController {

    private let viewModel = MemeViewModel()

    @IBOutlet weak var editorView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!

    static var activeTextField: UITextField? = nil
    
    private lazy var textFieldDelegate = TextFieldDelegate(viewModel: viewModel)
    private lazy var imagePicker = ImagePickerDelegate { [weak self] image in
        self?.imageView.image = image
        self?.imageView.contentMode = .scaleAspectFill

        self?.topField.text = self?.viewModel.topDefaultText
        self?.bottomField.text = self?.viewModel.bottomDefaultText
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureText(field: topField)
        configureText(field: bottomField)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        subscribeToWillShowNotifications()
        subscribeToWillHideNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

//        unsubscribeFromKeyboardNotifications()
//        unsubscribeToWillHideNotifications()
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

    private func configureText(field: UITextField) {
        field.delegate = textFieldDelegate
        field.defaultTextAttributes = viewModel.memeTextAttributes
        field.textAlignment = .center
    }
}
