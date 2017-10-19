//
//  ViewController.m
//  InstaKilo
//
//  Created by Olga on 10/18/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import "ViewController.h"
#import "ONECollectionViewCell.h"
#import "ONEHeaderCollectionReusableView.h"

@interface ViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *defaultLayout;

@property (nonatomic, strong) NSArray *arrayOfArrays;
@property (nonatomic, strong) NSArray *arrayWithAllObjects;
@property (nonatomic, strong) NSArray *catsArr;
@property (nonatomic, strong) NSArray *dogsArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    [self createCatsArray];
    [self createDogsArray];
    [self createArrayWithAllObjects];
    [self createArrayOfArrays];
    [self setupDefaultLayout];
    
    self.collectionView.collectionViewLayout = self.defaultLayout;
    
}


-(void)setupDefaultLayout {
        self.defaultLayout = [[UICollectionViewFlowLayout alloc] init];
        
        self.defaultLayout.itemSize = CGSizeMake(100, 100); // Set size of cell
        self.defaultLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);  // "Border around each section"
        self.defaultLayout.minimumInteritemSpacing = 15;  // Minimum horizontal spacing between cells
        self.defaultLayout.minimumLineSpacing = 10;  // Minimum vertical spacing
        
        self.defaultLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 35);
    
        
        // Add this line so footers will appear. If this line is not present, footers will not appear
        //self.simpleLayout.footerReferenceSize = CGSizeMake(30, self.collectionView.frame.size.height);
    
}



-(void)createCatsArray {
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%i", i]];
        [tempArr addObject:image];
    }
    
    self.catsArr = tempArr.copy;
    NSLog(@"Objects in catsArr: %lu", (unsigned long)self.catsArr.count);
}


-(void)createDogsArray {
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (int i = 11; i <= 14; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%i", i]];
        [tempArr addObject:image];
    }
    self.dogsArr = tempArr.copy;
    NSLog(@"Objects in dogsArr: %lu", (unsigned long)self.dogsArr.count);
}

-(void)createArrayOfArrays {
    self.arrayOfArrays = @[self.catsArr, self.dogsArr];
    NSLog(@"Objects in arrayOfArrays: %lu", (unsigned long)self.arrayOfArrays.count);
}

-(void)createArrayWithAllObjects {
    self.arrayWithAllObjects = [self.catsArr arrayByAddingObjectsFromArray: self.dogsArr];
    NSLog(@"Objects in arrayWithAllObjects: %lu", (unsigned long)self.arrayWithAllObjects.count);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.arrayOfArrays.count;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return [[self.arrayOfArrays objectAtIndex:section]count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ONECollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"imageCellId" forIndexPath:indexPath];
        
    cell.imageView.image = [self.arrayOfArrays[indexPath.section] objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ONEHeaderCollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                           withReuseIdentifier:@"headerId"
                                                                                  forIndexPath:indexPath];
        
                if ([self.arrayOfArrays objectAtIndex:indexPath.section] == self.catsArr) {
                    headerView.label.text = @"Cats";
                    return headerView;
                } else if ([self.arrayOfArrays objectAtIndex:indexPath.section] == self.dogsArr) {
                    headerView.label.text = @"Dogs";
                    return headerView;
                }
    } else {
     return nil;
        }
    return nil;
    }

@end
