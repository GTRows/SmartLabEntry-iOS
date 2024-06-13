//
//  GraphsViewModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 13.06.2024.
//

import Combine
import Foundation
import SwiftUI

class GraphsViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    private var cancellables = Set<AnyCancellable>()
    @Published var imageNamesList = [String]()

    func fetchImageList() {
        guard let url = URL(string: ApiPath.baseUrl + ApiPath.getImageList) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .compactMap { String(data: $0, encoding: .utf8) }
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching image list: \(error)")
                }
            }, receiveValue: { [weak self] responseString in
                let imageNames = responseString.components(separatedBy: "\n").filter { !$0.isEmpty }
                self!.imageNamesList = imageNames
                self?.fetchImages(imageNames: imageNames)
            })
            .store(in: &cancellables)
    }

    private func fetchImages(imageNames: [String]) {
        let imageFetchPublishers = imageNames.map { imageName -> AnyPublisher<UIImage?, Never> in
            guard let url = URL(string: ApiPath.baseUrl + "\(ApiPath.getImage)/\(imageName)") else {
                return Just(nil).eraseToAnyPublisher()
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            return URLSession.shared.dataTaskPublisher(for: request)
                .map { data, _ in UIImage(data: data) }
                .catch { _ in Just(nil) }
                .eraseToAnyPublisher()
        }

        Publishers.MergeMany(imageFetchPublishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] images in
                self?.images = images.compactMap { $0 }
            }
            .store(in: &cancellables)
    }
}
