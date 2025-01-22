//
//  VideoPlayer.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 20/10/2024.
//

import AVFoundation
import AVKit
import SwiftUI

struct VideoPlayer: UIViewRepresentable {
    let url: String
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayer>) {
    }

    func makeUIView(context: Context) -> UIView {
        // Prevents video interrupting any media already playing in the background
        // credit: https://stackoverflow.com/a/39084300
        _ = try? AVAudioSession.sharedInstance().setCategory(
            AVAudioSession.Category.playback,
            mode: .default,
            options: .mixWithOthers)
        
        return PlayerUIView(frame: .zero, vidUrl: url)
    }
}

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    private var queuePlayer: AVQueuePlayer?
    private let vidUrl: String

    init(frame: CGRect, vidUrl: String) {
        self.vidUrl = vidUrl
        super.init(frame: frame)
        guard let url = Bundle.main.url(forResource: vidUrl, withExtension: "mov") else {
            fatalError("Video file not found, url is \(self.vidUrl)")
        }

        let playerItem = AVPlayerItem(url: url)
        queuePlayer = AVQueuePlayer()
        playerLayer.player = queuePlayer
        layer.addSublayer(playerLayer)

        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: playerItem)
        queuePlayer?.play()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

// the value to scale each mastery crest video to ensure consistent sizing
func vidScale(lvl: Int) -> CGFloat {
    switch lvl{
    case 1, 2, 3:
        return 0.7
    case 4:
        return 0.95
    case 5:
        return 0.775
    case 6:
        return 0.825
    case 7:
        return 0.725
    case 8:
        return 0.85
    case 9:
        return 0.95
    default:
        return 1
    }
}

#Preview {
    ZStack{
        VideoPlayer(url: "crest-aurora-loop")
            .frame(width: 250, height: 250)
        VideoPlayer(url: "10-loop")
            .frame(width: 200, height: 200)
        ScrollView{
            VStack{
                ForEach(1..<10){ num in
                    var scale = vidScale(lvl: num)
                    VideoPlayer(url: "\(num)-loop")
                        .frame(width: 200*scale, height: 200*scale)
                    
                }
                ForEach(1..<10){ num in
                    var scale = vidScale(lvl: num)
                    VideoPlayer(url: "\(num)-loop")
                        .frame(width: 200*scale, height: 200*scale)
                    
                }
            }
        }
    }
}
