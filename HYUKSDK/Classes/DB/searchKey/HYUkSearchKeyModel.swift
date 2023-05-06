//
//  HYUkSearchKeyModel.swift
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

import Foundation
import WCDBSwift
import YYKit

@objcMembers public class HYUkSearchKeyModel: NSObject, TableCodable {

//    var tvId: Int = 0
    var name: String = ""
    var create_Time: Int = 0


    
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = HYUkSearchKeyModel
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)
       
        case name
        case create_Time


        public static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                name: ColumnConstraintBinding(isPrimary: true),
                create_Time: ColumnConstraintBinding(defaultTo: 0),
            ]
        }
    }
    
    required override init() {}
}
