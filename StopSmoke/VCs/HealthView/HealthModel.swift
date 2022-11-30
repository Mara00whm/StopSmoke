//
//  HealthModek.swift
//  StopSmoke
//
//  Created by Marat on 29.11.2022.
//

import Foundation
import UIKit

struct HealthModel {
    let hours: Double
    let desciption: String
    let image: UIImage
}

class HealthData {
    static let healthData: [HealthModel] = [
        HealthModel(hours: 0.3,
                    desciption: "Your blood pressure, pulse and temperature are back to normal",
                    image: .heart),
        
        HealthModel(hours: 8,
                    desciption: "The remaining nicotine in the bloodstream dropped to 6.25% of the peak daily values during smoking",
                    image: .arrowDown),
        
        HealthModel(hours: 12,
                    desciption: "The oxygen level in the blood has risen to a normal level. Carbon monoxide levels dropped to normal",
                    image: .stethoscope),
        
        HealthModel(hours: 24,
                    desciption: "Your anxiety has reached its maximum, you want to smoke. Within two weeks, the tension will gradually decrease",
                    image: .faceDashed),
        
        HealthModel(hours: 48,
                    desciption: "The nerve endings damaged during smoking began to recover and your sense of smell and taste return to normal. Anger and irritability can reach a maximum",
                    image: .chartLine),
        
        HealthModel(hours: 72,
                    desciption: "More than 90% of all metabolites of the body will be excreted by the body through the kidneys. The withdrawal syndrome reaches its peak.  It becomes easier to breathe, the lungs are restored",
                    image: .lungs)
    ]
}

