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
    @State var beats: [String] = []
    @State private var selectedColor = 0
    var colors = ["red", "yellow", "blue", "purple", "green"]
    
    var body: some View {
        ZStack {
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
                }
            }
            .frame(width: UIScreen.main.bounds.size.width*3/4, height: UIScreen.main.bounds.size.height)
            
            VStack {
                Text("Listen Your Art 🎶")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Button(action: {
                    self.setColors(color: bgColor)
                    self.makeArticle(count: articles.count, name: "rectangle", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0, chord: .CMajor, beat: colors[selectedColor])
                    }) {
                        Text("Rectangle")
                        Image("rectangle")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .colorMultiply(bgColor)
                    }
                .padding()
                .frame(width: UIScreen.main.bounds.size.width*1/6, height: 40)
                .background(.white)
                .cornerRadius(15)

                
                
                Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "triangle", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0, chord: .DMajor, beat: colors[selectedColor])
                    }) {
                        Text("Triangle")
                        Image("triangle")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .colorMultiply(bgColor)
                    }
                .padding()
                .frame(width: UIScreen.main.bounds.size.width*1/6, height: 40)
                .background(.white)
                .cornerRadius(15)

                
                Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "circle", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0, chord: .FMajor, beat: colors[selectedColor])
                    }) {
                        Text("Circle")
                        Image("circle")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .colorMultiply(bgColor)
                    }
                .padding()
                .frame(width: UIScreen.main.bounds.size.width*1/6, height: 40)
                .background(.white)
                .cornerRadius(15)

                    
                Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "star", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0, chord: .GMajor, beat: colors[selectedColor])
                    
                    }) {
                        Text("Star")
                        Image("star")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .colorMultiply(bgColor)
                    }
                .padding()
                .frame(width: UIScreen.main.bounds.size.width*1/6, height: 40)
                .background(.white)
                .cornerRadius(15)
   
                Button(action: {
                        self.setColors(color: bgColor)
                        self.makeArticle(count: articles.count, name: "heart", location: CGPoint(x: 0, y: 0) , rotate: Angle(degrees: 0.0), scale: 1.0, chord: .EMajor, beat: colors[selectedColor])
                    
                    }) {
                        Text("Heart")
                        Image("heart")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .colorMultiply(bgColor)
                    }
                .padding()
                .frame(width: UIScreen.main.bounds.size.width*1/6, height: 40)
                .background(.white)
                .cornerRadius(15)
                
                
                ColorPicker("Color", selection: $bgColor)
                .foregroundColor(.white)
                .frame(width: 100)
                .padding()
                
                HStack {
                    
                    Button(action: {
                        self.playChords(chords:chords)
    //                    self.playBeats(beats:beats)
    //                    SoundManager.instance.playSound(sounds: .CMajor)
    //                    SoundManager.instance.playSound(sounds: .DMajor)
                    }){
                        Image(systemName: "play.fill")
                    }
                    .foregroundColor(.white)
                    .imageScale(.large)
                    .padding(100)
                    
                    Button(action: {
                        self.removeArticles()
                    }){
                        Image(systemName: "arrow.clockwise")
                    }
                    .foregroundColor(.white)
                    .imageScale(.large)
                    .padding(100)

                }
                .frame(width: 50)
                
                
                
                
            }
            .frame(width: UIScreen.main.bounds.size.width*1/4, height: UIScreen.main.bounds.size.height)
            .background(.green)
            .offset(x: -UIScreen.main.bounds.size.width*1/2.6)
            
        }
    }
    
    func makeArticle(count: Int, name:String, location: CGPoint, rotate: Angle, scale: CGFloat, chord: SoundManager.soundOption, beat: String) {
        let name: String = name
        let location: CGPoint = location
        let rotate: Angle = rotate
        let scale: CGFloat = scale
        let chord: SoundManager.soundOption = chord
        let beat: String = beat

        articles.append(name)
        currentScales.append(scale)
        angles.append(rotate)
        locations.append(location)
        chords.append(chord)
        beats.append(beat)
    }
    
    
    func setColors(color: Color) {
        let color: Color = color
        bgColors.append(color)
        print(beats)
    }
    
    func playChords(chords: [SoundManager.soundOption]) {
        let chords: [SoundManager.soundOption] = chords
        
            for number in 0..<chords.count {
            SoundManager.instance.playSound(sounds: chords[number])
            sleep(1)
            }
            
        print(chords)
        
    }
    
    func playBeats(beats: [String]) {
        let beats: [String] = beats
        
            for number in 0..<chords.count {
            SoundManager.instance.playBeat(beats: beats[number])
            sleep(1)
            }
            
        print(beats)
        
    }
    
    func removeArticles() {
        articles.removeAll()
        chords.removeAll()
        beats.removeAll()
        currentScales.removeAll()
        angles.removeAll()
        locations.removeAll()
        bgColors.removeAll()
        
    }

    
    
}
