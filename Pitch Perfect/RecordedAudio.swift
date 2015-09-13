//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Tonman-PC on 9/13/2558 BE.
//  Copyright (c) 2558 TBD. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathUrl : NSURL!
    var title : String!
    init(filePathUrl : NSURL, title :String?){
        self.title = title
        self.filePathUrl = filePathUrl
    }
}