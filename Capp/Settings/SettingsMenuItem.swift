//
//  SettingsMenuItem.swift
//  Capp
//
//  Created by Chuck Argyle on 11/1/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import Foundation

class SettingsMenuItem {
    var label : String = ""
    var hasToggleSwitch : Bool = false
    var segueId : String = ""
    var hasSegue : Bool = false
    
    init(label : String, hasToggleSwitch : Bool = false, segueId : String = "") {
        self.label = label
        self.hasToggleSwitch = hasToggleSwitch
        self.segueId = segueId
        self.hasSegue = segueId != ""
    }
}

