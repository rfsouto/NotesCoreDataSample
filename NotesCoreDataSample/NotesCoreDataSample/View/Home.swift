//
//  Home.swift
//  NotesCoreDataSample
//
//  Created by rfsouto on 3/2/24.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .spring()) var notesResults : FetchedResults<Notes>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(notesResults){ item in
                    VStack(alignment: .leading, content: {
                        Text(item.text ?? "No text")
                            .font(.title)
                            .bold()
                        Text(item.date ?? Date(), style:.date)
                    }).contextMenu(menuItems: {
                        Button(action:{
                            model.sendData(item: item)
                        }){
                            Label(title:{
                                Text("Edit")
                            }, icon:{
                                Image(systemName: "pencil")
                            })
                        }
                        Button(action:{
                            model.deleteData(item: item, context: context)
                        }){
                            Label(title:{
                                Text("Delete")
                            }, icon:{
                                Image(systemName: "trash")
                            })
                        }
                    })
                }
            }.navigationBarTitle("Notes")
                .navigationBarItems(trailing: Button(action:{
                    model.text = ""
                    model.date = Date()
                    model.show.toggle()
                }){
                    Image(systemName: "plus")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }).sheet(isPresented: $model.show, content: {
                    AddView(model: model)
                })
        }
    }
}

#Preview {
    Home()
}
