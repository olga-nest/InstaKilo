//
//  ViewController.m
//  InstaKilo
//
//  Created by Olga on 10/18/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import "ViewController.h"
#import "ONECollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *defaultLayout;

@property (nonatomic, strong) NSArray *imagesArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    [self createImagesArray];
    [self setupDefaultLayout];
    
    self.collectionView.collectionViewLayout = self.defaultLayout;
    
}


-(void)setupDefaultLayout {
        self.defaultLayout = [[UICollectionViewFlowLayout alloc] init];
        
        self.defaultLayout.itemSize = CGSizeMake(100, 100); // Set size of cell
        self.defaultLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);  // "Border around each section"
        self.defaultLayout.minimumInteritemSpacing = 15;  // Minimum horizontal spacing between cells
        self.defaultLayout.minimumLineSpacing = 10;  // Minimum vertical spacing
        
        // By default, direction is vertical
        //self.simpleLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // Add this line so headers will appear. If this line is not present, headers will not appear
        //self.simpleLayout.headerReferenceSize = CGSizeMake(50, self.collectionView.frame.size.height);
        
        // Add this line so footers will appear. If this line is not present, footers will not appear
        //self.simpleLayout.footerReferenceSize = CGSizeMake(30, self.collectionView.frame.size.height);
    
}



-(void)createImagesArray {
//    if (!self.imagesArr) {
//    NSArray *imagesArr =[NSArray new];
//    }
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 13; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%i", i]];
        [tempArr addObject:image];
    }
    
    self.imagesArr = tempArr.copy;
    NSLog(@"Objects in imagesArr: %lu", (unsigned long)self.imagesArr.count);
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 13;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ONECollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"imageId" forIndexPath:indexPath];
    
   // NSInteger *index = indexPath.row;
    
    cell.imageView.image = [self.imagesArr objectAtIndex:indexPath.row];
    
    
    return cell;
}

@end
