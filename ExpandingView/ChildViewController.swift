//
//  ChildViewController.swift
//  ExpandingView
//
//  Created by joey on 4/2/21.
//

import UIKit

class ChildViewController: UIViewController {
    @IBOutlet weak var redView: UIView!

    var greenView: UICollectionView?
    var blueView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        layout.sectionInset.left = 20
        layout.sectionInset.right = 20

        greenView = UICollectionView(frame: CGRect(x: 0, y: -100, width: view.frame.width, height: 200), collectionViewLayout: layout)
        greenView?.dataSource = self
        greenView?.delegate = self
        greenView?.backgroundColor = .green
        greenView?.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "Cell")

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

extension UIViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        if let cell = cell as? CustomCell {
            cell.nameLabel.text = "\(indexPath)"
        }

        return cell
    }
}
