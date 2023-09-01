//
//  ContentView.swift
//  Bookworm
//
//  Created by Eugene on 01/09/2023.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false


    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
//                        Text(book.title ?? "unknown title")
                        DetailView(book: book)
                    } label : {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                        }
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown title")
                                .font(.headline)
                            Text(book.author ?? "Unknown author")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                }
            }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label : {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
