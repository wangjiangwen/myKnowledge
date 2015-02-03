//
//  ViewController.m
//  DargImageView
//
//  Created by wangjiangjiao on 14/12/26.
//  Copyright (c) 2014年 elong. All rights reserved.
//

#import "ViewController.h"
#import "DragOrDropView.h"
//#import "GSBookShelfView.h"
//
//#import "MyCellView.h"
//#import "MyBookView.h"
//#import "BookShelfCellView.h"
////#import "BelowBottomView.h"
////#import "MyBelowBottomView.h"
//#import <QuartzCore/QuartzCore.h>
//
////@class MyBelowBottomView;
////@class BelowBottomView;
//
//typedef enum {
//    BOOK_UNSELECTED,
//    BOOK_SELECTED
//}BookStatus;
//
////#define CELL_HEIGHT 139.0f
//#define CELL_HEIGHT 95.0f


@interface ViewController ()

//<GSBookShelfViewDelegate, GSBookShelfViewDataSource>{
//    GSBookShelfView *_bookShelfView;
//    
//    NSMutableArray *_bookArray;
//    NSMutableArray *_bookStatus;
//    
//    NSMutableIndexSet *_booksIndexsToBeRemoved;
//    
//    BOOL _editMode;
//}


@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray * imageArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++) {
        NSNumber *number = [NSNumber numberWithInt:i % 4 + 1];
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", number]];
        [imageArray addObject:image];
    }

    CGFloat height = 0;
    
//    NSInteger col = imageArray.count %3 == 0 ? imageArray.count/3 : imageArray.count/3 + 1;
    NSInteger col =  imageArray.count/3 + 1;
    if (col == 4) {
        col = 3;
    }
    height = 95 * col + 35;
    DragOrDropView * dragOrDropView = [[DragOrDropView alloc] initWithFrame:CGRectMake(0, 20, 320, height)];
    [dragOrDropView loadImageViewArray:imageArray];
    dragOrDropView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:dragOrDropView];
    
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, dragOrDropView.frame.size.height + 20, 320, 300)];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    
    UIButton * getBookArrayButton =[UIButton buttonWithType:UIButtonTypeCustom];
    getBookArrayButton.frame = CGRectMake(120, 520, 80, 40);
    [getBookArrayButton setTitle:@"getArray" forState:UIControlStateNormal];
    [getBookArrayButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [getBookArrayButton addTarget:self action:@selector(getBookArrayButtonCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: getBookArrayButton];

}


- (void)getBookArrayButtonCLick:(UIButton *)button
{
//    NSLog(@"---%@",_bookArray);
}

//- (void)initBooks {
//    NSInteger numberOfBooks = 9;
//    _bookArray = [[NSMutableArray alloc] initWithCapacity:numberOfBooks];
//    _bookStatus = [[NSMutableArray alloc] initWithCapacity:numberOfBooks];
//    for (int i = 0; i < numberOfBooks; i++) {
//        NSNumber *number = [NSNumber numberWithInt:i % 4 + 1];
//        [_bookArray addObject:number];
//        [_bookStatus addObject:[NSNumber numberWithInt:BOOK_UNSELECTED]];
//    }
//    
//    _booksIndexsToBeRemoved = [NSMutableIndexSet indexSet];
//    
//    
//    UIButton * getBookArrayButton =[UIButton buttonWithType:UIButtonTypeCustom];
//    getBookArrayButton.frame = CGRectMake(120, 520, 80, 40);
//    [getBookArrayButton setTitle:@"getArray" forState:UIControlStateNormal];
//    [getBookArrayButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [getBookArrayButton addTarget:self action:@selector(getBookArrayButtonCLick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview: getBookArrayButton];
//}
//
//
//- (void)getBookArrayButtonCLick:(UIButton *)button
//{
//    NSLog(@"---%@",_bookArray);
//}
//
////
////- (void)initBarButtons {
////    _editBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonClicked:)];
////    _cancleBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancleButtonClicked:)];
////    
////    _trashBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashButtonClicked:)];
////    _addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClicked:)];
////}
//
//- (void)switchToNormalMode {
//    _editMode = NO;
//    
////    [self.navigationItem setLeftBarButtonItem:_editBarButton];
////    [self.navigationItem setRightBarButtonItem:_addBarButton];
//}
//
//- (void)switchToEditMode {
//    _editMode = YES;
//    [_booksIndexsToBeRemoved removeAllIndexes];
////    [self.navigationItem setLeftBarButtonItem:_cancleBarButton];
////    [self.navigationItem setRightBarButtonItem:_trashBarButton];
//    
//    for (int i = 0; i < [_bookArray count]; i++) {
//        [_bookStatus addObject:[NSNumber numberWithInt:BOOK_UNSELECTED]];
//    }
//    
//    for (MyBookView *bookView in [_bookShelfView visibleBookViews]) {
//        [bookView setSelected:NO];
//    }
//}
//
//#pragma mark - View lifecycle
//
//- (void)testScrollToRow {
//    [_bookShelfView scrollToRow:34 animate:YES];
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
////    [self initBarButtons];
//    [self switchToNormalMode];
//    
//    [self initBooks];
//    
//    //AboveTopView *aboveTop = [[AboveTopView alloc] initWithFrame:CGRectMake(0, 0, 320, 164)];
////    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
////    [_searchBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
////    _belowBottomView = [[BelowBottomView alloc] initWithFrame:CGRectMake(0, 0, 320, CELL_HEIGHT * 2)];
////    [_belowBottomView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
////    [_belowBottomView.layer setBorderWidth:2.0];
////    [_belowBottomView.layer setBorderColor:[[UIColor greenColor] CGColor]];
//    
//    //MyBelowBottomView *belowBottom = [[MyBelowBottomView alloc] initWithFrame:CGRectMake(0, 0, 320, CELL_HEIGHT * 2)];
//    
//    _bookShelfView = [[GSBookShelfView alloc] initWithFrame:CGRectMake(0, 0, 320, 460 - 44)];
//    [_bookShelfView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
//    [_bookShelfView setDataSource:self];
//    //[_bookShelfView.layer setBorderWidth:2.0];
//    //[_bookShelfView.layer setBorderColor:[[UIColor greenColor] CGColor]];
//    //[_bookShelfView setShelfViewDelegate:self];
//    
//    [self.view addSubview:_bookShelfView];
//    
//    //[self performSelector:@selector(testScrollToRow) withObject:self afterDelay:3];
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    return YES;
//}
//
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    // TODO:only set orientation change flag when protrait to landscape and reverse
//    [_bookShelfView oritationChangeReloadData];
//}
//
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    NSLog(@"will animate rotate");
//    /*if (UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
//     [_bookShelfView setFrame:CGRectMake(0, 0, 480, 320 - 44)];
//     }
//     else {
//     [_bookShelfView setFrame:CGRectMake(0, 0, 320, 460 - 44)];
//     }*/
//    NSLog(@"bookShelfViewFrame:%@", NSStringFromCGRect(_bookShelfView.frame));
//    //[_bookShelfView reloadData];
//    //[_bookShelfView oritationChangeReloadData];
//}
//
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    NSLog(@"didRotate");
//    NSLog(@"bookShelfViewFrame:%@", NSStringFromCGRect(_bookShelfView.frame));
//    [_bookShelfView didFinshRotation];
//    /*for (UIView *cell in [_bookShelfView visibleCells]) {
//     CGRect frame = cell.frame;
//     [cell.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
//     [cell setFrame:frame];
//     }*/
//}
//
//#pragma mark GSBookShelfViewDataSource
//
//- (NSInteger)numberOfBooksInBookShelfView:(GSBookShelfView *)bookShelfView {
//    return [_bookArray count];
//}
//
//- (NSInteger)numberOFBooksInCellOfBookShelfView:(GSBookShelfView *)bookShelfView {
////    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
////    if (UIDeviceOrientationIsLandscape(orientation)) {
////        return 4;
////    }
////    else {
//        return 3;
////    }
//}
//
//- (UIView *)bookShelfView:(GSBookShelfView *)bookShelfView bookViewAtIndex:(NSInteger)index {
//    static NSString *identifier = @"bookView";
//    MyBookView *bookView = (MyBookView *)[bookShelfView dequeueReuseableBookViewWithIdentifier:identifier];
//    if (bookView == nil) {
//        bookView = [[MyBookView alloc] initWithFrame:CGRectZero];
//        bookView.reuseIdentifier = identifier;
//        [bookView addTarget:self action:@selector(bookViewClicked:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    [bookView setIndex:index];
//    [bookView setSelected:[(NSNumber *)[_bookStatus objectAtIndex:index] intValue]];
//    if (index == _bookArray.count - 1) {
//        bookView.dragAndDropEnabled = NO;
//    }else{
//        bookView.dragAndDropEnabled = YES;
//    }
//    int imageNO = [(NSNumber *)[_bookArray objectAtIndex:index] intValue];
//    [bookView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", imageNO]] forState:UIControlStateNormal];
//    return bookView;
//}
//
//- (UIView *)bookShelfView:(GSBookShelfView *)bookShelfView cellForRow:(NSInteger)row {
//    static NSString *identifier = @"cell";
//    /*MyCellView *cellView = (MyCellView *)[bookShelfView dequeueReuseableCellViewWithIdentifier:identifier];
//     if (cellView == nil) {
//     cellView = [[MyCellView alloc] initWithFrame:CGRectZero];
//     cellView.reuseIdentifier = identifier;
//     [cellView.layer setBorderColor:[[UIColor redColor] CGColor]];
//     [cellView.layer setBorderWidth:2.0f];
//     }
//     [cellView.label setText:[NSString stringWithFormat:@"row:%d", row]];
//     return cellView;*/
//    
//    BookShelfCellView *cellView = (BookShelfCellView *)[bookShelfView dequeueReuseableCellViewWithIdentifier:identifier];
//    if (cellView == nil) {
//        cellView = [[BookShelfCellView alloc] initWithFrame:CGRectZero];
//        [cellView setReuseIdentifier:identifier];
//        //[cellView.layer setBorderColor:[[UIColor redColor] CGColor]];
//        //[cellView.layer setBorderWidth:2.0f];
//    }
//    return cellView;
//}
//
//- (UIView *)aboveTopViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
//    return nil;
//}
//
//- (UIView *)belowBottomViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
//    return nil;
////    return _belowBottomView;
//}
//
//- (UIView *)headerViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
////    return _searchBar;
//    return nil;
//}
//
//- (CGFloat)cellHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
//    return CELL_HEIGHT;
//}
//
//- (CGFloat)cellMarginOfBookShelfView:(GSBookShelfView *)bookShelfView {
//    return 20.0f;
//}
//
//- (CGFloat)bookViewHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
//    return 88.0f;
////    return 88.0f;
//}
//
//- (CGFloat)bookViewWidthOfBookShelfView:(GSBookShelfView *)bookShelfView {
//    return 85.0f;
////    return 74.0f;
//}
//
//- (CGFloat)bookViewBottomOffsetOfBookShelfView:(GSBookShelfView *)bookShelfView {
//    return 123.0f;
//}
//
//- (CGFloat)cellShadowHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
//    //return 0.0f;
//    return 55.0f;
//}
//
//- (void)bookShelfView:(GSBookShelfView *)bookShelfView moveBookFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
//    if ([(NSNumber *)[_bookStatus objectAtIndex:fromIndex] intValue] == BOOK_SELECTED) {
//        [_booksIndexsToBeRemoved removeIndex:fromIndex];
//        [_booksIndexsToBeRemoved addIndex:toIndex];
//    }
//    
//    [_bookArray moveObjectFromIndex:fromIndex toIndex:toIndex];
//    [_bookStatus moveObjectFromIndex:fromIndex toIndex:toIndex];
//    
//    // the bookview is recognized by index in the demo, so change all the indexes of affected bookViews here
//    // This is just a example, not a good one.In your code, you'd better use a key to recognize the bookView.
//    // and you won't need to do the following
//    MyBookView *bookView;
//    bookView = (MyBookView *)[_bookShelfView bookViewAtIndex:toIndex];
//    [bookView setIndex:toIndex];
//    if (fromIndex <= toIndex) {
//        for (NSInteger i = fromIndex; i < toIndex; i++) {
//            bookView = (MyBookView *)[_bookShelfView bookViewAtIndex:i];
//            [bookView setIndex:bookView.index - 1];
//        }
//    }
//    else {
//        for (NSInteger i = toIndex + 1; i <= fromIndex; i++) {
//            bookView = (MyBookView *)[_bookShelfView bookViewAtIndex:i];
//            [bookView setIndex:bookView.index + 1];
//        }
//    }
//}
//
//#pragma mark - BarButtonListener
//
////- (void)editButtonClicked:(id)sender {
////    [self switchToEditMode];
////}
////
////- (void)cancleButtonClicked:(id)sender {
////    [self switchToNormalMode];
////}
////
//- (void)trashButtonClicked:(id)sender {
//    [_bookArray removeObjectsAtIndexes:_booksIndexsToBeRemoved];
//    [_bookStatus removeObjectsAtIndexes:_booksIndexsToBeRemoved];
//    [_bookShelfView removeBookViewsAtIndexs:_booksIndexsToBeRemoved animate:YES];
//    [self switchToNormalMode];
//}
//
////- (void)addButtonClicked:(id)sender {
////    int a[6] = {1, 2, 5, 7, 9, 22};
////    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
////    NSMutableArray *arr = [NSMutableArray array];
////    NSMutableArray *stat = [NSMutableArray array];
////    for (int i = 0; i < 6; i++) {
////        [indexSet addIndex:a[i]];
////        [arr addObject:[NSNumber numberWithInt:1]];
////        [stat addObject:[NSNumber numberWithInt:BOOK_UNSELECTED]];
////    }
////    [_bookArray insertObjects:arr atIndexes:indexSet];
////    [_bookStatus insertObjects:stat atIndexes:indexSet];
////    [_bookShelfView insertBookViewsAtIndexs:indexSet animate:YES];
////}
//
//#pragma mark - BookView Listener
//
//- (void)bookViewClicked:(UIButton *)button {
//    MyBookView *bookView = (MyBookView *)button;
//    
////    if (_editMode) {
//        NSNumber *status = [NSNumber numberWithInt:bookView.selected];
//        [_bookStatus replaceObjectAtIndex:bookView.index withObject:status];
//        
//        if (bookView.selected) {
//            [_booksIndexsToBeRemoved addIndex:bookView.index];
//        }
//        else {
//            [_booksIndexsToBeRemoved removeIndex:bookView.index];
//        }
////    }
////    else {
////        [bookView setSelected:NO];
////    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
