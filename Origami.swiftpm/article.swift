//
//  article.swift
//  Origami
//
//  Created by Seungyun Kim on 2022/04/24.
//

import Foundation
import SwiftUI

struct Article: Identifiable {
    var id: Int
    let name: String
    let location: CGPoint
    let rotate: Angle
    let scale: CGFloat
}
