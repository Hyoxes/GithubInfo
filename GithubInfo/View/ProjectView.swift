//
//  ProjectView.swift
//  GithubInfo
//
//  Created by invité on 30/01/2022.
//

import SwiftUI

struct ProjectView: View {
    
    var projectModel: ProjectModel
    
    var body: some View {
        VStack (spacing: 20) {
            VStack(alignment: .leading) {
                Text("\(projectModel.item.name)")
                    .font(.largeTitle)
            }
            VStack(alignment: .leading) {
                Text("By \(projectModel.item.owner.login)")
                    .font(.headline)
            }
            VStack(alignment: .leading) {
                
                Text("Créé le \(projectModel.creationDate)\nDernière mise à jour le \(projectModel.updateDate)")
                    .padding()
                
                Text("Description : \n\(projectModel.item.description ?? "Ce projet n'a pas de description")")
                    .padding()
            
                Text("Fav: \(projectModel.item.stargazers_count)")
                    .foregroundColor(.orange)
                    .padding(.leading)

                    
                Text("Fork: \(projectModel.item.forks_count)")
                    .foregroundColor(.green)
                    .padding(.leading)

            }
        }
        .padding(.top, -200)
    }
}
