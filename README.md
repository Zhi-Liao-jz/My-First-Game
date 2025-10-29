现在还不好玩
不会画
sequenceDiagram
    participant B as 买家 (Buyer)
    participant PS as 平台系统 (Platform System)
    participant S as 卖家 (Seller)
    B->>PS: 1. 点击“去结算” (发起下单)
    PS-->>B: 2. 显示订单确认页 (含商品, 地址, 总金额)
    B->>PS: 3. 点击“联系店家改价”
    PS->>S: 4. 转发改价请求 (订单ID, 买家)
    S-->>PS: 5. (操作后台) 确认修改订单价格
    PS-->>B: 6. 刷新订单页 (显示新价格)
    B->>PS: 7. 选择优惠券 (可选, 描述8)
    PS-->>B: 8. 更新总金额
    B->>PS: 9. 提交订单
    PS->>PS: 10. 验证库存/订单数据
    PS->>PS: 11. 创建订单 (状态: 待支付)
    PS-->>B: 12. 返回支付页面/支付请求
