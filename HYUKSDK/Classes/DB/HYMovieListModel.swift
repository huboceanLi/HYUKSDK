//
//  HYMovieListModel.swift
//  VideoDBFramework
//
//  Created by oceanMAC on 2023/4/19.
//

import Foundation
import WCDBSwift
import YYKit

@objcMembers public class HYMovieListModel: NSObject, TableCodable {

    var tvId: Int = 0
    var name: String = ""
    var des: String = ""
    var playUrl: String = ""
    var imageUrl: String = ""
    var duration: String = ""
    var videoCount: Int = 0
    var score: Double = 0.0
    var people: String = ""
    var categories: String = ""
    var period: String = ""

    
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = HYMovieListModel
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)
       
        case tvId
        case name
        case des
        case playUrl
        case imageUrl
        case duration
        case videoCount
        case score
        case people
        case categories
        case period

        public static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                tvId: ColumnConstraintBinding(isPrimary: true),
                name: ColumnConstraintBinding(defaultTo: ""),
                des: ColumnConstraintBinding(defaultTo: ""),
                playUrl: ColumnConstraintBinding(defaultTo: ""),
                imageUrl: ColumnConstraintBinding(defaultTo: ""),
                duration: ColumnConstraintBinding(defaultTo: ""),
                people: ColumnConstraintBinding(defaultTo: ""),
                categories: ColumnConstraintBinding(defaultTo: ""),
                period: ColumnConstraintBinding(defaultTo: ""),
                videoCount: ColumnConstraintBinding(defaultTo: 0),
                score: ColumnConstraintBinding(defaultTo: 0),

            ]
        }
    }
    
    required override init() {}
}
