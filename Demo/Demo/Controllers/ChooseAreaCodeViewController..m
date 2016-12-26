//
//  ChooseAreaCodeViewController.m
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "ChooseAreaCodeViewController.h"
#import "ISOAreaCode.h"
#import "AreaCodeCell.h"

@interface ChooseAreaCodeViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (retain, nonatomic) UITableView *areaCodeTableView;
@property (retain, nonatomic) NSString *countryString;

@end

@implementation ChooseAreaCodeViewController

- (id)initWithCountryString:(NSString *)countryString
{
    self = [super init];
    if (self)
    {
        _countryString = countryString;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _areaCodeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [CG s].W,
                                                                       [CG s].H)
                                                      style:UITableViewStylePlain];
    _areaCodeTableView.delegate = self;
    _areaCodeTableView.dataSource = self;
    
    [self.view addSubview:_areaCodeTableView];
    [self setTitle:MLocalizableString(@"choose_country", @"选择国家和地区")];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_countryString)
    {
        NSIndexPath *indexPath = [[ISOAreaCode instance] indexPathByArea:_countryString];
        [_areaCodeTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}

#pragma mark - Table view data source

/**
 * 添加右侧索引
 */
-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == _areaCodeTableView)
    {
        return [[ISOAreaCode instance] searchIndex];
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[ISOAreaCode instance] numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[ISOAreaCode instance] numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView != _areaCodeTableView)
    {
        return 0;
    }
    return 20;
}
/**
 * 自定义TableHeader
 **/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[ISOAreaCode instance] titleForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AreaCode-Cell";
    
    AreaCodeCell *cell = (AreaCodeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AreaCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    AreaCode *areaCode = [[ISOAreaCode instance] areaCodeAtSection:[indexPath section] Row:[indexPath row]];
    [cell setAreaCode:areaCode];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    AreaCode *areaCode = [[ISOAreaCode instance] areaCodeAtSection:[indexPath section] Row:[indexPath row]];
    [_delegate choosedAreaCode:areaCode];
    [self popViewController:YES];
}
@end
