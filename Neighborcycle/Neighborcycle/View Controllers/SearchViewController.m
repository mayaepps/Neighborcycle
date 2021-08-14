//
//  SearchViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/13/21.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "Post.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@property (strong, nonatomic) UISearchController *searchController;

@property (strong, nonatomic) NSArray<Post *> *posts;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    
    // searchController will use this view controller to display the search results
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;

    self.searchController.obscuresBackgroundDuringPresentation = NO;
    
    [self.searchController.searchBar sizeToFit];
    self.searchTableView.tableHeaderView = self.searchController.searchBar;
    
    // Sets this view controller as presenting view controller for the search interface
    self.definesPresentationContext = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
    
     //Configure the cell:
    Post *post = self.posts[indexPath.item];
    [cell setPost:post];
    
    cell.itemImageView.layer.cornerRadius = 15;
    cell.itemImageView.clipsToBounds = YES;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    if (searchText) {
        if (searchText.length != 0) {
            [self searchPosts: [searchText lowercaseString]];
        }
    }
}

- (void) searchPosts: (NSString*) searchString {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"images"];
    [postQuery whereKey:@"title" containsString:searchString];
    
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = posts;
            [self.searchTableView reloadData];
        } else {
            NSLog(@"Error searching Neighborcycle posts: %@", error.localizedDescription);
        }
    }];
}

@end
