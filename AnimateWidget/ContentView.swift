//
//  ContentView.swift
//  AnimateWidget
//
//  Created by Danylo Bulanov on 11/27/22.
//

import SwiftUI

struct ContentView: View {
    @State var level = 0.0
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    var body: some View {
        Text("\(level)%")
            .onAppear(perform: {
                
                self.level = Double(UIDevice.current.batteryLevel)
            })
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.batteryLevelDidChangeNotification), perform: { _ in
                self.level = Double(UIDevice.current.batteryLevel)
                print(UIDevice.current.batteryLevel)
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
