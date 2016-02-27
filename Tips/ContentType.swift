// For License please refer to LICENSE file in the root of Persei project

import Foundation

import UIKit

enum ContentType: String, CustomStringConvertible {
    case Hotel
    case Restaurant
    case Bar
    case Spa
    case Taxi
    
    var description: String {
        switch self {
        case .Bar:
            return "Tip for Bar"
        case .Hotel:
            return "Tip for Hotel"
        case .Restaurant:
            return "Tip for Restaurant"
        case .Spa:
            return "Tip for Spa"
        case .Taxi:
            return "Tip for Taxi"
        }
    }
    
    var percent: [Double] {
        switch self {
        case .Bar:
            return [0.05,0.10,0.20]
        case .Hotel:
            return [0.10,0.15,0.20]
        case .Restaurant:
            return [0.05,0.15,0.20]
        case .Spa:
            return [0.02,0.10,0.15]
        case .Taxi:
            return [0.02,0.08,0.10]
        }
    }
}

let tipTypes = [ContentType.Restaurant, ContentType.Hotel, ContentType.Spa, ContentType.Taxi]

//let contentType = ["Tip for Restaurant", "Tip for Hotel", "Tip for Spa", "Tip for Taxi"]

let TipType = "tiptype"
let Amount = "amount"

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}