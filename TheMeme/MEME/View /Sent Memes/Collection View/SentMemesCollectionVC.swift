import UIKit

class SentMemesCollectionVC: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    private var memes: [Meme]! {
         let object = UIApplication.shared.delegate
         let appDelegate = object as! AppDelegate
         return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let space: CGFloat = 3
        let dimension = (view.frame.size.width - (2 * space)) / space

        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
        print(memes.count)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memes.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! SentMemesCollectionViewCell
        let meme = memes[indexPath.row]
        cell.topText.text = meme.topText
        cell.gridImage.image = meme.memedImage
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //instantiate a view controller
        let detailVC = navigationController?.storyboard?.instantiateViewController(withIdentifier: "SentMemesDetailViewController") as! SentMemesDetailViewController

        //send the memes to the view controller
        detailVC.memes = memes[indexPath.row]

        //push the view controller
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
