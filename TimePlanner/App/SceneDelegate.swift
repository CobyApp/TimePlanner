//
//  SceneDelegate.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import UIKit

import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private lazy var loginViewController: UINavigationController = {
        let navigationController = UINavigationController()
        let repository = SignRepositoryImpl()
        let usecase = SignUsecaseImpl(repository: repository)
        let coordinator = LoginCoordinator(navigationController: navigationController)
        let viewModel = LoginViewModel(usecase: usecase, coordinator: coordinator)
        let viewController = LoginViewController(viewModel: viewModel)
        navigationController.viewControllers = [loginViewController]
        
        return navigationController
    }()
    
    private lazy var tabBarController: UITabBarController = {
        let tabBarController = TabBarController()
        return tabBarController
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        // 로그인 여부 확인
        if let user = Auth.auth().currentUser {
            // 사용자가 로그인되어 있으면 TabBarController로 이동
            print(user)
            self.window?.rootViewController = tabBarController
        } else {
            // 로그인되지 않았으면 LoginViewController로 이동
            self.window?.rootViewController = loginViewController
        }
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
