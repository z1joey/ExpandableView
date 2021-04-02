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
        trayMaxHeight = 600
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
                let blueViewY = heightConstraint.constant - (child?.blueView?.frame.height)!

                if greenViewY < trayOriginalHeight {
                    child?.greenView?.frame.origin.y = greenViewY
                }

                child?.blueView?.frame.origin.y = blueViewY
            }
        } else if sender.state == UIGestureRecognizer.State.ended {
            let velocity = sender.velocity(in: view)
            var greenViewY: CGFloat = -100
            var blueViewY: CGFloat = -200

            switch heightConstraint.constant {
            case let x where x > trayExpandedHeight:
                if velocity.y > 0 {
                    heightConstraint.constant = trayMaxHeight
                    blueViewY = trayExpandedHeight
                } else {
                    heightConstraint.constant = trayExpandedHeight
                    blueViewY = trayExpandedHeight - (child?.blueView?.frame.height)!
                }
                greenViewY = trayOriginalHeight
            case let x where x > trayOriginalHeight && x < trayExpandedHeight:
                if velocity.y > 0 {
                    heightConstraint.constant = trayExpandedHeight
                    greenViewY = trayOriginalHeight
                    blueViewY = trayExpandedHeight - (child?.blueView?.frame.height)!
                } else {
                    heightConstraint.constant = trayOriginalHeight
                    greenViewY = -100
                    blueViewY = trayOriginalHeight - (child?.blueView?.frame.height)!
                }
            default:
                break
            }

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
                self.child?.greenView?.frame.origin.y = greenViewY
                self.child?.blueView?.frame.origin.y = blueViewY
            } completion: { completed in
                print("completed")
            }
        }
    }
}
