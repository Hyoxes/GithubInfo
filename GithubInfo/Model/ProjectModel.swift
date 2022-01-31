//
//  ProjectModel.swift
//  GithubInfo
//
//  Created by Thomas Noble on 31/01/2022.
//

import Foundation

struct ProjectModel: Identifiable {
    var id = UUID()
    let item: ProjectResponseModel
    var creationDate: String{
        get    {
            let tmpString = item.created_at
            return (dateFromyyyyMMddTHHmmssZToddMMAAAA(with: tmpString));
        }
    }
    var updateDate: String{
        get    {
            let tmpString = item.updated_at
            return (dateFromyyyyMMddTHHmmssZToddMMAAAA(with: tmpString));
        }
    }
}
