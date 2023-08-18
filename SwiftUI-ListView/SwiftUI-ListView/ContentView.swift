//
//  ContentView.swift
//  SwiftUI-ScrollView
//
//  Created by Andy Peters on 8/16/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var entries : Names
    
    @State private var textFieldValue : String = ""
    
    @State private var thisone : Int = 0
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            TextField("Enter a label", text: $textFieldValue)
                .help("This is where you enter a new label or change an existing one")
                .frame(width: 200, height:40)
            Text("Selected index: \(thisone)")
            HStack {
                Button("Update", action: updateThisInArray)
                    .help("Change the name of the selected string to what's in the text field")
                Button("Insert", action: insertThisIntoArray)
                    .help("Insert text field contents into current position in array")
                Button("Append", action: appendThisToArray)
                    .help("Append text field contents to end of array")
                Button("Delete", action: removeThisFromArray)
                    .help("Delete the current selection from the array")
                Button("Clear", action: clearEntireArray)
                    .help("Clear all entries from array")
            }
            List {
                ForEach(0..<entries.names.count, id: \.self) { index in
                    Text("\(entries.names[index])")
                        .background( (index == thisone) ? .red : .white)
                        .foregroundColor( (index == thisone) ? .white : .black)
                        .onTapGesture {
                            thisone = index
                            print("You tapped entry at \(index) = \(entries.names[index])")
                            textFieldValue = entries.names[index]
                        }
                }
            }
        
        }
        .padding()
    }
    
    /* change the currently-selected item in the array. */
    func updateThisInArray() {
        print("in updateThisInArray")
        print("Number of entries in the array: \(entries.names.count)")
        /* If there are no entries in the array, we need to append. Otherwise we
         * change the string at the current selection. */
        if entries.names.isEmpty {
            entries.names.append(textFieldValue)
        } else {
            print("Updating \(thisone) to \(textFieldValue)")
            entries.names[thisone] = textFieldValue
        }
    }
    
    /* insert the text field contents into the array at the currently-
     selected position, and shift everything else down one */
    func insertThisIntoArray() {
        print("In insertThisIntoArray, selection = \(thisone)")
        /* If the list is empty, simply append. Otherwise, just insert the
         * next string after the current selection. */
        if entries.names.isEmpty {
            entries.names.append(textFieldValue)
        } else {
            print("Inserting")
            entries.names.insert(textFieldValue, at: thisone)
        }
        
    }
    
    /* Add the string in the text field to the end of the array*/
    func appendThisToArray() {
        print("In addThisToArray: appending \(textFieldValue)")
        entries.names.append(textFieldValue)
    }
    
    /* remove the currently-selected item from the array */
    func removeThisFromArray() {
        print("In removeThisFromArray, deleting \(thisone)")
        guard !entries.names.isEmpty else {
            print("Nothing to delete")
            return
        }
        
        /* if there's only one element in the array, delete it and
         * then set the text field to empty to reflect nothing in the array */
        if entries.names.count == 1 {
            textFieldValue = ""
            entries.names.remove(at: thisone)
            /* print to verify empty array */
            print("After remove of last entry in array, it's empty. array = \(entries.names)")
        } else {
            /* Will we delete the entry at the end of the list?
             * If so, we want to set the selector to the entry before that one,
             * and also fill the text box with the contents of that new selector.
             */
            if thisone == entries.names.count - 1 {
                thisone -= 1
                textFieldValue = entries.names[thisone]
                entries.names.remove(at: entries.names.count - 1)
                print("We deleted entry at end of list.")
            } else {
                /* we're somewhere in the middle of the array, so we can remove the
                 * currently-selected item without trouble. The selector remains
                 * the same so the text field and list will auto update properly. */
                entries.names.remove(at: thisone)
                print("deleted entry at \(thisone)")
                textFieldValue = entries.names[thisone]
            }
        }
    }
    
    /* clear everything from the array */
    func clearEntireArray() {
        print("In clearEntireArray")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Names(key: "ListEntries"))
    }
}
