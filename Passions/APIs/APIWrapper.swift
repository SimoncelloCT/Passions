//
//  APIWrapper.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation
import UIKit
class APIWrapper {
    let api = BackendAPI.getUniqueIstance()
    
    public func getNews() -> [UIImage]{
        var array = [UIImage]()
        array.append(UIImage.init(named: "newsMercedes")!)
        return array
    }
    
    public func getForMeCollections() -> [Collection]{
         var objArray = [ShareObject]()
        objArray.append(PhotoObject.init(photo: UIImage.init(named: "classea_1")!, description: "Ecco gli interni del mio bolide!"))
        objArray.append(PhotoObject.init(photo: UIImage.init(named:"classea_2")!, description: "Quando è bella da questa prospettiva?"))
        objArray.append(PhotoObject.init(photo: UIImage.init(named:"classea_3")!, description: "Bello anche il nuovo modello"))
        
        let testProfile = Profile.init(userOwner: User.init(name: "Simone", surname: "Scionti", age: 21), profileUsername: "Simonescionti", profileImage: UIImage.init(named: "profile")!)
        
        let testPassion = Passion.init(name: "Motori", color: UIColor.orange)
        
        var arrayTest = [Collection]()
        arrayTest.append(Collection.init(items: objArray, collectionName: "La mia Classe A", collectionOwner: testProfile, passion: testPassion))
        arrayTest.append(Collection.init(items: objArray, collectionName: "La mia Classe A2", collectionOwner: testProfile, passion: testPassion))
        arrayTest.append(Collection.init(items: objArray, collectionName: "La mia Classe A 3", collectionOwner: testProfile, passion: testPassion))
        
        return arrayTest        
    }
    
    public func getRecentContent() -> [Collection] {
        
        
        var objArray = [ShareObject]()
        
        objArray.append(PhotoObject.init(photo: UIImage.init(named: "classea_1")!, description: "Bella foto questa ahajajkakakahaUIGEHOQWWD https://storage.coverr.co/videos/coverr-vehicles-on-the-highway-1567243769917?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBJZCI6IjExNDMyN0NEOTRCMUFCMTFERTE3IiwiaWF0IjoxNTg2MTkxMTEyfQ.OGCvpVKOKzsT6IVJPBKRChe1la7rI9lG06B5eksixqY https://storage.coverr.co/videos/coverr-vehicles-on-the-highway-1567243769917?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBJZCI6IjExNDMyN0NEOTRCMUFCMTFERTE3IiwiaWF0IjoxNTg2MTkxMTEyfQ.OGCvpVKOKzsT6IVJPBKRChe1la7rI9lG06B5eksixqY"))
        objArray.append(VideoObject.init(videoUrl: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8",description:"che video di merda", videoFrameImage: nil))
        
        
        let testProfile = Profile.init(userOwner: User.init(name: "Simone", surname: "Scionti", age: 21), profileUsername: "Simonescionti", profileImage: UIImage.init(named: "profile")!)
        
        let videogame = VideogameObject.init(image: UIImage.init(named: "foto")!, description: "Questo gioco è fantastico!!")
        
        var comments = [Comment]()
        var j = 0
        while j<20{
            comments.append(Comment.init(message: "Bellissimo videogioco !! JhcHBJZCI6IjExNDMyN0NEOTRCMUFCMTFERTE3IiwiaWF0IjoxNTg2MTkxMTEyfQ.OGCvpVKOKzsT6IVJPBKRChe1la7rI9lG06B5eksixqY https://storage.coverr.co/videos/coverr-vehicles-on-the-highway-1567243769917?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBJZCI6IjExNDMyN0NEOTRCMUFCMTFERTE3IiwiaWF0IjoxNTg2MTkxMTEyfQ.OGCvpVKOKzsT6IVJPBKRChe1la7rI9lG06B5eksixqY", ownerProfile: testProfile))
            j+=1
        }
        
        videogame.insertComments(comments: comments)
        
        objArray.append(videogame)
       
        print(videogame.comments.count)
       
        
        let testPassion = Passion.init(name: "Motori", color: UIColor.brown)
        
        var arrayTest = [Collection]()
        arrayTest.append(Collection.init(items: objArray,collectionName: "I miei giochi preferiti" , collectionOwner: testProfile, passion: testPassion))
        var i = 0;
        while i < 10{
            arrayTest.append(Collection.init(items: objArray,collectionName: "Spot preferiti" , collectionOwner: testProfile, passion: testPassion))
            i+=1
        }
        
       /* arrayTest.append(Collection.init(items: objArray,collectionName: "Spot preferiti" , collectionOwner: testProfile, passion: testPassion))
        arrayTest.append(Collection.init(items: objArray,collectionName: "La mia classe A" , collectionOwner: testProfile, passion: testPassion ))*/
        
        
        
        return arrayTest
    }
    
}
