//
//  ContentView.swift
//  API Calling Project
//
//  Created by Student on 2/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var entries = [Entry]()
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            List(entries) { entry in
                NavigationLink(
                    destination: VStack {
                        Text(entry.title)
                        Text(entry.link)
                            .padding()
                    },
                    label: {
                        Text(entry.title)
                    })
            }
            .navigationTitle("Corn Dog")
        }
        .onAppear(perform: {
            getDog()
            
        })
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("OK")))
        })
    }
    
    func getDog() {
        let apiKey =
            "?rapidapi-key=d87dc96880msh138dad116ed364ep17b762jsnfa65120c7d18"
        let query = "https://google-search3.p.rapidapi.com/api/v1/search/q=corn+dog&num=100\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                    let contents = json["results"].arrayValue
                    for item in contents {
                        let title = item["title"].stringValue
                        let link = item["link"].stringValue
                        let entry = Entry(title: title, link: link)
                        entries.append(entry)
                    }
                    return
            }
        }
        showingAlert = true
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    struct Entry : Identifiable {
        let id = UUID()
        var title : String
        var link : String
    }
}
