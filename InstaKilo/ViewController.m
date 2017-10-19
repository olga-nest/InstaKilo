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
@property (nonatomic, strong) NSArray *paloAltoArr;
@property (nonatomic, strong) NSArray *sanJoseArr;
@property (nonatomic, strong) NSArray *locationsArr;
@property (nonatomic, strong) NSArray *subjectsArr;

@property (nonatomic) BOOL inLocationView;


@end

@implementation ViewController

- (void)viewDidLoad {
    self.inLocationView = NO;
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    [self createSubjectArray];
    [self createLocationArrays];
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

-(void)createSubjectArray {
    [self createCatsArray];
    [self createDogsArray];
    
    self.subjectsArr = @[self.catsArr, self.dogsArr];
    NSLog(@"Objects in subjectsArr: %lu", (unsigned long)self.subjectsArr.count);
}

-(void)createArrayOfArrays {
    self.arrayOfArrays = self.subjectsArr;
    NSLog(@"Objects in arrayOfArrays: %lu", (unsigned long)self.arrayOfArrays.count);
}

-(void)createLocationArrays {
    
    //create array with all objects
    self.arrayWithAllObjects = [self.catsArr arrayByAddingObjectsFromArray: self.dogsArr];
    NSLog(@"Objects in arrayWithAllObjects: %lu", (unsigned long)self.arrayWithAllObjects.count);
    
    NSMutableArray *temp1Arr = [NSMutableArray new];
    NSMutableArray *temp2Arr = [NSMutableArray new];
    
    //create two arrays based on index odd or even
        int i;
        for (i = 0; i < [self.arrayWithAllObjects count]; i++) {
            UIImage *image = [self.arrayWithAllObjects objectAtIndex:i];
            if (i % 2 == 0) {
                [temp1Arr addObject:image];
            } else {
                [temp2Arr addObject:image];
            }
        }
    
    self.paloAltoArr = temp1Arr;
    self.sanJoseArr = temp2Arr;
    self.locationsArr = @[self.paloAltoArr, self.sanJoseArr];
    
    NSLog(@"Objects in paloAltoArr: %lu", (unsigned long)self.paloAltoArr.count);
    NSLog(@"Objects in sanJoseArr: %lu", (unsigned long)self.sanJoseArr.count);
    NSLog(@"Objects in locationsArr: %lu", (unsigned long)self.locationsArr.count);

}
- (IBAction)reorganizeItems:(UIBarButtonItem *)sender {
    if (self.inLocationView == NO) {
        self.inLocationView = YES;
        self.arrayOfArrays = self.locationsArr;
        [self.collectionView reloadData];
    } else {
        self.inLocationView = NO;
        self.arrayOfArrays = self.subjectsArr;
        [self.collectionView reloadData];
    }
    
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
                } else if ([self.arrayOfArrays objectAtIndex:indexPath.section] == self.paloAltoArr) {
                    headerView.label.text = @"Palo Alto";
                    return headerView;
                } else if ([self.arrayOfArrays objectAtIndex:indexPath.section] == self.sanJoseArr) {
                    headerView.label.text = @"San Jose";
                    return headerView;
                }
    } else {
     return nil;
        }
    return nil;
    }

@end
