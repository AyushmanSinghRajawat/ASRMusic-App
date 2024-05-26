//
//  ViewController.swift
//  ASRMusic
//
//  Created by Ayushman Singh Rajawat on 25/05/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var songs = [Song]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            configureSongs()
            collectionView.delegate = self
            collectionView.dataSource = self
            
            // Register the custom cell
            let nib = UINib(nibName: "cellFirst", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "cellFirst")
        }
        
        func configureSongs() {
            songs.append(Song(name: "Background Music", artistName: "Rando", albumname: "ABC", imageName: "1cover", trackName: "song1"))
            songs.append(Song(name: "Havana", artistName: "Camilla", albumname: "Havana album", imageName: "3cover", trackName: "song3"))
            songs.append(Song(name: "Viva La Vida", artistName: "Coldplay", albumname: "XYZ", imageName: "2cover", trackName: "song2"))
            songs.append(Song(name: "Background Music", artistName: "Rando", albumname: "ABC", imageName: "1cover", trackName: "song1"))
            songs.append(Song(name: "Havana", artistName: "Camilla", albumname: "Havana album", imageName: "3cover", trackName: "song3"))
            songs.append(Song(name: "Viva La Vida", artistName: "Coldplay", albumname: "XYZ", imageName: "2cover", trackName: "song2"))
            songs.append(Song(name: "Background Music", artistName: "Rando", albumname: "ABC", imageName: "1cover", trackName: "song1"))
            songs.append(Song(name: "Havana", artistName: "Camilla", albumname: "Havana album", imageName: "3cover", trackName: "song3"))
            songs.append(Song(name: "Viva La Vida", artistName: "Coldplay", albumname: "XYZ", imageName: "2cover", trackName: "song2"))
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return songs.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFirst", for: indexPath) as! SongCollectionViewCell
            let song = songs[indexPath.row]
            cell.nameLabel.text = song.name
            cell.imageView.image = UIImage(named: song.imageName)
            cell.albumLabel.text = song.albumname
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            let position = indexPath.row
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
                return
            }
            vc.songs = songs
            vc.position = position
            present(vc, animated: true)
        }
        
        // UICollectionViewDelegateFlowLayout methods to adjust cell size
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 90)
        }
    }
