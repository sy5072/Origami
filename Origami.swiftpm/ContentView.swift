import SwiftUI

struct ContentView: View {
//    @State private var rectPosition = CGPoint(x: 50, y: 50)
//    @State private var rectPosition2 = CGPoint(x: 70, y: 50)
//    @State private var rectPosition3 = CGPoint(x: 90, y: 50)
//    @State private var rectPosition4 = CGPoint(x: 90, y: 50)
    
    @State var currentScales: [CGFloat] = []
//    @State var angle = Angle(degrees: 0.0)
    @State var angles: [Angle] = []
    @State var locations: [CGPoint] = []
    @GestureState private var startLocation: CGPoint? = nil
    @State var i :Int = 0
    @State var bgColors: [Color] = []
    @State private var bgColor =
            Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    
    @State var articles: [String] = []
    
//    var magnification: some Gesture {
//        MagnificationGesture()
//            .onChanged { value in
//                self.currentScale = value
//            }
//    }
    
//    var rotation: some Gesture {
//        RotationGesture()
//            .onChanged { angle in
//                self.angle = angle
//            }
//    }
    
//    var drag: some Gesture {
//        DragGesture()
//            .onChanged { value in
//                var newLocation = startLocation ?? location // 3
//                newLocation.x += value.translation.width/currentScale
//                newLocation.y += value.translation.height/currentScale
//                self.location = newLocation
//            }
//            .updating($startLocation) { (value, startLocation, transaction) in
//                startLocation = startLocation ?? location // 2
//            }
//    }
    
    var body: some View {
        HStack {
            VStack {
                    Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "rectangle", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0)

                        print(articles)
                        print(locations)
                    }) {
                        Text("Rectangle")
                    }
                    Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "triangle", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0)

                        print(articles)
                    }) {
                        Text("Triangle")
                    }
                    Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "circle", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0)
                        print(articles)
                    }) {
                        Text("Circle")
                    }
                    
                    Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "star", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0)
                        print(articles)
                    }) {
                        Text("Star")
                    }
                
                    ColorPicker("Color", selection: $bgColor)
                    .foregroundColor(.white)
                    .frame(width: 100)
                
            }
            .frame(width: UIScreen.main.bounds.size.width*1/4, height: UIScreen.main.bounds.size.height)
            .background(.green)
            ZStack {
                
                ForEach(articles.indices, id: \.self) { i in
                    
                    Image(articles[i])
                        .resizable()
                        .rotationEffect(angles[i])
                        .position(locations[i])
                        .gesture(RotationGesture()
                            .onChanged { angle in
                                self.angles[i] = angle
                            })
                        .scaleEffect(currentScales[i])
                        .simultaneousGesture(MagnificationGesture()
                            .onChanged { value in
                                self.currentScales[i] = value
                            })
                        .simultaneousGesture(DragGesture()
                            .onChanged { value in
                                var newLocation = startLocation ?? locations[i] // 3
                                newLocation.x += value.translation.width/currentScales[i]
                                newLocation.y += value.translation.height/currentScales[i]
                                self.locations[i] = newLocation
                            }
                            .updating($startLocation) { (value, startLocation, transaction) in
                                startLocation = startLocation ?? locations[i] // 2
                            })
                        .colorMultiply(bgColors[i])
                        .frame(width: 150, height: 150)
                        
                    
//                    self.i += 1
//                    .listRowBackground(Color.clear)
//                    .listRowSeparator(.hidden)
                    
                }
            }
            .frame(width: UIScreen.main.bounds.size.width*3/4, height: UIScreen.main.bounds.size.height)
        }
    }
    
    func makeArticle(count: Int, name:String, location: CGPoint, rotate: Angle, scale: CGFloat) {
        let name: String = name
        let location: CGPoint = location
        let rotate: Angle = rotate
        let scale: CGFloat = scale
//        let count: Int = count
        
//        let article = Article(id: count, name: name, location: location, rotate: rotate, scale: scale)
        articles.append(name)
        currentScales.append(scale)
        angles.append(rotate)
        locations.append(location)
//        articles.append(article)
    }
    
    func setColors(color: Color) {
        let color: Color = color
        
        bgColors.append(color)
    }
    
}
