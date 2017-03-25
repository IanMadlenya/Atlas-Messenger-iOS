//
//  ATLMTextPollCardCollectionViewCell.m
//  Atlas Messenger
//
//  Copyright © 2017 Layer, Inc. All rights reserved.
//

#if 0
#pragma mark Imports
#endif

#import "ATLMTextPollCardCollectionViewCell.h"
#import "ATLMTextPollCard.h"

NS_ASSUME_NONNULL_BEGIN     // {


#if 0
#pragma mark - Constants
#endif

static const CGFloat ATLMTextPollCardCollectionViewCellTopPadding = 10.0;
static const CGFloat ATLMTextPollCardCollectionViewCellBottomPadding = 17.0;
static const CGFloat ATLMTextPollCardCollectionViewCellHorizontalPadding = 13.0;
static const CGFloat ATLMTextPollCardCollectionViewCellSeparatorVerticalGap = 10.0;
static const CGFloat ATLMTextPollCardCollectionViewCellSeparatorHeight = 1.0;
static const CGFloat ATLMTextPollCardCollectionViewCellChoiceHeight = 48.0;
static const CGFloat ATLMTextPollCardCollectionViewCellChoiceButtonHeight = 35.0;
static const CGFloat ATLMTextPollCardCollectionViewCellChoiceSpacing = ATLMTextPollCardCollectionViewCellChoiceHeight - ATLMTextPollCardCollectionViewCellChoiceButtonHeight;
static const CGFloat ATLMTextPollCardCollectionViewCellChoiceBottomPadding = 39.0;
static const CGFloat ATLMTextPollCardCollectionViewCellDirectionHeight = 18.0;
static const CGFloat ATLMTextPollCardCollectionViewCellQuestionFontSize = 15.0;
static const CGFloat ATLMTextPollCardCollectionViewCellChoiceFontSize = 15.0;
static const CGFloat ATLMTextPollCardCollectionViewCellDirectionFontSize = 13.0;


#if 0
#pragma mark -
#endif

@interface ATLMTextPollCardChoiceViewCell : UITableViewCell
@property (nonatomic, strong, readwrite) UILabel *choice;
@end


#if 0
#pragma mark - Functions
#endif

static inline UIColor *
ATLMTextPollCardCollectionViewCellBackgroundColor(ATLCellType type) {
    return ((ATLOutgoingCellType == type) ? ATLBlueColor() : ATLLightGrayColor());
}

static inline UIColor *
ATLMTextPollCardCollectionViewCellForegroundColor(ATLCellType type) {
    if (ATLOutgoingCellType == type) {
        return [UIColor whiteColor];
    }
    return [UIColor colorWithRed:49.0/255.0 green:63.0/255.0 blue:72.0/255.0 alpha:1.0];
}

static inline UIColor *
ATLMTextPollCardCollectionViewCellSeparatorColor(ATLCellType type) {
    if (ATLOutgoingCellType == type) {
        return [UIColor whiteColor];
    }
    return [UIColor colorWithWhite:222.0/255.0 alpha:1.0];
}

static inline UIColor *
ATLMTextPollCardCollectionViewCellChoiceButtonBackgroundColor(ATLCellType type) {
    if (ATLOutgoingCellType == type) {
        return [UIColor colorWithWhite:1.0 alpha:0.7];
    }
    return [UIColor colorWithRed:25.0f/255.0 green:165.0/255.0 blue:228.0/255.0 alpha:0.1];
}

static inline UIFont *
ATLMTextPollCardCollectionViewCellQuestionFont(void) {
    return [UIFont systemFontOfSize:ATLMTextPollCardCollectionViewCellQuestionFontSize weight:UIFontWeightSemibold];
}

static inline UIFont *
ATLMTextPollCardCollectionViewCellChoiceFont(void) {
    return [UIFont systemFontOfSize:ATLMTextPollCardCollectionViewCellChoiceFontSize weight:UIFontWeightSemibold];
}

static inline UIFont *
ATLMTextPollCardCollectionViewCellDirectionFont(void) {
    return [UIFont systemFontOfSize:ATLMTextPollCardCollectionViewCellDirectionFontSize weight:UIFontWeightSemibold];
}


#if 0
#pragma mark -
#endif

@interface ATLMTextPollCardCollectionViewCell () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong, readwrite, nullable) ATLMTextPollCard *card;
@property (nonatomic, strong, readonly) UILabel *question;
@property (nonatomic, strong, readonly) UIView *separator;
@property (nonatomic, strong, readonly) UITableView *choices;
@property (nonatomic, strong, readonly) UILabel *direction;
@property (nonatomic, assign, readwrite) ATLCellType type;

- (void)lyr_CommonInit;

@end


#if 0
#pragma mark -
#endif

@implementation ATLMTextPollCardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        [self lyr_CommonInit];
    }
    
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        [self lyr_CommonInit];
    }
    
    return self;
}

- (void)lyr_CommonInit {
    
    UIView *content = [self bubbleView];
    
    _question = [[UILabel alloc] init];
    [_question setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_question setFont:ATLMTextPollCardCollectionViewCellQuestionFont()];
    [_question setNumberOfLines:2];
    [content addSubview:_question];
    
    _separator = [[UIView alloc] init];
    [_separator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [content addSubview:_separator];
    
    _choices = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_choices setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_choices setDataSource:self];
    [_choices setDelegate:self];
    [_choices setRowHeight:ATLMTextPollCardCollectionViewCellChoiceHeight];
    [_choices setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [_choices setAllowsSelection:NO];
    [content addSubview:_choices];

    _direction = [[UILabel alloc] init];
    [_direction setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_direction setFont:ATLMTextPollCardCollectionViewCellDirectionFont()];
    [_direction setTextAlignment:(NSTextAlignmentCenter)];
    [_direction setText:@"You can only submit once"];
    [_direction setAlpha:0.3f];
    [content addSubview:_direction];

    NSDictionary *views = NSDictionaryOfVariableBindings(_question, _separator, _choices, _direction);
    NSDictionary *metrics = @{@"ATLMTextPollCardCollectionViewCellTopPadding": @(ATLMTextPollCardCollectionViewCellTopPadding),
                              @"ATLMTextPollCardCollectionViewCellHorizontalPadding": @(ATLMTextPollCardCollectionViewCellHorizontalPadding),
                              @"ATLMTextPollCardCollectionViewCellSeparatorHeight": @(ATLMTextPollCardCollectionViewCellSeparatorHeight),
                              @"ATLMTextPollCardCollectionViewCellSeparatorVerticalGap": @(ATLMTextPollCardCollectionViewCellSeparatorVerticalGap),
                              @"ATLMTextPollCardCollectionViewCellChoiceBottomPadding": @(ATLMTextPollCardCollectionViewCellChoiceBottomPadding),
                              @"ATLMTextPollCardCollectionViewCellBottomPadding": @(ATLMTextPollCardCollectionViewCellBottomPadding),
                              @"ATLMTextPollCardCollectionViewCellDirectionHeight": @(ATLMTextPollCardCollectionViewCellDirectionHeight)};
    [content addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-ATLMTextPollCardCollectionViewCellHorizontalPadding-[_question]-ATLMTextPollCardCollectionViewCellHorizontalPadding-|" options:0 metrics:metrics views:views]];
    [content addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0.0-[_separator]-0.0-|" options:0 metrics:metrics views:views]];
    [content addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-ATLMTextPollCardCollectionViewCellHorizontalPadding-[_choices]-ATLMTextPollCardCollectionViewCellHorizontalPadding-|" options:0 metrics:metrics views:views]];
    [content addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-ATLMTextPollCardCollectionViewCellHorizontalPadding-[_direction]-ATLMTextPollCardCollectionViewCellHorizontalPadding-|" options:0 metrics:metrics views:views]];
    [content addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-ATLMTextPollCardCollectionViewCellTopPadding-[_question]-ATLMTextPollCardCollectionViewCellSeparatorVerticalGap-[_separator(ATLMTextPollCardCollectionViewCellSeparatorHeight)]-0-[_choices]-ATLMTextPollCardCollectionViewCellChoiceBottomPadding-|" options:0 metrics:metrics views:views]];
    [content addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_direction(ATLMTextPollCardCollectionViewCellDirectionHeight)]-ATLMTextPollCardCollectionViewCellBottomPadding-|" options:0 metrics:metrics views:views]];
}

- (void)dealloc {
    
    LYRMessage *current = [self message];
    
    if (nil != current) {
        for (LYRMessagePart *part in [current parts]) {
            [part removeObserver:self forKeyPath:@"transferStatus"];
        }
    }
}

- (nullable ATLMTextPollCard *)card {

    if (nil == _card) {
        LYRMessage *message = [self message];
        if (nil != message) {
            _card = [ATLMTextPollCard cardWithMessage:message];
        }
    }
    
    return _card;
}

- (void)setMessage:(LYRMessage *)message {
    
    for (LYRMessagePart *part in [[self message] parts]) {
        [part removeObserver:self forKeyPath:@"transferStatus"];
    }

    [super setMessage:message];
    
    [self setCard:nil];
    
    for (LYRMessagePart *part in [message parts]) {
        
        [part addObserver:self forKeyPath:@"transferStatus" options:NSKeyValueObservingOptionNew context:NULL];
        
        // Start downloading the parts if any are outstanding
        if ([part transferStatus] == LYRContentTransferReadyForDownload) {
            (void)[part downloadContent:NULL];
        }
    }
    
    ATLMTextPollCard *card = [self card];
    if (nil != card) {

        UILabel *label = [self question];
        NSString *question = [card question];
        [label setText:question];
        [label setHidden:(0 == [question length])];
        
        UITableView *table = [self choices];
        [table reloadData];
        [table setHidden:NO];
    }
    else {
        [[self question] setHidden:YES];
        [[self choices] setHidden:YES];
    }
    
    [self updateBubbleWidth:[[self class] cellSizeForMessage:message withCellWidth:CGRectGetWidth([self bounds])].width];
}

- (void)setType:(ATLCellType)type {
    
    _type = type;
    
    UIColor *bgColor = ATLMTextPollCardCollectionViewCellBackgroundColor(type);
    UIColor *fgColor = ATLMTextPollCardCollectionViewCellForegroundColor(type);
    
    [self setBubbleViewColor:bgColor];
    
    UILabel *question = [self question];
    [question setBackgroundColor:bgColor];
    [question setTextColor:fgColor];
    
    [[self separator] setBackgroundColor:ATLMTextPollCardCollectionViewCellSeparatorColor(type)];
    
    UITableView *choices = [self choices];
    [choices setBackgroundColor:bgColor];
    [choices reloadData];
    
    [[self direction] setTextColor:fgColor];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath
                      ofObject:(nullable id)object
                        change:(nullable NSDictionary<NSString*, id> *)change
                       context:(nullable void *)context
{
    if (LYRContentTransferComplete == [object transferStatus]) {
        
        // Re-dispatch this call to the main thread if it's not.
        if (![[NSThread currentThread] isMainThread]) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            }];
            return;
        }
        
        LYRMessage *message = [self message];
        LYRMessage *other = [(LYRMessagePart*)object message];
        
        if ([message isEqual:other]) {
            [[self question] setText:[[self card] question]];
            [[self choices] reloadData];
        }
    }
}

- (void)configureCellForType:(ATLCellType)cellType {
    [super configureCellForType:cellType];
    [self setType:cellType];
}

+ (CGSize)cellSizeForMessage:(LYRMessage *)message withCellWidth:(CGFloat)cellWidth {
    
    ATLMTextPollCard *card = [ATLMTextPollCard cardWithMessage:message];
    NSString *question = [card question];
    
    CGSize sz = CGSizeMake(MIN(ATLMaxCellWidth(), cellWidth), CGFLOAT_MAX);
    CGRect result = CGRectIntegral([question boundingRectWithSize:sz
                                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                       attributes:@{NSFontAttributeName:ATLMTextPollCardCollectionViewCellQuestionFont()}
                                                          context:nil]);
    
    result.size.height += (ATLMTextPollCardCollectionViewCellTopPadding +
                           ATLMTextPollCardCollectionViewCellSeparatorVerticalGap +
                           ATLMTextPollCardCollectionViewCellSeparatorHeight +
                           ATLMTextPollCardCollectionViewCellChoiceSpacing +
                           (ATLMTextPollCardCollectionViewCellChoiceHeight * [[card choices] count]) +
                           ATLMTextPollCardCollectionViewCellChoiceBottomPadding);
    result.size.width += (2.0 * ATLMTextPollCardCollectionViewCellHorizontalPadding);

    return result.size;
}

#if 0
#pragma mark - UITableViewDataSource
#endif

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self card] choices] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ATLMTextPollCardChoiceViewCell *result = [[ATLMTextPollCardChoiceViewCell alloc] init];
    
    NSString *choice = [[[self card] choices] objectAtIndex:[indexPath row]];
    
    ATLCellType type = [self type];
    UILabel *label = [result choice];
    [label setTextColor:ATLBlueColor()];
    [label setText:choice];
    [label setBackgroundColor:ATLMTextPollCardCollectionViewCellChoiceButtonBackgroundColor(type)];
    
    [result setBackgroundColor:((ATLOutgoingCellType == type) ? ATLBlueColor() : ATLLightGrayColor())];
    
    [result setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    return result;
}

#if 0
#pragma mark - UITableViewDelegate
#endif

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return ATLMTextPollCardCollectionViewCellChoiceSpacing;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

@end


#if 0
#pragma mark -
#endif

@implementation ATLMTextPollCardChoiceViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
        
        UIView *content = [self contentView];
        
        _choice = [[UILabel alloc] init];
        [_choice setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_choice setFont:ATLMTextPollCardCollectionViewCellChoiceFont()];
        [_choice setTextAlignment:(NSTextAlignmentCenter)];
        [_choice setClipsToBounds:YES];
        [[_choice layer] setCornerRadius:4.0];
        [content addSubview:_choice];
        
        [[NSLayoutConstraint constraintWithItem:_choice attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:content attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:0.0] setActive:YES];
        [[NSLayoutConstraint constraintWithItem:_choice attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:content attribute:(NSLayoutAttributeRight) multiplier:1.0 constant:0.0] setActive:YES];
        [[NSLayoutConstraint constraintWithItem:_choice attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:ATLMTextPollCardCollectionViewCellChoiceButtonHeight] setActive:YES];
    }
    
    return self;
}

@end

NS_ASSUME_NONNULL_END       // }
