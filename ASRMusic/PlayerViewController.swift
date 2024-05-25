//
//  PlayerViewController.swift
//  ASRMusic
//
//  Created by Ayushman Singh Rajawat on 25/05/24.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    var player:AVAudioPlayer?
    
    @IBOutlet weak var holder: UIView!
    
    
    private let albumimage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    let playpauseButton = UIButton()
    public var position:Int=0
    public var songs : [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0{
            configure()
        }
    }
    func configure(){
        let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            guard let player = player else{
                return
            }
            player.volume=0.5
            player.play()
        } catch {
            print("error occured")
        }
        albumimage.frame = CGRect(x: 10, y: 10, width: holder.frame.width-20, height: holder.frame.width-20)
        albumimage.image = UIImage(named: song.imageName)
        holder.addSubview(albumimage)
        songNameLabel.frame = CGRect(x: 10, y: albumimage.frame.size.height+10 , width: holder.frame.width-20, height: 70)
        albumNameLabel.frame = CGRect(x: 10, y: albumimage.frame.size.height+10+70, width: holder.frame.width-20, height: 70)
        artistNameLabel.frame = CGRect(x: 10, y: albumimage.frame.size.height+10+140, width: holder.frame.width-20, height: 70)
        songNameLabel.text=song.name
        albumNameLabel.text=song.albumname
        artistNameLabel.text=song.artistName
        
        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        

        let backButton=UIButton()
        let nextButton = UIButton()
        
        let yPosition = artistNameLabel.frame.origin.y+70+20
        let size:CGFloat = 70
        
        playpauseButton.frame = CGRect(x: (holder.frame.size.width-size)/2.0, y: yPosition, width: size, height: size)
        backButton.frame = CGRect(x: 20, y: yPosition, width: size, height: size)
        nextButton.frame = CGRect(x: (holder.frame.size.width - size - 20), y: yPosition, width: size, height: size)
        
        backButton.addTarget(self, action: #selector(didtapBackButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didtapNextButton), for: .touchUpInside)
        playpauseButton.addTarget(self, action: #selector(didtapplaypauseButton), for: .touchUpInside)
        
        
        playpauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        playpauseButton.tintColor = .black
        nextButton.tintColor = .black
        backButton.tintColor = .black
        
        holder.addSubview(playpauseButton)
        holder.addSubview(backButton)
        holder.addSubview(nextButton)
        
        let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.size.height-60, width: holder.frame.size.width-40, height: 50))
        slider.value=0.5
        slider.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)
        holder.addSubview(slider)
        
    }
    
    @objc func didtapBackButton(){
        if position>0 {
            position = position-1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
                configure()
            }
        }
    }
    
    @objc func didtapNextButton(){
        if position<songs.count-1 {
            position = position+1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
                configure()
            }
        }
    }
    @objc func didtapplaypauseButton(){
        if player?.isPlaying == true {
            player?.pause()
            playpauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }else{
            player?.play()
            playpauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        
    }
    
    @objc func didSlideSlider(_ slider:UISlider){
        let value=slider.value
        player?.volume=value
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let player = player {
            player.stop()
        }
    }

}
