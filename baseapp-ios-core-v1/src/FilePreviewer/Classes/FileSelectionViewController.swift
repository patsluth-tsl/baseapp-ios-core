//
//  FileSelectionViewController.swift
//  FilePreviewer
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import Kingfisher
import PDFKit
import QuickLook
import RxCocoa
import RxSwift
import RxSwiftExt
import UIKit


@available(iOS 11.0, *)
protocol FileSelectionViewControllerDelegate: class {
    func fileSelectionViewController(
        _ viewController: FileSelectionViewController,
        didSelectItemAt index: Int
    )
}


@available(iOS 11.0, *)
internal class FileSelectionViewController: UIViewController {
    @IBOutlet fileprivate var collectionView: UICollectionView!
    
    weak var delegate: FileSelectionViewControllerDelegate? = nil
    var fileURLs = [URL]()
    var initialPreviewItemIndex: Int? = nil
    
    private var dataFormatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [ByteCountFormatter.Units.useKB, ByteCountFormatter.Units.useMB]
        formatter.countStyle = ByteCountFormatter.CountStyle.file
        return formatter
    }()
    
    //    private var operations = [IndexPath: Operation]()
    //    private let operationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerCell(
            FileCollectionViewCell.self,
            nib: UINib(nibName: "FileCollectionViewCell", bundle: Bundle(for: self.classForCoder))
        )
    }
    
    @IBAction private func cancelButtonClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: - UICollectionViewDataSource
@available(iOS 11.0, *)
extension FileSelectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return fileURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeue(FileCollectionViewCell.self, for: indexPath)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
@available(iOS 11.0, *)
extension FileSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width,
            height: collectionView.bounds.height / 7.0
        )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let item = initialPreviewItemIndex {
            collectionView.scrollToItem(at: IndexPath(item: item, section: 0),
                                        at: UICollectionView.ScrollPosition.top,
                                        animated: false)
            initialPreviewItemIndex = nil
        }
        
        guard let cell = cell as? FileCollectionViewCell else { return }
        let fileURL = fileURLs[indexPath.row]
        
        cell.thumbnailImageView.image = nil
        cell.titleLabel.text = fileURL.fileName
        cell.subtitleLabel.text = dataFormatter.string(fromByteCount: fileURL.fileSize)
        
        ThumbnailGenerator.shared
            .generate(
                for: fileURL,
                processor: ResizingImageProcessor(
                    referenceSize: cell.thumbnailImageView.bounds.size,
                    mode: .aspectFit
            ))
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [unowned cell] in
                do {
                    cell.thumbnailImageView.image = try $0.get()
                    cell.thumbnailImageView.backgroundColor = nil
                } catch {
                    cell.thumbnailImageView.backgroundColor = .red
                }
            })
            .disposed(by: cell.disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        cell.prepareForReuse()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.fileSelectionViewController(self, didSelectItemAt: indexPath.item)
    }
}
