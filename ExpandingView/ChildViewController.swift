//
//  ChildViewController.swift
//  ExpandingView
//
//  Created by joey on 4/2/21.
//

import UIKit

class ChildViewController: UIViewController {
    @IBOutlet weak var redView: UIView!

    var greenView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        greenView = UIView(frame: CGRect(x: 0, y: -100, width: view.frame.width, height: 200))
        greenView?.backgroundColor = .green
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(greenView!)
        view.bringSubviewToFront(redView)
    }
}
