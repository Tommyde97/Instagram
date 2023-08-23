//
//  HomeViewController.swift
//  Instagram
//
//  Created by Tomas D. De Andrade Gomes on 8/8/23.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModel = [HomeFeedRenderViewModel]()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FeedPostTableViewCell.self,
                           forCellReuseIdentifier: FeedPostTableViewCell.identifier)
        tableView.register(FeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: FeedPostHeaderTableViewCell.identifier)
        tableView.register(FeedPostActionsTableViewCell.self,
                           forCellReuseIdentifier: FeedPostActionsTableViewCell.identifier)
        tableView.register(FeedPostGeneralTableViewCell.self,
                           forCellReuseIdentifier: FeedPostGeneralTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func createMockModels() {
        let user = User(username: "@Joe",
                        bio: "",
                        name: (first: "", last: ""),
                        profilePhoto: URL(string: "https://www.google.com")!,
                        birthDate: Date(),
                        gender: .male,
                        counts: UserCount(followers: 1, following: 1, posts: 1),
                        joinDate: Date())
        let post = UserPost(indentifier: "",
                            postType: .photo,
                            thumbnailImage: URL( string: "https://www.google.com")!,
                            postURL: URL( string: "https://www.google.com")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createdDate: Date(),
                            taggedUsers: [],
                            owner: user)
        
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)",
                                        username: "@Jenny",
                                        text: "This is the best post I have seen",
                                        createdDate: Date(),
                                        likes: []
                                       )
            )
        }
        for x in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModel.append(viewModel)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        // Check Auth Status
        if Auth.auth().currentUser == nil {
            // Show Log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModel.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModel[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModel[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            //Header
            return 1
        } else if subSection == 1 {
            //Post
            return 1
        } else if subSection == 2 {
            //Actions
            return 1
        } else if subSection == 3 {
            //Comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent: return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModel[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModel[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            //Header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostHeaderTableViewCell.identifier,
                                                         for: indexPath) as! FeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        } else if subSection == 1 {
            //Post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifier,
                                                         for: indexPath) as! FeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case .comments, .actions, .header: return UITableViewCell()
            }
        } else if subSection == 2 {
            //Actions
            switch model.actions.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionsTableViewCell.identifier,
                                                         for: indexPath) as! FeedPostActionsTableViewCell
                cell.delegate = self
                return cell
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
        } else if subSection == 3 {
            //Comments
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostGeneralTableViewCell.identifier,
                                                         for: indexPath) as! FeedPostGeneralTableViewCell
                return cell
            case .header, .actions, .primaryContent: return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            //Header
            return 70
            
        } else if subSection == 1 {
            //Post
            return  tableView.width
            
        } else if subSection == 2 {
            //Actions
            return 60
            
        } else if subSection == 3 {
            //Comment row
            return 50
        }
            return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}

extension HomeViewController: FeedPostHeaderTableViewCellDelegate {
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    func reportPost() {
        
    }
}


extension HomeViewController: FeedPostActionsTableViewCellDelegate {
    func didTapLikeButton() {
        print("Like")
    }
    
    func didTapCommentButton() {
        print("Comment")
    }
    
    func didTapSendButton() {
        print("Send")
    }
        
}
