//
//  SceneConfigurator.swift
//  Midnight
//
//  Created by Victor Mendes on 04/12/22.
//

import UIKit

final class SceneConfigurator {
    internal var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}
