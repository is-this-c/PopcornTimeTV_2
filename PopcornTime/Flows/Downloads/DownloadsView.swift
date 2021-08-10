//
//  DownloadsView.swift
//  PopcornTimetvOS SwiftUI
//
//  Created by Alexandru Tudose on 19.06.2021.
//  Copyright © 2021 PopcornTime. All rights reserved.
//

import SwiftUI
import PopcornKit
import PopcornTorrent

struct DownloadsView: View {
    @StateObject var viewModel = DownloadsViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isEmpty {
                emptyView
            } else {
                ScrollView {
                    VStack {
                        if !viewModel.downloading.isEmpty {
                            downloadingSection
                        }
                        if !viewModel.completedMovies.isEmpty {
                            movieSection
                        }
                        if !viewModel.completedEpisodes.isEmpty {
                            showSection
                        }
                    }
                }
                
            }
        }
        .onAppear {
            viewModel.reload()
        }
    }
    
    @ViewBuilder
    var emptyView: some View {
        VStack {
            Text("Downloads Empty".localized)
                .font(.title2)
                .padding()
            Text("Movies and episodes you download will show up here.".localized)
                .font(.callout)
                .foregroundColor(.init(white: 1.0, opacity: 0.667))
                .frame(maxWidth: 400)
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    var downloadingSection: some View {
        VStack(alignment: .leading) {
            Text("Downloading".localized)
                .font(.callout)
                .foregroundColor(.init(white: 1.0, opacity: 0.667)) // light text color
                .padding(.top, 14)
            ScrollView(.horizontal) {
                HStack(spacing: 40) {
                    ForEach(viewModel.downloading, id: \.self) { download in
                        DownloadView(viewModel: DownloadViewModel(download: download))
                            .frame(width: 500)
//                            .background(Color.red)
//                            .padding([.leading, .trailing], 10)
                    }
                    .padding(30) // allow zoom
                }.padding(.all, 0)
            }
        }
    }
    
    @ViewBuilder
    var movieSection: some View {
        VStack(alignment: .leading) {
            Text("Movies".localized)
                .font(.callout)
                .foregroundColor(.init(white: 1.0, opacity: 0.667)) // light text color
                .padding(.top, 14)
            ScrollView(.horizontal) {
                HStack(spacing: 40) {
                    ForEach(viewModel.completedMovies, id: \.self) { download in
                        DownloadView(viewModel: DownloadViewModel(download: download))
                            .frame(width: 240, height: 420)
//                            .padding([.leading, .trailing], 10)
                    }
                    .padding(20) // allow zoom
                }.padding(.all, 0)
            }
        }
    }
    
    @ViewBuilder
    var showSection: some View {
        VStack(alignment: .leading) {
            Text("Episodes".localized)
                .font(.callout)
                .foregroundColor(.init(white: 1.0, opacity: 0.667)) // light text color
                .padding(.top, 14)
            ScrollView(.horizontal) {
                HStack(spacing: 40) {
                    ForEach(viewModel.completedEpisodes, id: \.self) { download in
                        DownloadView(viewModel: DownloadViewModel(download: download))
                            .frame(width: 240, height: 420)
                    }
                    .padding(20) // allow zoom
                }.padding(.all, 0)
            }
        }
    }
}

struct DownloadsView_Previews: PreviewProvider {
    static var previews: some View {
        activeDownloadsView
//        DownloadsView()
    }
    
    static var activeDownloadsView: some View {
        let viewModel = DownloadsViewModel()
        return DownloadsView(viewModel: viewModel)
            .onAppear {
//                viewModel.downloading = [.dummy(status: .downloading), .dummy(status: .downloading)]
                viewModel.completedMovies = [.dummy(status: .finished)]
                viewModel.completedEpisodes = [.dummyEpisode(status: .finished)]
            }
    }
}