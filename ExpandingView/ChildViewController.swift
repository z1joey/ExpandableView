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
    var blueView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        greenView = UIView(frame: CGRect(x: 0, y: -100, width: view.frame.width, height: 200))
        greenView?.backgroundColor = .green

        blueView = UIView(frame: CGRect(x: 0, y: -200, width: view.frame.width, height: 300))
        blueView?.backgroundColor = .blue
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(greenView!)
        view.addSubview(blueView!)
        view.bringSubviewToFront(greenView!)
        view.bringSubviewToFront(redView)
    }
}
