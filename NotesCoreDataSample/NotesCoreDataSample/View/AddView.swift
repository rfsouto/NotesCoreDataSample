//
//  AddView.swift
//  NotesCoreDataSample
//
//  Created by rfsouto on 3/2/24.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var model : ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            Text(model.updateItem != nil ? "Edit Note" : "Add note")
                .font(.largeTitle)
                .bold()
            Spacer()
            TextEditor(text: $model.text)
            Divider()
            DatePicker("Select Date", selection: $model.date)
            Spacer()
            Button(action:{
                if model.updateItem != nil{
                    model.editData(context: context)
                }else{
                    model.saveData(context: context)
                }
            })
            {
                Label(
                    title: {Text("Save").foregroundColor(.white).bold()},
                    icon: {Image(systemName: "plus").foregroundColor(.white)}
                )
            }.padding()
            .frame(width: UIScreen.main.bounds.width - 30)
            .background(model.text == "" ? Color.gray : Color.blue)
            .cornerRadius(8)
            .disabled(model.text == "" ? true : false)
            
            
        }.padding()
    }
}

#Preview {
    AddView(model:ViewModel())
}
