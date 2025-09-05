//
//  StructClassActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by jyotirmoy_halder on 5/9/25.
//

/*
 
 VALUE TYPES:
 - Struct, Enum, String, Int, etc.
 - Stored in the Stack
 - Faster
 - Thread safe!
 - When you assign or pass value type a new copy of data is created
 
 REFERENCE TYPES:
 - Class, Function, Actor
 - Stored in the Heap
 - Slower, but synchronized
 - NOT Thread safe
 - When you assign or pass reference type a new reference to original instance will be created (pointer)
 
 -  - - - - - -  - - - - - - - -
 
 STACK:
 - Stores Value types
 - Variable allocated on teh stack are stored directly to teh memory, and access to this memory is very fast
 - Each thread has it's own stack
 
 HEAP:
 - Stores Reference types
 - Shared across threads
 
  - - - - - - - - - - - - - - - -
 
 STRUCT:
 - Based ON VALUES
 - Stored in the Heap!
 - Inherit from other classes
 
 CLASS:
 - Based on REFERENCES (INSTANCES)
 - Store in the Heap!
 - Inherit from other classes
 
 ACTOR:
 - Some as Class, but thread safe!
 
 - - - - - - - - - - - - - - - -
 
 Structs: Data Models, Views
 Classes: ViewModels
 Actors: Shared 'Manager' and 'Date Stores'

 */

import SwiftUI

actor StructClassActorBootcampDataManager {
    
    func getDataFromDatabase() {
        
    }
}

class StructClassActorBootcampViewModel: ObservableObject {
    
    @Published var title: String = ""
    
    init() {
        print("ViewModel INIT")
    }
}

struct StructClassActorBootcamp: View {
    
    @StateObject private var viewModel = StructClassActorBootcampViewModel()
    let isActive: Bool
    
    init(isActive: Bool) {
        self.isActive = isActive
        print("View INIT")
    }
    
    var body: some View {
        Text("Hello, World!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(isActive ? Color.red : Color.blue)
            .onAppear() {
//                runText()
            }
    }
}

struct StructClassActorBootcampHomeView: View {
    
    @State private var isActive: Bool = false
    
    var body: some View {
        StructClassActorBootcamp(isActive: isActive)
            .onTapGesture {
                isActive.toggle()
            }
    }
}

#Preview {
    StructClassActorBootcamp(isActive: true)
}




extension StructClassActorBootcamp {
    private func runText() {
        print("Text Started")
        structText1()
        printDivider()
        classText1()
        printDivider()
        actorTest1()
        
//        structText2()
//        printDivider()
//        classTest2()
    }
    
    private func printDivider() {
        print("""
            
            ---------------------------------------------
            
            """)
    }
    private func structText1() {
        print("Struct test 1")

        let objectA = MyStruct(title: "Starting title!")
        print("ObjectA: ", objectA.title)
        
        print("Pass the VALUES of objectA to objectB.")
        var objectB = objectA
        print("ObjectB: ", objectB.title)
        
        objectB.title = "Second title!"
        print("ObjectB title changes.")
        
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
        
    }
    
    private func classText1() {
        print("Class test 1")
        let objectA = MyClass(title: "Starting title!")
        print("ObjectA: ", objectA.title)
        
        print("Pass the reference of objectA to objectB")
        let objectB = objectA
        print("ObjectB: ", objectB.title)
        
        objectB.title = "Second title!"
        print("ObjectB title changes.")
        
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
    }
    
    private func actorTest1() {
        Task {
            print("actorTest1")
            let objectA = MyActor(title: "Starting title!")
            await print("ObjectA: ", objectA.title)
            
            print("Pass the reference of objectA to objectB")
            let objectB = objectA
            await print("ObjectB: ", objectB.title)
            
            await objectB.updateTitle(newTitle: "second title")
            print("ObjectB title changes.")
            
            await print("ObjectA: ", objectA.title)
            await print("ObjectB: ", objectB.title)
        }
    }
}

struct MyStruct {
    var title: String
}

// Immutable struct
struct CustomStruct {
    let title: String
    
    func updateTitle(newTitle: String) -> CustomStruct {
        CustomStruct(title: newTitle)
    }
}


struct MutatingStruct {
    private(set) var title: String
    
    init(title: String) {
        self.title = title
    }
    
    mutating func updateTitle(newTitle: String) {
        title = newTitle
    }
}

extension StructClassActorBootcamp {
    
    private func structText2() {
        print("structTest2")
        
        var struct1 = MyStruct(title: "Title 1")
        print("Struct1: ", struct1.title)
        struct1.title = "Title 2"
        print("Struct1: ", struct1.title)
        
        var struct2 = CustomStruct(title: "Title 1")
        print("Struct2: ", struct2.title)
        struct2 = CustomStruct(title: "Title 2")
        print("Struct2: ", struct2.title)
        
        var struct3 = CustomStruct(title: "Title 1")
        print("Struct3: ", struct3.title)
        struct3 = struct3.updateTitle(newTitle: "Title 2")
        print("Struct3: ", struct3.title)
        
        var struct4 = MutatingStruct(title: "Title 1")
        print("Struct4: ", struct4.title)
        struct4.updateTitle(newTitle: "Title 2")
        print("Struct4: ", struct4.title)
    }
}

class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
}

actor MyActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
}

extension StructClassActorBootcamp {
    
    private func classTest2() {
        print("classTest2")
        
        let class1 = MyClass(title: "Title 1")
        print("Class1: ", class1.title)
        class1.title = "Title 2"
        print("Class1: ", class1.title)
        
        let class2 = MyClass(title: "Title 1")
        print("Class2: ", class2.title)
        class2.updateTitle(newTitle: "Title 2")
        print("Class2: ", class2.title)
    }
}
