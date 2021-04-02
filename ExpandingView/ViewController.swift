//
//  ViewController.swift
//  ExpandingView
//
//  Created by joey on 4/1/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var trayView: UIView!

    var trayOriginalHeight: CGFloat!
    var trayExpandedHeight: CGFloat!
    var trayMaxHeight: CGFloat!
    var trayCurrentHeight: CGFloat!

    var child: ChildViewController? {
        return children.first as? ChildViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        trayOriginalHeight = 100
        trayExpandedHeight = 300
        trayMaxHeight = UIScreen.main.bounds.height
    }

    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        print("translation \(translation.y)")

        if sender.state == UIGestureRecognizer.State.began {
            trayCurrentHeight = trayView.frame.height
        } else if sender.state == UIGestureRecognizer.State.changed {
            let greaterThanOriginalHeight = (trayCurrentHeight + translation.y) > trayOriginalHeight
            let lessThanMaxHeight = (trayCurrentHeight + translation.y) < trayMaxHeight

            if greaterThanOriginalHeight && lessThanMaxHeight {
                heightConstraint.constant = trayCurrentHeight + translation.y

                let greenViewY = heightConstraint.constant - (child?.greenView?.frame.height)!

                if greenViewY < trayOriginalHeight {
                    child?.greenView?.frame.origin.y = greenViewY
                }
            }
        } else if sender.state == UIGestureRecognizer.State.ended {
            let velocity = sender.velocity(in: view)
            var greeViewY: CGFloat = -100

            switch heightConstraint.constant {
            case let x where x > trayExpandedHeight:
                if velocity.y > 0 {
                    heightConstraint.constant = trayMaxHeight
                } else {
                    heightConstraint.constant = trayExpandedHeight
                }
                greeViewY = trayOriginalHeight
            case let x where x > trayOriginalHeight && x < trayExpandedHeight:
                if velocity.y > 0 {
                    heightConstraint.constant = trayExpandedHeight
                    greeViewY = trayOriginalHeight
                } else {
                    heightConstraint.constant = trayOriginalHeight
                    greeViewY = -100
                }
            default:
                break
            }

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
                self.child?.greenView?.frame.origin.y = greeViewY
            } completion: { completed in
                print("completed")
            }
        }
    }
}
