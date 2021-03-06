import UIKit

class SentMemesTableVC: UITableViewController {

   private var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTableCell", for: indexPath)

        let meme = memes[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Kefa Regular", size: 18)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.textLabel?.text = meme.topText
        cell.imageView?.image = meme.memedImage

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memes.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // instantiate the view controller
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "SentMemesDetailViewController") as! SentMemesDetailViewController

        // send the selected meme to the view controller
        detailVC.memes = memes[indexPath.row]

        // push the view controller
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
