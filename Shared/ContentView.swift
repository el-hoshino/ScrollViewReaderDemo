//
//  ContentView.swift
//  Shared
//
//  Created by 史 翔新 on 2021/04/22.
//

import SwiftUI

struct SectionJumper<Section: Identifiable & Hashable, SectionButtonView: View>: View {
    
    var proxy: ScrollViewProxy
    var sections: [Section]
    var sectionButtonView: (Section) -> SectionButtonView
    
    var body: some View {
        HStack {
            ForEach(sections) { section in
                Button {
                    withAnimation {
                        proxy.scrollTo(section, anchor: .top)
                    }
                } label: {
                    sectionButtonView(section)
                }
            }
        }
    }
}

struct SectionedPicker<Section: Identifiable & Hashable, SectionContent: Identifiable & Hashable, SectionHeaderView: View, SectionContentView: View>: View {
    
    var sections: [Section]
    @Binding var selected: SectionContent?
    
    var sectionContents: (Section) -> [SectionContent]
    var sectionHeaderView: (Section) -> SectionHeaderView
    var sectionContentView: (SectionContent) -> SectionContentView
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(sections) { section in
                    SwiftUI.Section(header: sectionHeaderView(section).id(section)) {
                        ForEach(sectionContents(section)) { content in
                            Button {
                                selected = content
                            } label: {
                                sectionContentView(content)
                            }
                            .id(content)
                        }
                    }
                }
            }
            .onAppear(perform: {
                proxy.scrollTo(selected, anchor: .center)
            })
        }
    }
    
}

struct Content: Identifiable, Hashable {
    let id = UUID()
    var contentTitle: String
}

struct Section: Identifiable, Hashable {
    let id = UUID()
    var sectionTitle: String
    var contents: [Content]
}

let demoSections: [Section] = [
    .init(sectionTitle: "A", contents: [
        .init(contentTitle: "i"),
        .init(contentTitle: "j"),
        .init(contentTitle: "k"),
    ]),
    .init(sectionTitle: "B", contents: [
        .init(contentTitle: "l"),
        .init(contentTitle: "m"),
        .init(contentTitle: "n"),
    ]),
    .init(sectionTitle: "C", contents: [
        .init(contentTitle: "x"),
        .init(contentTitle: "y"),
        .init(contentTitle: "z"),
    ]),
    .init(sectionTitle: "D", contents: [
        .init(contentTitle: "1"),
        .init(contentTitle: "2"),
        .init(contentTitle: "3"),
        .init(contentTitle: "4"),
        .init(contentTitle: "5"),
        .init(contentTitle: "6"),
        .init(contentTitle: "7"),
        .init(contentTitle: "8"),
        .init(contentTitle: "9"),
    ]),
    .init(sectionTitle: "E", contents: [
    ]),
    .init(sectionTitle: "F", contents: [
    ]),
    .init(sectionTitle: "G", contents: [
        .init(contentTitle: "0"),
    ]),
]

struct ContentView: View {
    
    var sections: [Section] = demoSections
    @State private var selected: Content?
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                
                SectionJumper(proxy: proxy, sections: sections) {
                    Text($0.sectionTitle)
                }
                
                SectionedPicker(sections: sections, selected: $selected) {
                    $0.contents
                } sectionHeaderView: {
                    Text($0.sectionTitle)
                } sectionContentView: {
                    Text($0.contentTitle)
                }
                
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
