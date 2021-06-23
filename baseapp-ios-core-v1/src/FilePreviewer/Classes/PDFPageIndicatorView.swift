//
//  PDFPageIndicatorView.swift
//  FilePreviewer
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation
import PDFKit
import RxCocoa
import RxSwift
import RxSwiftExt
import UIKit

@available(iOS 11.0, *)
internal class PDFPageIndicatorView: UIVisualEffectView {
    @IBOutlet private var label: UILabel!
    
    private var disposeBag = DisposeBag()
    
    weak var pdfView: PDFView? = nil {
        didSet {
            disposeBag = DisposeBag()
            
            guard let newValue = pdfView else { return }
            
            newValue.rx.observe(Int.self,
                                #keyPath(PDFView.scrolledPageIndex),
                                options: [.initial, .new],
                                retainSelf: true)
                .asDriver(onErrorJustReturn: .zero)
                .unwrap()
                .drive(onNext: { [weak self] pageIndex in
                    guard let `self` = self else { return }
                    guard self.pdfView != nil else { return }
                    self.fadeInAnimation = nil
                    self.fadeOutAnimation = nil
                    
                    self.label.text = "\(pageIndex + 1) of \(self.pdfView!.pageCount)"
                    
                    let duration = TimeInterval(
                        self.alpha.percentage(between: 0.0, and: 1.0)
                            .value(percentageBetween: 0.0, and: 0.4)
                    )
                    let curve = UIView.AnimationCurve.linear
                    
                    self.fadeInAnimation = UIViewPropertyAnimator(
                        duration: TimeInterval(duration),
                        curve: curve,
                        animations: {
                            self.alpha = 1.0
                    })
                    self.fadeOutAnimation = UIViewPropertyAnimator(
                        duration: 0.4,
                        curve: curve,
                        animations: {
                            self.alpha = 0.0
                    })
                    
                    self.fadeInAnimation?.addCompletion({ [weak self] _ in
                        self?.fadeOutAnimation?.startAnimation(afterDelay: 2.5)
                    })
                    self.fadeInAnimation?.startAnimation()
                })
                .disposed(by: disposeBag)
        }
    }
    
    private var fadeInAnimation: UIViewPropertyAnimator? = nil {
        didSet {
            oldValue?.stopAnimation(true)
        }
    }
    
    private var fadeOutAnimation: UIViewPropertyAnimator? = nil {
        didSet {
            oldValue?.stopAnimation(true)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 7.0
        layer.masksToBounds = true
        alpha = 0.0
    }
}
