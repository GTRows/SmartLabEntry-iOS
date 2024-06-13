//
//  GraphsView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 13.06.2024.
//

import SwiftUI

struct GraphsView: View {
    @ObservedObject private var viewModel = GraphsViewModel()
    @StateObject var alertService = AlertService.shared

    var body: some View {
        VStack {
            Text(Localization.graphs)
                .font(.custom("Comfortaa", size: 35))
                .fontWeight(.bold)
                .foregroundColor(AppTheme.lightColor)
                .multilineTextAlignment(.leading)
                .frame(width: 250, alignment: .leading)
            Divider()
            ScrollView {
                ForEach(Array(zip(viewModel.images.indices, viewModel.images)), id: \.0) { index, image in
                    Text(viewModel.imageNamesList[index])
                        .font(.custom("Comfortaa", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.lightColor)
                        .multilineTextAlignment(.leading)
                        .frame(width: 250, alignment: .leading)
                        .padding()
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                }
            }
        }
        .background(
            AppTheme.backgroundGradientView
        )
        .alert(isPresented: $alertService.isPresenting) {
            alertService.alert
        }.onAppear {
            viewModel.fetchImageList()
        }
    }
}

#Preview {
    GraphsView()
}
