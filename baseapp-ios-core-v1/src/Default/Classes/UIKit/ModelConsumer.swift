//
//  ModelConsumer.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation
import UIKit

public protocol ModelConsumer: AnyObject {
	associatedtype Model
	
	var model: Model! { get set }
}

public protocol SelectableModelConsumer: ModelConsumer {
    associatedtype BaseModel
    typealias Model = SelectableModel<BaseModel>
}

#if os(iOS)

public protocol ModelViewController: ModelConsumer
	where Self: UIViewController {
}

public extension ModelConsumer
	where Self: NSObject {
}

public protocol ModelView: ModelConsumer
	where Self: UIView {
}

public protocol SelectableModelView: SelectableModelConsumer
    where Self: UIView {
}

public extension UITableView {
	typealias ModelCell = UITableViewCell & ModelView
	typealias SelectableModelCell = UITableViewCell & SelectableModelView
}

public extension UICollectionView {
	typealias ModelCell = UICollectionViewCell & ModelView
	typealias SelectableModelCell = UICollectionViewCell & SelectableModelView
}

#endif
