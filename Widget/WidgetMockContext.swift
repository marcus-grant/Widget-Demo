//
//  WidgetMockContext.swift
//  Widget-Demo
//
//  Created by Marcus Grant on 3/6/17.
//  Copyright © 2017 Marcus Grant. All rights reserved.
//

enum MockContext: String {
    case Order = "order"
    case CheckIn = "checkin"
    case Map = "map"
    case Compass = "compass"

    static let allValues = [MockContext.Order.rawValue, MockContext.CheckIn.rawValue,
                            MockContext.Map.rawValue, MockContext.Compass.rawValue]
}
