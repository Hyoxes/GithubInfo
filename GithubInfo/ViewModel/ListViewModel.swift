//
//  ListViewModel.swift
//  GithubInfo
//
//  Created by invité on 30/01/2022.
//

import Foundation
import Combine

class ListViewModel:ObservableObject {
    
    @Published var response = [ProjectModel]()
    @Published var error_message: String?
    
    private var publisher_request: Cancellable? {
        didSet{ oldValue?.cancel() }
    }
    deinit{
        publisher_request?.cancel()
    }
    
    func getData(withUrl: URL) {
        publisher_request = webRequest(with: withUrl)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:{ (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }){ (res: GithubApiResponseModel) in
                for project in res.items {
                    let modelToshow = ProjectModel(item: project)
                    self.response.append(modelToshow)
                    
                }
                print(res)
            }
    }
    
}
