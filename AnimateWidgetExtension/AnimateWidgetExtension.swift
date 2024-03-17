//
//  AnimateWidgetExtension.swift
//  AnimateWidgetExtension
//
//  Created by Danylo Bulanov on 11/27/22.
//

import WidgetKit
import SwiftUI
import Intents
import ClockRotationEffect
import SDWebImageSwiftUI
extension Date {
    func adding(
        _ component: Calendar.Component,
        value: Int,
        in calendar: Calendar = .current
    ) -> Self {
        calendar.date(byAdding: component, value: value, to: self)!
    }
}

struct Provider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), image: UIImage(), step: 0)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, image: UIImage(), step: 0)
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
        
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), image: UIImage(), step: 0)
    }
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let step: Int
    //    let configuration: ConfigurationIntent
}

struct AnimateWidgetExtensionEntryView : View {
    var entry: Provider.Entry
    //let size: CGSize = CGSize(width: 75, height: 75)
    
    var body: some View {
        
        AnimatedView(entry: entry)
        
            .containerBackground(for: .widget) {
                Color.black
            }
        
    }
    
    
}


@main
struct AnimateWidgetExtension: Widget {
    let kind: String = "AnimateWidgetExtension"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AnimateWidgetExtensionEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct AnimateWidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        AnimateWidgetExtensionEntryView(entry: SimpleEntry(date: Date(), image: UIImage(), step: 0))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

struct AnimatedView: View {
    let entry: SimpleEntry
    var body: some View {
        ZStack {
            Text(Date(), style: .timer)
                .font(.custom("test-font-Regular", size: 100))
                .foregroundColor(.blue)
        }
    }
    
}
