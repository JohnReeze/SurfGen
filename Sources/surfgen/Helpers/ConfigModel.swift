//
//  ConfigModel.swift
//  surfgen
//
//  Created by Mikhail Monakov on 20/03/2020.
//

import PathKit

struct ConfigModel: Decodable {
    let entitiesPath: String
    let entriesPath: String
    let enumPath: String

    let generationTypes: [String]
    let generateDescriptions: Bool?
    let tempatesPath: String
    let blackList: String?

    let projectPath: String?
    let mainGroup: String?
    let targets: [String]?

    let gitlabToken: String?

    enum CodingKeys: String, CodingKey {
        case entitiesPath = "entities_path"
        case entriesPath = "entries_path"
        case enumPath = "enums_path"

        case projectPath = "project_path"
        case mainGroup = "project_main_group"
        case targets = "targets"

        case generationTypes = "generation_types"
        case generateDescriptions = "generate_descriptions"
        case tempatesPath = "templates_path"
        case blackList = "black_list_path"

        case gitlabToken = "gitlab_token"
    }

}
