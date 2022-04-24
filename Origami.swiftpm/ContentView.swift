import SwiftUI

struct ContentView: View {
    @State private var rectPosition = CGPoint(x: 50, y: 50)
    @State private var rectPosition2 = CGPoint(x: 70, y: 50)
    @State private var rectPosition3 = CGPoint(x: 90, y: 50)
    @State private var rectPosition4 = CGPoint(x: 90, y: 50)
    
    @State var currentScale: CGFloat = 1.0
    @State var angle = Angle(degrees: 0.0)
    @State var isDragging = false
    @State var offset = CGSize.zero
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    @GestureState private var startScale: CGFloat? = nil
    

    
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                var newScale = currentScale
                self.currentScale = value
            }
//            .updating($startScale) { (value, startScale, transaction) in
//                startScale = startScale ?? currentScale // 2
//            }
    }
    
    var rotation: some Gesture {
        RotationGesture()
            .onChanged { angle in
                self.angle = angle
            }
    }
    
//    var drag: some Gesture {
//        DragGesture()
//            .onChanged { _ in self.isDragging = true}
//            .onEnded { _ in self.isDragging = false}
//    }
//
//    var drag: some Gesture {
//        DragGesture()
//            .onChanged { value in
////                offset = value.translation
//                rectPosition = value.translation
//            }
//            .onEnded { _ in
////                 offset = .zero
//            }
//    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location // 3
                newLocation.x += value.translation.width/currentScale
                newLocation.y += value.translation.height/currentScale
                self.location = newLocation
            }
            .updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location // 2
            }
    }

    var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
    }
    
    var body: some View {
        HStack {
            Button(action: {
                self.addRectangle()
            }) {
                Text("Rectangle")
            }
            
            ZStack {
                Image("rectangle2")
                    .resizable()
                    .rotationEffect(angle)
                    .position(location)
//                    .gesture(DragGesture().onChanged({ value in
//                        self.rectPosition = value.location
//                    }))
                    .gesture(rotation)
//                    .offset(x: offset.width, y: offset.height)
//                    .simultaneousGesture(DragGesture().onChanged({ value in
//                        self.rectPosition = value.location
//                    }))
//                    .background(.green)
                    .scaleEffect(currentScale)
                    .simultaneousGesture(magnification)
                    .simultaneousGesture(
                            simpleDrag
//                                .simultaneously(with: fingerDrag)
                    )
                    
//                    .gesture(DragGesture().onChanged({ value in
//                        self.rectPosition = value.location
//                    }))
                    
//                    .gesture(drag)
//                    .simultaneousGesture(rotation)
                    .colorMultiply(.red)
                    .frame(width: 150, height: 150)
                    
                    
                
                    
//                    .gesture(magnification)
                    
                
            
               
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


