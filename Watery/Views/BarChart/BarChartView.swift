import SwiftUI

struct BarChartView: View {
    let barValues : [[CGFloat]] =  [
        [5,150,50,100,200,110,30,170,50],
        [200,110,30,170,50, 100,100,100,200],
        [10,20,50,100,120,90,180,200,40]
    ]
    
    @State var pickerSelection = 0
    
    var body: some View {
        
        VStack {
            Picker(selection: $pickerSelection, label: Text("Stats"))
            {
                Text("Today").tag(0)
                Text(" Week").tag(1)
                Text("Month").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 10)
            
            HStack(alignment: .center, spacing: 10)
            {
                ForEach(barValues[pickerSelection], id: \.self){
                    data in
                    
                    BarView(value: data, cornerRadius: 15.0)
                }
            }.animation(.default)
        }
    }
    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(ColorManager.wateryBlue)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.darkGray], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.darkGray], for: .normal)
    }
}

struct BarView: View{
    
    var value: CGFloat
    var cornerRadius: CGFloat
    
    var body: some View {
        VStack {
            
            ZStack (alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 25, height: 200)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 25, height: value)
                    .foregroundColor(ColorManager.wateryBlue)
                
                
            }
            .padding(.bottom, 8)
            
        }
        
    }
}

struct BarChartView_Previews: PreviewProvider {
    
    static var previews: some View {
        BarChartView()
    }
}
