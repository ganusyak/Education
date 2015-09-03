//
//  ViewController.m
//  spiralka
//
//  Created by yuriy ganusyak on 9/2/15.
//  Copyright (c) 2015 Yuriy Ganusyak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (NSMutableArray *)createSquareArrayWithSize:(NSInteger)size {
    NSMutableArray *squareArray = [[NSMutableArray alloc] initWithCapacity:size];
    NSInteger counter = 0;
    for (int i = 0; i < size; i++) {
        [squareArray addObject:[NSMutableArray arrayWithCapacity:size]];
        for (int j = 0; j < size; j++) {
            [squareArray[i] addObject:[NSString stringWithFormat:@"0"]];
            counter++;
        }
    }
        
    return squareArray;
}

- (void)printSquareArray:(NSMutableArray *)squareArray {
    NSInteger numberOfRows = [squareArray count];
    for (int i = 0; i < numberOfRows; i++) {
        NSArray *arrayRow = [squareArray objectAtIndex:i];
        NSString *string = [arrayRow componentsJoinedByString:@" "];
        NSLog(@"%@",string);
    }
}

- (BOOL)canMoveInArray:(NSMutableArray *)array toPositionX:(NSInteger)positionX andPositionY:(NSInteger)positionY {
    BOOL result = NO;
    if ((positionX < [array count]) && (positionX >= 0) && (positionY < [array count]) && (positionY >= 0)) {
        
        if ([[[array objectAtIndex:positionY] objectAtIndex:positionX] isEqualToString:@"0"]) {
            result = YES;
        }
    }
    return result;
}

- (NSUInteger)newDirectionAfterRightTurnForDirection:(NSUInteger)direction{
    
    direction++;
    return direction % 4;
}

- (NSInteger)incrementXforDirection:(NSUInteger)direction
{
    // 0 = right
    // 1 = down
    // 2 = left
    // 3 = up
    
    
    NSInteger result = 0;
    
    if (direction == 0) {
        return 1;
    } else if (direction == 2) {
        return -1;
    }
    return result;
}

- (NSInteger)incrementYforDirection:(NSUInteger)direction
{
    // 0 = right
    // 1 = down
    // 2 = left
    // 3 = up

    NSInteger result = 0;

    if (direction == 1) {
        result = 1;
    } else if (direction == 3) {
        result = -1;
    }

    return result;
}

- (NSMutableArray *)moveInArray:(NSMutableArray *)array toPositionX:(NSUInteger)positionX andPositionY:(NSUInteger)positionY withDirection:(NSUInteger)direction andCounter:(NSUInteger)counter{
    if ([self canMoveInArray:array toPositionX:positionX andPositionY:positionY]) {
        [[array objectAtIndex:positionY] replaceObjectAtIndex:positionX
                                                   withObject:[NSString stringWithFormat:@"%li", counter]];
        
        counter++;

        BOOL canMoveNext = [self canMoveInArray:array
                                    toPositionX:(positionX + [self incrementXforDirection:direction])
                                   andPositionY:(positionY + [self incrementYforDirection:direction])];

        if (!canMoveNext) {
            direction = [self newDirectionAfterRightTurnForDirection:direction];
        }

        [self moveInArray:array
              toPositionX:(positionX + [self incrementXforDirection:direction])
             andPositionY:(positionY + [self incrementYforDirection:direction])
            withDirection:direction
               andCounter:counter];
    }
    return array;
}




- (void)viewDidLoad {
    [super viewDidLoad];
}
// comment here

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSMutableArray *array = [self createSquareArrayWithSize:3];
    NSLog(@"Empty array");
    [self printSquareArray:array];
    NSMutableArray *newArray = [self moveInArray:array toPositionX:0 andPositionY:0 withDirection:0 andCounter:1];
    NSLog(@"Final array");
    [self printSquareArray:newArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
