//
//  PlayButton.swift
//  PopcornTimetvOS SwiftUI
//
//  Created by Alexandru Tudose on 21.06.2021.
//  Copyright © 2021 PopcornTime. All rights reserved.
//

import SwiftUI
import PopcornKit
import Combine

struct PlayButton: View {
    var viewModel: MovieDetailsViewModel
    
    @State var preloadTorrentModel: PreloadTorrentViewModel?
    @State var playerModel: PlayerViewModel?
    
    @State var torrent: Torrent?
    
    @State var selection: Selection? = nil
    enum Selection: Int, Identifiable {
        case preload = 2
        case play = 3
        
        var id: Int { return rawValue }
    }
    var movie: Movie {
        return viewModel.movie
    }
    var onFocus: () -> Void = {}
    
    var body: some View {
        Group {
            if let _ = torrent {
                switch selection {
                case .some(.preload):
                    NavigationLink(
                        destination: PreloadTorrentView(viewModel: preloadTorrentModel!),
                        tag: Selection.preload,
                        selection: $selection) {
                            EmptyView()
                    }
                case .some(.play):
                    NavigationLink(
                        destination: PlayerView().environmentObject(playerModel!),
                        tag: Selection.play,
                        selection: $selection) {
                            EmptyView()
                        }
                case nil: EmptyView()
                }
            }
            
            SelectTorrentQualityButton(media: movie, action: { torrent in
                playTorrent(torrent)
            }, label: {
                VStack {
                    VisualEffectBlur() {
                        Image("Play")
                    }
                    Text("Play".localized)
                }
            }, onFocus: onFocus)
            .frame(width: 142, height: 115)
        }
    }
    
    func playTorrent(_ torrent: Torrent) {
        self.torrent = torrent
        selection = Selection.preload
        self.preloadTorrentModel = PreloadTorrentViewModel(torrent: torrent, media: movie, onReadyToPlay: { playerModel in
            self.playerModel = playerModel
            self.selection = .play
        })
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton(viewModel: MovieDetailsViewModel(movie: Movie.dummy()))
            .buttonStyle(TVButtonStyle())
            .padding(40)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
