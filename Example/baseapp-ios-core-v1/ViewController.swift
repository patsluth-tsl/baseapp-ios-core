//
//  ViewController.swift
//  baseapp-ios-core-v1
//
//  Created by patsluth on 01/15/2020.
//  Copyright (c) 2020 patsluth. All rights reserved.
//

import baseapp_ios_core_v1
import QuickLook
import UIKit

class ViewController: UIViewController {
    fileprivate var fileURLs = [URL]()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.fileURLs.removeAll()
        
        guard let resourceURL = Bundle.main.resourceURL else { return }
        
        guard let fileURLs = try? FileManager.default.contentsOfDirectory(
            at: resourceURL,
            includingPropertiesForKeys: nil,
            options: [
                .skipsHiddenFiles,
                .skipsSubdirectoryDescendants
            ]
        ) else { return }
        
        self.fileURLs = fileURLs.filter({
            FilePreviewer.canPreview(fileURL: $0)
        })
        
//        if #available(iOS 11.0, *) {
//            PDFFileViewController.make({
//                $0.fileURL = self.fileURLs.first!
//            }).map({
//                UINavigationController(rootViewController: $0)
//            })
//                .present(from: self)
//        }
        FilePreviewer.preview(from: self,
                              initialIndexPath: IndexPath(item: 0, section: 0))
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}


extension ViewController: FilePreviewerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return fileURLs.count
    }
    
    func previewController(_ controller: QLPreviewController,
                           previewItemAt index: Int) -> QLPreviewItem {
        return fileURLs[index] as NSURL
    }
    
    func previewItem(at indexPath: IndexPath) -> QLPreviewItem {
        return fileURLs[indexPath.item] as NSURL
    }
}


extension ViewController: FilePreviewerDelegate {
//    func previewController<T>(_ controller: QLPreviewController,
//                              styleProviderType type: T.Type) -> UIBarStyleProvider?
//        where T : UINavigationBar
//    {
//        return UINavigationBar.appearance()
//    }
//
//    func previewController<T>(_ controller: QLPreviewController,
//                              styleProviderType type: T.Type) -> UIBarStyleProvider?
//        where T : UIToolbar
//    {
//        return UIToolbar.appearance()
//    }
}
