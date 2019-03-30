//
//  DetailViewController.swift
//  ScaleAppPrototype
//
//  Created by Grey Patterson on 3/29/19.
//  Copyright © 2019 Grey Patterson. All rights reserved.
//

import UIKit
import BLTNBoard

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    lazy var bulletinManager: BLTNItemManager = {
        let rootItem = BLTNPageItem(title: "New Weight")
        rootItem.descriptionText = "156.02 pounds\n8.6% body fat"
        rootItem.actionButtonTitle = "Save"
        rootItem.alternativeButtonTitle = "Don't Save"
        let color = UIColor.init(named: "Yellow-Center")!
        rootItem.appearance.actionButtonColor = color
        rootItem.appearance.titleTextColor = color
        rootItem.appearance.alternativeButtonTitleColor = color
        rootItem.actionHandler = { (item: BLTNActionItem) in
            item.manager?.dismissBulletin(animated: true)
        }
        rootItem.alternativeHandler = { (item: BLTNActionItem) in
            item.manager?.dismissBulletin(animated: true)
        }
        return BLTNItemManager(rootItem: rootItem)
    }()
    
    // https://stackoverflow.com/questions/33503531/detect-shake-gesture-ios-swift
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            bulletinManager.showBulletin(above: self)
        }
    }



    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

