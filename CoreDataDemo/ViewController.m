//
//  ViewController.m
//  CoreDataDemo
//
//  Created by mys on 15/11/8.
//  Copyright © 2015年 mys. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Clothes+CoreDataProperties.h"
#import "Clothes.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

/**数据源*/
@property (nonatomic, strong) NSMutableArray *dataSource;


@property (weak, nonatomic) IBOutlet UITableView *tb;

/**声明一个AppDelegate对象属性，用于调用类中的属性，比如被管理对象上下问*/
@property (nonatomic, strong) AppDelegate *app;

@end

@implementation ViewController

/**
 *  addModel 添加数据模型方法
 *
 *  @param sender button 点击事件
 */
- (IBAction)addModel:(id)sender {
    // 插入数据
    
    // 创建实体描述对象
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Clothes" inManagedObjectContext: self.app.managedObjectContext];
    // 1.先创建一个模型对象
    Clothes *model = [[Clothes alloc] initWithEntity: desc insertIntoManagedObjectContext: self.app.managedObjectContext];
    
    // 为模型中的属性赋值
    model.name = @"Puma";
    int price = arc4random() % 1000 + 1;
    model.price = [NSNumber numberWithInt: price];
    
    // 插入数据源数组
    [self.dataSource addObject: model];
    
    // 插入UI
    [self.tb reloadData];
    
    // 对数据管理器中的更改进行永久存储
    [self.app saveContext];
}


/**
 *  试图加载完成
 *
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 初始化数组
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    self.app = [UIApplication sharedApplication].delegate;
    
    // 查询数据
    
    // 1.创建NSFretchRequest对象
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Clothes"];
    
    // 2.设置排序
    // 2.1 创建排序描述对象 NSSortDescriptor
    // 第一个参数： 根据那个属性进行排序
    // 第二个参数： 排序是否为升序
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
    request.sortDescriptors = @[sort];
    
    // 执行这个查询请求
    NSError *error = nil;
    
    NSArray *result = [self.app.managedObjectContext executeFetchRequest: request error: &error];
    
    // 给数据源添加数据
    [self.dataSource addObjectsFromArray: result];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource回调方法

/**
 *  返回表格行数
 *
 *  @param tableView 当前的表格
 *  @param section   当前的分区
 *
 *  @return 当前分区中的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

/**
 *  创建单元格
 *
 *  @param tableView 当前的表格
 *  @param indexPath 单元格所处的位置
 *
 *  @return 返回当前被创建好的单元格
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Clothes *model = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", model.name, model.price];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/**
 *  tableview编辑的方法
 *
 *  @param tableView    tableview
 *  @param editingStyle 编辑
 *  @param indexPath    位置
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 删除数据源
        Clothes *model = self.dataSource[indexPath.row];
        [self.dataSource removeObject:model];
        
        // 删除数据管理器中的数据
        [self.app.managedObjectContext deleteObject:model];
        
        // 将进行更改进行永久保存
        [self.app saveContext];
        
        // 删除单元格
        [self.tb deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
}

/**
 *  点击cell的方法用来修改数据
 *
 *  @param tableView 表格
 *  @param indexPath 位置
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.先找到模型对象
    Clothes *model = self.dataSource[indexPath.row];
    model.name = @"Nick";
    // 刷新单元行
    [self.tb reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // 通过saveContext方法对数据修改进行永久保存
    [self.app saveContext];
}

@end
