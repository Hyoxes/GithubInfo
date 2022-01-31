//
//  GithubInfoTests.swift
//  GithubInfoTests
//
//  Created by Thomas Noble on 27/01/2022.
//

import XCTest
import Combine
@testable import GithubInfo

class GithubInfoTests: XCTestCase {
    
    private var publisher_request: Cancellable? {
        didSet{ oldValue?.cancel() }
    }
    
        
    let data = """
            {\"items\":
                [
                    {"name": "awesome-ios",
                    "created_at": "2014-07-10T16:03:45Z",
                    "updated_at": "2022-01-31T08:19:42Z",
                    "description": "A curated list of awesome iOS ecosystem, including Objective-C and Swift Projects ",
                    "forks_count": 6470,
                    "stargazers_count": 38928,
                    "owner":
                        {"login": "vsouza",
                        "avatar_url": "https://avatars.githubusercontent.com/u/484656?v=4",}
                    }
                ]
        }
        """
        
    
    func testJsonDecoderResultType() throws {
        
        let dta = Data(data.utf8)
        
        publisher_request = decode(data: dta)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:{ (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    XCTAssert(false)
                }
            }){ (res: GithubApiResponseModel) in
                    XCTAssert(true)
                
                }
    }
    
    func testJsonDecoderResultValue() throws {
        
        let owner = OwnerModel(login: "vsouza", avatar_url: "https://avatars.githubusercontent.com/u/484656?v=4")
        let project = ProjectResponseModel(name: "awesome-ios", created_at: "2014-07-10T16:03:45Z", updated_at: "2022-01-31T08:19:42Z", description: "A curated list of awesome iOS ecosystem, including Objective-C and Swift Projects ", forks_count: 6470, stargazers_count: 38928, owner: owner)
        //let result = GithubApiResponseModel(items: [projects])
        let result = ProjectModel(item: project)
        let dta = Data(data.utf8)
        
        
        publisher_request = decode(data: dta)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:{ (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    XCTAssert(false)
                }
            }){ (res: GithubApiResponseModel) in
                for project in res.items {
                    let modelToshow = ProjectModel(item: project)
                    XCTAssertTrue(modelToshow.updateDate == result.updateDate)
                    XCTAssertTrue(modelToshow.creationDate == result.creationDate)
                    XCTAssertTrue(modelToshow.item.name == result.item.name)
                    XCTAssertTrue(modelToshow.item.forks_count == result.item.forks_count)
                    XCTAssertTrue(modelToshow.item.stargazers_count == result.item.stargazers_count)
                    XCTAssertTrue(modelToshow.item.description == result.item.description)
                    XCTAssertTrue(modelToshow.item.owner.avatar_url == result.item.owner.avatar_url)
                    XCTAssertTrue(modelToshow.item.owner.login == result.item.owner.login)
                    
                }
                
                }
    }
    
    func testDateFormatter() throws {
        let initialDate = "2016-06-10T11:49:00Z"
        let finalDate = "10/06/2016"
        let dateformatted = dateFromyyyyMMddTHHmmssZToddMMAAAA(with: initialDate)
        XCTAssertTrue(dateformatted == finalDate)
    }


}
