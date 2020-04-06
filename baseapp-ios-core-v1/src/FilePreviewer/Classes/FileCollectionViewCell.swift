//
//  FileCollectionViewCell.swift
//  FilePreviewer
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import UIKit

class FileCollectionViewCell: UICollectionView.BaseCell {
    @IBOutlet private(set) var thumbnailImageView: UIImageView!
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var subtitleLabel: UILabel!
}
