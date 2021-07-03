//
//  SearchView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    @State var inSearchMode = false
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView {
            
            // searchbar

            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            
            //grid view/user list view
            
            ZStack(alignment: .leading) {
                if inSearchMode {
                    UserListView(viewModel: viewModel, searchTextBinding: $searchText)
                } else {
                    PostGridView(config: .explore)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
