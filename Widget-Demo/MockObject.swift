
// To keep strings for the contexts straight define a global enum
enum MockContext: String {
    case Order = "order"
    case CheckIn = "checkin"
    case Map = "map"
    case Compass = "compass"

    static let allValues = [MockContext.Order.rawValue, MockContext.CheckIn.rawValue,
                            MockContext.Map.rawValue, MockContext.Compass.rawValue]
}

////
////  MockObject.swift
////  Widget-Demo
////
////  Created by Marcus Grant on 2/26/17.
////  Copyright © 2017 Marcus Grant. All rights reserved.
////
//
//import UIKit
//
//struct MockContext {
//
//    let defaults = UserDefaults(suiteName: "group.method.WidgetDemo")
//
//    enum Contexts: String {
//        case Order = "order"
//        case CheckIn = "checkin"
//        case Map = "map"
//        case Compass = "compass"
//
//        static let allValues = [Contexts.Order.rawValue, Contexts.CheckIn.rawValue,
//                                Contexts.Map.rawValue, Contexts.Compass.rawValue]
//    }
//
//    var context: Contexts
//
//    init() {
//        guard let defaults = UserDefaults(suiteName: "group.method.WidgetDemo")
//            else {
//                print("No defaults found using suiteName: \"group.method.WidgetDemo\"")
//                fatalError("Couldn't load defaults")
//        }
//        //self.context = MockContext.getContext(fromDefaults: defaults)
//    }
//
//    init (defaults: UserDefaults) {
//        //self.context = MockContext.getContext(fromDefaults: defaults)
//    }
//
//    init (contextString: String) {
//        self.init()
//        self.context = contextEnum(fromString: contextString)
//    }
//
////    static func getContext(fromDefaults defaults: UserDefaults) -> Contexts {
////        let contextKey = "context"
////        guard let contextObject = defaults.object(forKey: contextKey)
////            else {
////                var readContextErrorMSG = "Couln't get stored context for MockContext"
////                readContextErrorMSG += " instance with key \(contextKey)"
////                fatalError(readContextErrorMSG)
////                //return "order"
////        }; guard let contextString = contextObject as? String
////            else {
////                var readContextNotString = "Stored context value not a string"
////                fatalError(readContextNotString)
////        }; /*guard let newContext = contextEnum(fromString: contextString)
////            else {
////                fatalError("Couldn't convert string to context enum")
////        }*/
////        return contextEnum(contextString)
////
////    }
//
//    static func getAllContexts() -> [String] {
////        var contextValues: [String]
////        for currentContext in iterateEnums(Contexts) {
////            contextValues.append(currentContext.rawValue)
////        }
////        return contextValues
//        return Contexts.allValues
//    }
//
//
//    func contextEnum(fromString enumString: String) -> Contexts {
//        switch enumString {
//        case Contexts.Order.rawValue:
//            return Contexts.Order
//        case Contexts.CheckIn.rawValue:
//            return Contexts.CheckIn
//        case Contexts.Map.rawValue:
//            return Contexts.Map
//        case Contexts.Compass.rawValue:
//            return Contexts.Compass
//        default:
//            fatalError("conversion from context string to enum failed")
//        }
//    }
//
//    func getString(fromContext context: Contexts) -> String {
//        switch self.context {
//        case Contexts.Order:
//            return Contexts.Order.rawValue
//        case Contexts.CheckIn:
//            return Contexts.CheckIn.rawValue
//        case Contexts.Map:
//            return Contexts.Map.rawValue
//        case Contexts.Compass:
//            return Contexts.Compass.rawValue
//        default:
//            print("current context of MockObject instance is invalid, using order by default")
//            return "order"
//        }
//    }
//
//    func getMockImage() -> UIImage {
//        switch self.context {
//        case Contexts.Order:
//            return #imageLiteral(resourceName: "OrderScreen")
//        case Contexts.CheckIn:
//            return #imageLiteral(resourceName: "CheckinScreen")
//        case Contexts.Map:
//            return #imageLiteral(resourceName: "MapScreen")
//        case Contexts.Compass:
//            return #imageLiteral(resourceName: "MapScreen")
//        default:
//            fatalError("An incorrect context was requested of the MockObject instance, using context of raw value, \(context)")
//
//        }
//    }
//
//    func writeToDefaults() {
//        defaults?.set(context.rawValue, forKey: "context")
//        defaults?.synchronize()
//    }
//
//}
