import UIKit

class MemeViewController: UIViewController {

    private let viewModel = MemeViewModel()

    @IBOutlet weak var editorView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!

    private var memedImage: UIImage?
    static var activeTextField: UITextField? = nil

    private lazy var textFieldDelegate = TextFieldDelegate(viewModel: viewModel)
    private lazy var imagePicker = ImagePickerDelegate { [weak self] image in
        self?.imageView.image = image
        self?.shareButton.isEnabled = true
        self?.imageView.contentMode = .scaleAspectFill

        self?.topField.text = self?.viewModel.topDefaultText
        self?.bottomField.text = self?.viewModel.bottomDefaultText
        self?.topField.isEnabled = true
        self?.bottomField.isEnabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureText(field: topField)
        configureText(field: bottomField)
        shareButton.isEnabled = false
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        subscribeToWillShowNotifications()
        subscribeToWillHideNotifications()
    }

    @IBAction func pickFromLibrary(_ sender: Any) {
        let libraryController = UIImagePickerController()
        imagePicker.choose(from: .photoLibrary, with: libraryController)
        present(libraryController, animated: true)
    }

    @IBAction func showCamera(_ sender: Any) {
        let cameraController = UIImagePickerController()
        imagePicker.choose(from: .camera, with: cameraController)
        present(cameraController, animated: true)
    }

    @IBAction func shareMeme(_ sender: Any) {
        memedImage = viewModel.renderImage(from: editorView)
        let ac = UIActivityViewController(activityItems: [memedImage!],
                                          applicationActivities: nil)
        ac.completionWithItemsHandler = { _, _, _, _ in
            self.save()
            self.cleanMemeEditorView()
        }
        present(ac, animated: true)
    }

    @IBAction func cancelMeme(_ sender: Any) {
        cleanMemeEditorView()
    }

    private func configureText(field: UITextField) {
        field.delegate = textFieldDelegate
        field.defaultTextAttributes = viewModel.memeTextAttributes
        field.textAlignment = .center
    }

    private func cleanMemeEditorView() {
        imageView.image = .none
        topField.isEnabled = false
        topField.text = ""
        bottomField.isEnabled = false
        bottomField.text = ""
        shareButton.isEnabled = false
    }

    private func save() {
        _ = Meme(topText: topField.text!, bottomText: bottomField.text!, originalImage: imageView.image!, memedImage: memedImage!)
    }
}
