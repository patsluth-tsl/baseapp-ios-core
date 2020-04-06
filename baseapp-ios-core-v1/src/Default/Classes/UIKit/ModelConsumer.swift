//
//  ModelConsumer.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import UIKit

public protocol ModelConsumer {
	associatedtype Model
	
	var model: Model! { get set }
}

//public typealias ModelViewController = UIViewController & ModelConsumer
//public typealias ModelView = UIView & ModelConsumer
public protocol ModelViewController: ModelConsumer
	where Self: UIViewController {
}

public extension ModelConsumer
	where Self: NSObject {
}

public protocol ModelView: ModelConsumer
	where Self: UIView {
}

public extension UITableView {
	typealias ModelCell = UITableViewCell & ModelView
	//	typealias SelectableModelCell = UITableView.ModelCell & SelectableModelViewProtocol
}

public extension UICollectionView {
	typealias ModelCell = UICollectionViewCell & ModelView
	//	typealias SelectableModelCell = UICollectionView.ModelCell & SelectableModelViewProtocol
}
