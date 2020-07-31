//
//  ContentView.swift
//  PullDownToRefreshDemo
//
//  Created by Derek Chan on 2020/7/31.
//

import SwiftUI
import BBSwiftUIKit

struct ContentView: View {
    @State var list: [Int] = (0..<50).map { $0 }
    @State var isRefreshing: Bool = false
    @State var isLoadingMore: Bool = false
    
    var body: some View {
        BBTableView(list) { i in
            Text("Text \(i)")
                .padding()
                .background(Color.blue)
        }
        
        .bb_setupRefreshControl({ (control) in
            control.tintColor = .blue
            control.attributedTitle = NSAttributedString(string: "加载中", attributes: [.foregroundColor: UIColor.blue])
        })
        
        .bb_pullDownToRefresh(isRefreshing: $isRefreshing) {//下拉刷新
            print("Refresh")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                list = (0..<50).map { $0 }//下拉重置数据
                isRefreshing = false
            }
        }
        .bb_pullUpToLoadMore(bottomSpace: 30/*间距小于等于30的时候触发*/) { //上划加载更多
            if isLoadingMore || list.count >= 100 {
                return
            }
            isLoadingMore = true
            print("Load More")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                //上拉加载更多
                let more = list.count..<list.count + 10
                list.append(contentsOf: more)
                isLoadingMore = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
