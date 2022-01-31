//
//  ContentView.swift
//  GithubInfo
//
//  Created by Thomas Noble on 27/01/2022.
//

import SwiftUI
import URLImage
import Kingfisher


struct ListView: View {
    
    @ObservedObject var model = ListViewModel()

    let defaultImg = URL(string: "https://avatars.githubusercontent.com/u/484656?v=4")!
    
    var body: some View {
        VStack() {
            
            NavigationView{
                VStack {
                    List(model.response) { project in
                        NavigationLink(destination: ProjectView(projectModel: project)) {
                            
                            KFImage.url(URL(string: project.item.owner.avatar_url) ?? defaultImg)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:50, height:50)
                            
                            VStack(alignment: .leading) {
                                Text("\(project.item.name)")
                                Text("\(project.item.owner.login)")
                                    .foregroundColor(.gray)
                                
                            }
                            
                        }
                        Divider()
                        
                    }
                    
                }
                .onAppear{
                    self.model.getData(withUrl: URL(string: "https://api.github.com/search/repositories?q=language:swift")!)
                }
                .navigationBarTitle("Projects")
                
            }
                
        }
    }
}
