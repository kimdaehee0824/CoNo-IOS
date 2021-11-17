//
//  CovidDeshBoard.swift
//  CovidDeshBoard
//
//  Created by 김대희 on 2021/11/16.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), decideCount: String())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), decideCount: String())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {

        }

        for hourOffset in 0 ..< 5 {
//            dateGet()
            let DataString = "\(String(describing: CovidData.data.requstSecideCount()))명"
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, decideCount: DataString)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let  decideCount : String
    
}

struct CovidDeshBoardEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        
        VStack {
            Text(entry.decideCount)
            Text(entry.date, style: .time)
        }
    }
}

@main
struct CovidDeshBoard: Widget {
    let kind: String = "CovidDeshBoard"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CovidDeshBoardEntryView(entry: entry)
        }
        .configurationDisplayName("코로나 상황판")
        .description("오늘의 코로나 상황을 알려주는 위젯입니다.")
        .supportedFamilies([.systemMedium])
    }
}

struct CovidDeshBoard_Previews: PreviewProvider {
    static var previews: some View {
        CovidDeshBoardEntryView(entry: SimpleEntry(date: Date(), decideCount: String()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
