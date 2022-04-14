import UIKit

class MemeViewController: UIViewController {

    private let viewModel = MemeViewModel()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var editorView: UIView!

    @IBOutlet weak var heightEditorConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthEditorConstraint: NSLayoutConstraint!

    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!

    private var memedImage: UIImage?
    static var activeTextField: UITextField? = nil

    private lazy var textFieldDelegate = TextFieldDelegate(viewModel: viewModel)
    private lazy var imagePicker = ImagePickerDelegate { [weak self] image in
        self?.editorView.isHidden = false
        self?.imageView.image = image
        self?.shareButton.isEnabled = true
        self?.imageView.contentMode = .scaleAspectFit

        guard let bottomField = self?.bottomField else { return }
        guard let topField = self?.topField else { return }

        self?.configureText(field: bottomField, enable: true)
        self?.configureText(field: topField, enable: true)
        self?.fitImageViewIfNeeded()

    }
// MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureText(field: topField)
        configureText(field: bottomField)
        editorView.isHidden = true
        shareButton.isEnabled = false
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)

        subscribeToWillShowNotifications()
        subscribeToWillHideNotifications()
        hideTabBar(visable: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fitImageViewIfNeeded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        hideTabBar(visable: false)
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

    @IBAction func cancelMeme(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func shareMeme(_ sender: Any) {
        memedImage = viewModel.renderImage(from: editorView)
       
        let ac = UIActivityViewController(activityItems: [memedImage!],
                                          applicationActivities: nil)

        ac.completionWithItemsHandler = { _, completed, _, _ in
            if completed {
                self.save()
                self.editorView.isHidden = true
                self.dismiss(animated: true)
            }
        }
        present(ac, animated: true)
    }

    @IBAction func deleteMeme(_ sender: Any) {
        editorView.isHidden = true
        shareButton.isEnabled = false
    }
    //MARK: - Private functions
    private func configureText(field: UITextField, enable: Bool = false) {
        field.delegate = textFieldDelegate
        field.defaultTextAttributes = viewModel.memeTextAttributes
        field.textAlignment = .center
        field.isEnabled = enable
        field.text = viewModel.defaultText
    }

    private func save() {

        let topText = topField.text ?? ""
        let bottomText = bottomField.text ?? ""

        let meme = Meme(topText: topText, bottomText: bottomText, originalImage: imageView.image!, memedImage: memedImage!)

        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)

        shareButton.isEnabled = false
    }

    private func fitImageViewIfNeeded() {
        guard let image = imageView.image else { return }
        let safeAreaSize = view.safeAreaLayoutGuide.layoutFrame.size
        let bars: CGFloat = 120
        let maxHeight = safeAreaSize.height - bars
        let maxWidth = safeAreaSize.width

        let imageSize = image.size
        let ratio = imageSize.width / imageSize.height

        var newHeight = 0.0
        var newWidth = 0.0

        let isPortraitImage = ratio >= 1
        let isOrientationLandscape = safeAreaSize.width > safeAreaSize.height

        if isOrientationLandscape {
            newHeight = maxHeight
            newWidth = maxHeight * ratio
        } else {
            newHeight = isPortraitImage ? maxWidth / ratio : maxHeight
            newWidth = isPortraitImage ? maxWidth : maxHeight * ratio
        }

        heightEditorConstraint.constant = newHeight
        widthEditorConstraint.constant = newWidth
    }

    private func hideTabBar(visable: Bool) {
        tabBarController?.tabBar.isHidden = visable
    }
}
