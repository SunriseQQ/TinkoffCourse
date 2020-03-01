//
//  Protocols.swift
//  Chat-0.1
//
//  Created by Sunrise on 29.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

protocol ConfigurableView {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
