//
//  ContentView.swift
//  Wishlist
//
//  Created by user on 1/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes : [Wish]
    
    @State private var isAlertShowing : Bool = false
    @State private var title : String  = ""
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(wishes){ wish in
                    Text(wish.title).font(.title.weight(.light))
                        .padding(.vertical,2).swipeActions{
                            Button("Delete",role : .destructive){
                                modelContext.delete(wish)
                            }
                        }
                }
            }
            .toolbar{
                ToolbarItem(placement : .topBarTrailing){
                    Button{
                        isAlertShowing.toggle()
                    } label :{
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                    
                }
                
                if wishes.isEmpty != true{
                    ToolbarItem(placement : .bottomBar){
                        Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")")
                    }
                }
            }
            .alert("Create a new wish", isPresented: $isAlertShowing){
                TextField("Enter a wish", text: $title)
                
                Button{
                    modelContext.insert(Wish(title: title))
                    title = ""
                } label:{
                    Text("Save")
                }
            }
            .navigationTitle("WishList")
                .overlay{
                    if wishes.isEmpty{
                        ContentUnavailableView(
                            "My WishList", systemImage: "heart.circle",
                            description: Text("No wishes yet. Add one to get Started")
                        )
                    }}
        }
    }
}


#Preview("List with Sample Data"){
    let container = try! ModelContainer(for : Wish.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true))
                                        
    container.mainContext.insert(Wish(title: "Master Swift Data"))
    container.mainContext.insert(Wish(title: "Master JetPack compose Data"))
    container.mainContext.insert(Wish(title: "Master Kotlin Data"))
    container.mainContext.insert(Wish(title: "Master Flutter Data"))
    

   return ContentView().modelContainer(container)
}

#Preview("Empty List") {
    ContentView().modelContainer(for:Wish.self, inMemory: true)
}
