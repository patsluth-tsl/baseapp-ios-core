//
//  PDFViewController.swift
//  FilePreviewer
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
public class FileViewController: UIViewController {
    public var fileURL: URL? = nil {
        didSet {
            navigationItem.title = fileURL?.fileName
        }
    }
    
    public override var shouldAutorotate: Bool {
        return true
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
    
    
    
    
    
    
    class func viewControllerClassStringFor(fileURL: URL) -> String {
        if fileURL.isPDFURL {
            return String(describing: PDFFileViewController.self)
        } else if fileURL.isVideoURL {
            return String(describing: VideoFileViewController.self)
        } else {
            return String(describing: InvalidFileViewController.self)
        }
    }
    
    class func createViewControllerFor(fileURL: URL) -> FileViewController {
        if fileURL.isPDFURL {
            return PDFFileViewController(nibName: "PDFFileViewController",
                                         bundle: Bundle(for: FileViewController.classForCoder()))
        } else if fileURL.isVideoURL {
            return VideoFileViewController(nibName: "VideoFileViewController",
                                           bundle: Bundle(for: FileViewController.classForCoder()))
        }
        
        return InvalidFileViewController(nibName: "InvalidFileViewController",
                                         bundle: Bundle(for: FileViewController.classForCoder()))
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func removeFromParent() {
        super.removeFromParent()
    }
    
    public override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
    }
}
