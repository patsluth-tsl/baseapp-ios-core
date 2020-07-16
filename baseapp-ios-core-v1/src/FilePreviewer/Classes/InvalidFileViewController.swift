//
//  PDFViewController.swift
//  FilePreviewer
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import PDFKit
import QuickLook
import UIKit

@available(iOS 11.0, *)
internal class InvalidFileViewController: FileViewController {
	@IBOutlet fileprivate var label: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(
            nibName: "InvalidFileViewController",
            bundle: Bundle(for: InvalidFileViewController.classForCoder())
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		label.text = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	}
	
	override func didMove(toParent parent: UIViewController?) {
		super.didMove(toParent: parent)
		
		guard let fileURL = fileURL else {
			label.text = "Invalid file"
			return
		}
		
        if fileURL.isReachable {
            label.text = "No preview available for \(fileURL.pathExtension) files"
        } else {
            label.text = "\(fileURL.fileNameFull) does not exist"
        }
	}
}
