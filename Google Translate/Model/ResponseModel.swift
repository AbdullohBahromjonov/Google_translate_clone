//
//  ResponseModel.swift
//  Google Translate
//
//  Created by Abdulloh on 12/05/23.
//

import Foundation

struct ResponseModel: Decodable {
    var data: DataClass
}
struct DataClass: Decodable {
    var translations: [Translation]
}
struct Translation: Decodable {
    var translatedText: String
}
