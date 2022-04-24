import SwiftUI
import AVKit

struct ContentView: View {
    
    @State var currentScales: [CGFloat] = []
    @State var angles: [Angle] = []
    @State var locations: [CGPoint] = []
    @GestureState private var startLocation: CGPoint? = nil
    @State var i :Int = 0
    @State var bgColors: [Color] = []
    @State private var bgColor =
            Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State var articles: [String] = []
    @State var chords: [SoundManager.soundOption] = []
    @State var soundReady: Bool? = false
    
    
    var body: some View {
        HStack {
            VStack {
                Button(action: {
                        self.setColors(color: bgColor)
                    self.makeArticle(count: articles.count, name: "rectangle", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0, chord: .CMajor)

                        print(articles)
                        print(locations)
                    }) {
                        Text("Rectangle")
                        Image("rectangle")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .colorMultiply(.red)
                    }
                .padding()
                .frame(width: UIScreen.main.bounds.size.width*1/6, height: 40)
                .background(.white)
                .cornerRadius(15)

                
                
                Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "triangle", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0, chord: .DMajor)

                        print(articles)
                    }) {
                        Text("Triangle")
                        Image("triangle")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .colorMultiply(.orange)
                    }
                .padding()
                .frame(width: UIScreen.main.bounds.size.width*1/6, height: 40)
                .background(.white)
                .cornerRadius(15)

                
                Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "circle", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0, chord: .FMajor)
                        print(articles)
                    }) {
                        Text("Circle")
                        Image("circle")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .colorMultiply(.blue)
                    }
                .padding()
                .frame(width: UIScreen.main.bounds.size.width*1/6, height: 40)
                .background(.white)
                .cornerRadius(15)

                    
                Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "star", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0, chord: .GMajor)
                        print(articles)
                    
                    }) {
                        Text("Star")
                        Image("star")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .colorMultiply(.yellow)
                    }
                .padding()
                .frame(width: UIScreen.main.bounds.size.width*1/6, height: 40)
                .background(.white)
                .cornerRadius(15)
   
                Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "heart", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0, chord: .EMajor)
                        print(articles)
                    
                    }) {
                        Text("Heart")
                        Image("heart")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .colorMultiply(.pink)
                    }
                .padding()
                .frame(width: UIScreen.main.bounds.size.width*1/6, height: 40)
                .background(.white)
                .cornerRadius(15)
                
                
                ColorPicker("Color", selection: $bgColor)
                .foregroundColor(.white)
                .frame(width: 100)
                .padding()
                
                
                Button(action: {
                    self.playMusic(chords:chords)
//                    SoundManager.instance.playSound(sounds: .CMajor)
//                    SoundManager.instance.playSound(sounds: .DMajor)
                }){
                    Image(systemName: "play.fill")
                }
                .foregroundColor(.white)
                .imageScale(.large)
                .padding(100)
//                .frame(width: 100, height: 50)
                
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
                        .zIndex(-1)
                    
                }
            }
            .frame(width: UIScreen.main.bounds.size.width*3/4, height: UIScreen.main.bounds.size.height)
        }
    }
    
    func makeArticle(count: Int, name:String, location: CGPoint, rotate: Angle, scale: CGFloat, chord: SoundManager.soundOption) {
        let name: String = name
        let location: CGPoint = location
        let rotate: Angle = rotate
        let scale: CGFloat = scale
        let chord: SoundManager.soundOption = chord

        articles.append(name)
        currentScales.append(scale)
        angles.append(rotate)
        locations.append(location)
        chords.append(chord)
    }
    
    func setColors(color: Color) {
        let color: Color = color
        
        bgColors.append(color)
    }
    
    func playMusic(chords: [SoundManager.soundOption]) {
        let chords: [SoundManager.soundOption] = chords
        
            for number in 0..<chords.count {
            print("delayed message")
            SoundManager.instance.playSound(sounds: chords[number])
                sleep(1)
            
            }
            
        print(chords)
        
    }
    
    
    
}
