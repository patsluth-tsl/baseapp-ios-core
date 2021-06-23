//
//  AVCaptureVideoOrientation+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-01-30.
//  Copyright © 2018 SilverLogic. All rights reserved.
//

import AVKit
import Foundation

public extension AVCaptureVideoOrientation {
    init?(_ assetTrack: AVAssetTrack!) {
        guard let track = assetTrack else { return nil }
        guard track.mediaType == .video else { return nil }
        
        let transform = track.preferredTransform
        let angle = atan2(transform.b, transform.a)
        
        switch Int(angle.toDeg) {
        case 90:    self = .portrait
        case -90:   self = .portraitUpsideDown
        case 0:     self = .landscapeLeft
        case 180:   self = .landscapeRight
        default:    return nil
        }
    }
    
    init?(_ asset: AVAsset) {
        self.init(asset.tracks(withMediaType: .video).first)
    }
    
    init?(_ playerItem: AVPlayerItem) {
        self.init(playerItem.asset)
    }
}
