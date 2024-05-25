//
//  ViewController.swift
//  ASRMusic
//
//  Created by Ayushman Singh Rajawat on 25/05/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var songs=[Song]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        table.delegate=self
        table.dataSource=self
        // Do any additional setup after loading the view.
    }
    func configureSongs(){
        songs.append(Song(name: "Background Music", artistName: "Rando", albumname: "ABC", imageName: "1cover", trackName: "song1"))
        songs.append(Song(name: "Havana", artistName: "Camilla", albumname: "Havana album", imageName: "3cover", trackName: "song2"))
        songs.append(Song(name: "Viva La Lida", artistName: "Coldplay", albumname: "XYZ", imageName: "2cover", trackName: "song3"))
        songs.append(Song(name: "Background Music", artistName: "Rando", albumname: "ABC", imageName: "1cover", trackName: "song1"))
        songs.append(Song(name: "Havana", artistName: "Camilla", albumname: "Havana album", imageName: "3cover", trackName: "song2"))
        songs.append(Song(name: "Viva La Lida", artistName: "Coldplay", albumname: "XYZ", imageName: "2cover", trackName: "song3"))
        songs.append(Song(name: "Background Music", artistName: "Rando", albumname: "ABC", imageName: "1cover", trackName: "song1"))
        songs.append(Song(name: "Havana", artistName: "Camilla", albumname: "Havana album", imageName: "3cover", trackName: "song2"))
        songs.append(Song(name: "Viva La Lida", artistName: "Coldplay", albumname: "XYZ", imageName: "2cover", trackName: "song3"))

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text=song.name
        cell.imageView?.image=UIImage(named: song.imageName)
        cell.detailTextLabel?.text=song.albumname
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position=indexPath.row
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") else {
            return
        }
        present(vc, animated: true)
    }
    
}

