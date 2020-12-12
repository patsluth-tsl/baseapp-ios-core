//
//  UITableView+BaseCell.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

#if os(iOS)

extension UITableView {
    open class BaseHeaderFooterView: UITableViewHeaderFooterView {
        public private(set) var disposeBag = DisposeBag()
        
        open override func prepareForReuse() {
            disposeBag = DisposeBag()
            
            super.prepareForReuse()
        }
    }
}

#endif
