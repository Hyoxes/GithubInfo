//
//  ProjectModel.swift
//  GithubInfo
//
//  Created by Thomas Noble on 27/01/2022.
//

import Foundation


struct GithubApiResponseModel: Decodable {
    let items: [ProjectResponseModel]
}

struct ProjectResponseModel: Decodable {
    let name: String
    var created_at: String
    var updated_at: String
    let description: String?
    let forks_count: Int
    let stargazers_count: Int
    let owner: OwnerModel
}

struct OwnerModel: Decodable {
    let login: String
    let avatar_url: String
    
}


