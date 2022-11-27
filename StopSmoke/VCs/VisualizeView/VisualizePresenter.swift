//
//  VisualizePresenter.swift
//  StopSmoke
//
//  Created by Marat on 27.11.2022.
//

import Foundation
import UIKit

struct VisualizeModel {
    let name: String
    let metres: Double
    let imageName: String
}

class VisualizeData {
    static let visualizeData: [VisualizeModel] = [
        VisualizeModel(name: "Human", metres: 1.7, imageName: "human"),
        VisualizeModel(name: "Elephant", metres: 3.2, imageName: "elephant"),
        VisualizeModel(name: "House", metres: 7, imageName: "house"),
        VisualizeModel(name: "Brachiosaurus", metres: 13, imageName: "brachiosaurus"),
        VisualizeModel(name: "Whale", metres: 23, imageName: "whale"),
        VisualizeModel(name: "Fir", metres: 30, imageName: "fir"),
        VisualizeModel(name: "The Arc de Triomphe", metres: 49, imageName: "triomphe"),
        VisualizeModel(name: "Proton Rocket", metres: 58.2, imageName: "proton"),
        VisualizeModel(name: "The Statue of Liberty", metres: 92, imageName: "liberty"),
        VisualizeModel(name: "Big Ben", metres: 96, imageName: "bigBen"),
        VisualizeModel(name: "The Space Needle", metres: 184, imageName: "spaceNeedle"),
        VisualizeModel(name: "The Golden Gate Bridge", metres: 227, imageName: "goldenGate"),
        VisualizeModel(name: "The Eiffel Tower", metres: 324, imageName: "eiffelTower"),
        VisualizeModel(name: "Burj Khalifa", metres: 828, imageName: "burjKhalifa"),
        VisualizeModel(name: "x5 Effiel Tower", metres: 1620, imageName: "eiffelTower"),
        VisualizeModel(name: "x83 Chichen Itza", metres: 2500, imageName: "mexicanPyramid")
    ]
}
