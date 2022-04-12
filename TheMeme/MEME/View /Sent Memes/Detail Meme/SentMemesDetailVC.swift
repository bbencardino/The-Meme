import UIKit

class SentMemesDetailViewController: UIViewController {

    var memes: Meme!

    @IBOutlet weak var detailImage: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        detailImage.image = memes.memedImage
        hideTabBar(visable: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        hideTabBar(visable: false)
    }

    private func hideTabBar(visable: Bool) {
        tabBarController?.tabBar.isHidden = visable
    }
}
