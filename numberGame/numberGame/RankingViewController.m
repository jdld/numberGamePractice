
//
//  RankingViewController.m
//  numberGame
//
//  Created by Etong on 16/7/22.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import "RankingViewController.h"
#import "RankingTableViewCell.h"

@interface RankingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *objArr;

@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBack"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"navBack"];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ranking 1-1"]];
    image.frame = CGRectMake(0, 0, 40, 40);
    image.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = image;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:170.f/255.f green:242.f/255.f blue:242.f/255.f alpha:1];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.scrollEnabled = NO;
    
    NSDictionary *dic1 = @{@"title":@"数量最多",@"score":@"37"};
    NSDictionary *dic2 = @{@"title":@"成绩最好",@"score":@"2595"};
    NSDictionary *dic3 = @{@"title":@"最长游戏时间",@"score":@"157 s"};
    
    _objArr = [NSMutableArray new];
    [_objArr addObject:dic1];
    [_objArr addObject:dic2];
    [_objArr addObject:dic3];

}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 40;
    }else {
        return 60;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _objArr.count;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        NSDictionary *dict = _objArr[indexPath.row];
        cell.titleLab.text = dict[@"title"];
        cell.scoreLab.text = dict[@"score"];
        cell.titleLab.textColor = [UIColor colorWithRed:25.f/255.f green:195.f/255.f blue:210.f/255.f alpha:1];
        cell.scoreLab.textColor = [UIColor colorWithRed:170.f/255.f green:242.f/255.f blue:241.f/255.f alpha:1];
    }else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLab.hidden = YES;
        cell.scoreLab.hidden = YES;
        cell.textLabel.textColor = [UIColor colorWithRed:170.f/255.f green:242.f/255.f blue:241.f/255.f alpha:1];
        cell.tintColor = [UIColor colorWithRed:25.f/255.f green:195.f/255.f blue:210.f/255.f alpha:1];
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"hg"];
            cell.textLabel.text = @"积分榜";
        }else {
            cell.imageView.image = [UIImage imageNamed:@"lj"];
            cell.textLabel.text = @"成绩";
        }
        
    }
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
