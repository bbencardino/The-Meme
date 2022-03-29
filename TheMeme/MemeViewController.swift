//
//  ViewController.swift
//  TheMeme
//
//  Created by Isabella Bencardino on 23/03/2022.
//

import UIKit

class MemeViewController: UIViewController {

    @IBOutlet weak var editorView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func addButton(_ sender: Any) {
    }
    

    @IBAction func saveButton(_ sender: Any) {}
}

