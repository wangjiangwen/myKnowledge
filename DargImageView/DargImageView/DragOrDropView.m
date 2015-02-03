//
//  DrayOrDropView.m
//  DargImageView
//
//  Created by wangjiangjiao on 14/12/27.
//  Copyright (c) 2014年 elong. All rights reserved.
//

#import "DragOrDropView.h"
#import "GSBookShelfView.h"
#import "MyBookView.h"
#import "BookShelfCellView.h"
#import <QuartzCore/QuartzCore.h>


typedef enum {
    BOOK_UNSELECTED,
    BOOK_SELECTED
}BookStatus;
#define CELL_HEIGHT 95


@interface DragOrDropView()<GSBookShelfViewDelegate, GSBookShelfViewDataSource>{
    GSBookShelfView *_bookShelfView;
    
    NSMutableArray *_bookArray;
    NSMutableArray *_bookStatus;
    NSMutableArray * _imageArray;
    NSMutableIndexSet *_booksIndexsToBeRemoved;
    
    BOOL _editMode;
}
@end

@implementation DragOrDropView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadDragOrDropView];
    }
    return self;
}


- (void)loadImageViewArray:(NSMutableArray *)imageArray
{
    [_bookArray removeAllObjects];
    [_bookStatus removeAllObjects];

    [_booksIndexsToBeRemoved removeAllIndexes];

    [_bookArray addObjectsFromArray:imageArray];
    [_imageArray addObjectsFromArray:imageArray];
    
    for (NSInteger i = 0; i < _bookArray.count; i++) {
        [_bookStatus addObject:[NSNumber numberWithInt:BOOK_UNSELECTED]];
    }
    NSInteger count = imageArray.count;
    if (count < 9) {
        UIImage * image = [UIImage imageNamed:@"LP_fabu_tackPhotoBg.png"];
        [_bookArray addObject:image];
        [_bookStatus addObject:[NSNumber numberWithInt:BOOK_UNSELECTED]];

    }
    
    [_bookShelfView reloadData];
}

- (void)initBooks {
    NSInteger numberOfBooks = 0;
    _bookArray = [[NSMutableArray alloc] initWithCapacity:numberOfBooks];
    _bookStatus = [[NSMutableArray alloc] initWithCapacity:numberOfBooks];
    _imageArray = [[NSMutableArray alloc] init];
//    for (int i = 0; i < numberOfBooks; i++) {
//        NSNumber *number = [NSNumber numberWithInt:i % 4 + 1];
//        [_bookArray addObject:number];
//        [_bookStatus addObject:[NSNumber numberWithInt:BOOK_UNSELECTED]];
//    }
    
    _booksIndexsToBeRemoved = [NSMutableIndexSet indexSet];
}

- (void)switchToNormalMode {
    _editMode = NO;
}


#pragma mark - View lifecycle

- (void)testScrollToRow {
    [_bookShelfView scrollToRow:34 animate:YES];
}

- (void)loadDragOrDropView
{
    
    //    [self initBarButtons];
    [self switchToNormalMode];
    
    [self initBooks];
    
    _bookShelfView = [[GSBookShelfView alloc] initWithFrame:CGRectMake(0, 0, 320,self.frame.size.height)];
    [_bookShelfView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [_bookShelfView setDataSource:self];
    
    [self addSubview:_bookShelfView];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    // TODO:only set orientation change flag when protrait to landscape and reverse
    [_bookShelfView oritationChangeReloadData];
}


#pragma mark GSBookShelfViewDataSource

- (NSInteger)numberOfBooksInBookShelfView:(GSBookShelfView *)bookShelfView {
    NSInteger count = [_bookArray count];
    return count;
}

- (NSInteger)numberOFBooksInCellOfBookShelfView:(GSBookShelfView *)bookShelfView
{
    return 3;
}

- (UIView *)bookShelfView:(GSBookShelfView *)bookShelfView bookViewAtIndex:(NSInteger)index {
    static NSString *identifier = @"bookView";
    MyBookView *bookView = (MyBookView *)[bookShelfView dequeueReuseableBookViewWithIdentifier:identifier];
    if (bookView == nil) {
        bookView = [[MyBookView alloc] initWithFrame:CGRectZero];
        bookView.reuseIdentifier = identifier;
        [bookView addTarget:self action:@selector(bookViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [bookView setIndex:index];
    [bookView setSelected:[(NSNumber *)[_bookStatus objectAtIndex:index] intValue]];
    
//    int imageNO = [(NSNumber *)[_bookArray objectAtIndex:index] intValue];
//    [bookView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", imageNO]] forState:UIControlStateNormal];
    UIImage * image = [_bookArray objectAtIndex:index];
    if (index == _imageArray.count && _imageArray.count != 9) {
        bookView.dragAndDropEnabled = NO;
        [bookView setBackgroundImage:[UIImage imageNamed:@"LP_fabu_tackPhotoBg.png"] forState:UIControlStateNormal];
    }else{
        bookView.dragAndDropEnabled = YES;
        [bookView setBackgroundImage:image forState:UIControlStateNormal];

    }
    
    return bookView;
}

- (UIView *)bookShelfView:(GSBookShelfView *)bookShelfView cellForRow:(NSInteger)row {
    static NSString *identifier = @"cell";
    
    BookShelfCellView *cellView = (BookShelfCellView *)[bookShelfView dequeueReuseableCellViewWithIdentifier:identifier];
    if (cellView == nil) {
        cellView = [[BookShelfCellView alloc] initWithFrame:CGRectZero];
        [cellView setReuseIdentifier:identifier];
    }
    return cellView;
}

- (UIView *)aboveTopViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return nil;
}

- (UIView *)belowBottomViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return nil;
}

- (UIView *)headerViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return nil;
}

- (CGFloat)cellHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return CELL_HEIGHT;
}

- (CGFloat)cellMarginOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 20.0f;
}

- (CGFloat)bookViewHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 88.0f;
    //    return 88.0f;
}

- (CGFloat)bookViewWidthOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 85.0f;
    //    return 74.0f;
}

- (CGFloat)bookViewBottomOffsetOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 100.0f;
//    return 123.0f;
}

- (CGFloat)cellShadowHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
//    return 0.0f;
    return 55.0f;
}

- (void)bookShelfView:(GSBookShelfView *)bookShelfView moveBookFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    if ([(NSNumber *)[_bookStatus objectAtIndex:fromIndex] intValue] == BOOK_SELECTED) {
        [_booksIndexsToBeRemoved removeIndex:fromIndex];
        [_booksIndexsToBeRemoved addIndex:toIndex];
    }
    
    [_bookArray moveObjectFromIndex:fromIndex toIndex:toIndex];
    [_bookStatus moveObjectFromIndex:fromIndex toIndex:toIndex];
    
    // the bookview is recognized by index in the demo, so change all the indexes of affected bookViews here
    // This is just a example, not a good one.In your code, you'd better use a key to recognize the bookView.
    // and you won't need to do the following
    MyBookView *bookView;
    bookView = (MyBookView *)[_bookShelfView bookViewAtIndex:toIndex];
    [bookView setIndex:toIndex];
    if (fromIndex <= toIndex) {
        for (NSInteger i = fromIndex; i < toIndex; i++) {
            bookView = (MyBookView *)[_bookShelfView bookViewAtIndex:i];
            [bookView setIndex:bookView.index - 1];
        }
    }
    else {
        for (NSInteger i = toIndex + 1; i <= fromIndex; i++) {
            bookView = (MyBookView *)[_bookShelfView bookViewAtIndex:i];
            [bookView setIndex:bookView.index + 1];
        }
    }
}

#pragma mark - BarButtonListener
- (void)trashButtonClicked:(id)sender {
    [_bookArray removeObjectsAtIndexes:_booksIndexsToBeRemoved];
    [_bookStatus removeObjectsAtIndexes:_booksIndexsToBeRemoved];
    [_bookShelfView removeBookViewsAtIndexs:_booksIndexsToBeRemoved animate:YES];
    [self switchToNormalMode];
}

#pragma mark - BookView Listener

- (void)bookViewClicked:(UIButton *)button {
    MyBookView *bookView = (MyBookView *)button;
    
//        if (_editMode) {
//    NSNumber *status = [NSNumber numberWithInt:bookView.selected];
//    [_bookStatus replaceObjectAtIndex:bookView.index withObject:status];
//    
//    if (bookView.selected) {
//        [_booksIndexsToBeRemoved addIndex:bookView.index];
//    }
//    else {
//        [_booksIndexsToBeRemoved removeIndex:bookView.index];
//    }
//        }
//        else {
//            [bookView setSelected:NO];
//        }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
