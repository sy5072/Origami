import SwiftUI

struct ContentView: View {
    @State private var rectPosition = CGPoint(x: 50, y: 50)
    @State private var rectPosition2 = CGPoint(x: 70, y: 50)
    @State private var rectPosition3 = CGPoint(x: 90, y: 50)
    @State private var rectPosition4 = CGPoint(x: 90, y: 50)
    
//    @GestureState var scale = 1.0
    @State var currentScale: CGFloat = 1.0
    @State var finalScale: CGFloat = 1.0

//    var magnification: some Gesture {
//        MagnificationGesture()
//            .updating($scale) {currentState, gestureState, transaction in gestureState = currentState
//            }
//    }
    
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                currentScale = value
            }
//            .onEnded { value in
//                finalScale = value
//
//            }
    }
    
    
    var body: some View {
        HStack {
            Button(action: {
                self.addRectangle()
            }) {
                Text("Rectangle")
            }
            
            VStack {
                Image("rectangle2")
                    .resizable()
                    .scaleEffect(currentScale)
                    .colorMultiply(.red)
                    .frame(width: 150, height: 150)
                    .position(rectPosition)
                    .gesture(DragGesture().onChanged({ value in
                        self.rectPosition = value.location
                    }))
                    .gesture(magnification)
                
                RoundedRectangle(cornerRadius: 4.0)
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                    .position(rectPosition2)
                    .gesture(DragGesture().onChanged({ value in
                        self.rectPosition2 = value.location
                    }))
                RoundedRectangle(cornerRadius: 4.0)
                    .fill(Color.blue)
                    .frame(width: 80, height: 80)
                    .position(rectPosition3)
                    .gesture(DragGesture().onChanged({ value in
                        self.rectPosition3 = value.location
                    }))
                Circle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
                    .position(rectPosition4)
                    .gesture(DragGesture().onChanged({ value in
                        self.rectPosition4 = value.location
                    }))
               
            }
        }
    }
    
    func addRectangle() {
        RoundedRectangle(cornerRadius: 4.0)
            .fill(Color.green)
            .frame(width: 150, height: 150)
            .position(CGPoint(x: 50, y: 50))
            .gesture(DragGesture().onChanged({ value in
                self.rectPosition = value.location
            }))
    }
}


