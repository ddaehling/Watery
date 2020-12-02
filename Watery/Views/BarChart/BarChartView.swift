import SwiftUI
import ComposableArchitecture

struct BarChartState: Equatable {
    var barValues : [[Double]] = [[]]
    var filteredBarValues : [Double] {
        get { barValues[selectedTab] }
    }
    var selectedTab : Int = 0
}

enum BarChartAction: Equatable {
    case selectTab(Int)
}

struct BarChartEnvironment {}

struct BarChartView: View {
    let store: Store<BarChartState, BarChartAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Picker(selection: viewStore.binding(get: { $0.selectedTab }, send: BarChartAction.selectTab), label: Text("Stats")) {
                    Text("Today").tag(0)
                    Text(" Week").tag(1)
                    Text("Month").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 10)
                HStack(alignment: .center, spacing: 10) {
                    ForEach(viewStore.filteredBarValues, id: \.self) { data in
                        BarView(value: data, cornerRadius: 15)
                    }
                }.animation(.default)
            }
        }
    }
    
    
}



struct BarChartView_Previews: PreviewProvider {
    
    static var previews: some View {
        BarChartView(
            store: Store(
                initialState: BarChartState(
                    barValues: [
                        [5,150,50,100,200,110,30,170,50],
                        [200,110,30,170,50, 100,100,100,200],
                        [10,20,50,100,120,90,180,200,40]
                    ],
                    selectedTab: 0),
                reducer: .empty,
                environment: BarChartEnvironment()))
    }
}
