//
//  ReelsModel.swift
//  Instagram
//
//  Created by Alex Karamanets on 06/05/2023.
//

import UIKit
import AVKit

struct ReelsModel {
    let reels: String
    var avpController: AVPlayerViewController
    var volume: Int
    var comment: [String]
    var numberOfLikes: Int
    var numberOfComment: Int
    var numberOfShare: Int
    let treck: String
    let reelsUser: User
}


