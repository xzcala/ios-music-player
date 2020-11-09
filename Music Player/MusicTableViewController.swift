//
//  MusicTableViewController.swift
//  Music Player
//
//  Created by Jon Basa on 5/7/20.
//  Copyright © 2020 Jon Basa. All rights reserved.
//

import UIKit

class MusicTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    
    var playlist = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //list of songs to be added
        playlist.append(Song(name: "LA Devotee", album: "Death of a Bachelor", artist: "Panic! at the Disco", cover: "AlbumCover1", fileName: "la_devotee"))
        playlist.append(Song(name: "Naivety", album: "Bad Vibrations", artist: "A Day to Remember", cover: "AlbumCover2", fileName: "naivety"))
        playlist.append(Song(name: "Symbolism", album: "Symbolism", artist: "Electro-Light", cover: "AlbumCover3", fileName: "symbolism"))
        playlist.append(Song(name: "Symbolism", album: "Symbolism", artist: "Electro-Light", cover: "AlbumCover3", fileName: "symbolism"))
        playlist.append(Song(name: "Symbolism", album: "Symbolism", artist: "Electro-Light", cover: "AlbumCover3", fileName: "symbolism"))
        playlist.append(Song(name: "Naivety", album: "Bad Vibrations", artist: "A Day to Remember", cover: "AlbumCover2", fileName: "naivety"))
        playlist.append(Song(name: "LA Devotee", album: "Death of a Bachelor", artist: "Panic! at the Disco", cover: "AlbumCover1", fileName: "la_devotee"))
        
        table.delegate = self
        table.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        let song = playlist[indexPath.row]
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.album
        cell.imageView?.image = UIImage(named: song.cover)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MusicPlayerViewController,
            let selectedIndexPath = table.indexPathForSelectedRow {
            destination.songs = playlist
            destination.index = selectedIndexPath.row
        }
    }
   
}
