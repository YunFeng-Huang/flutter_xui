# xui

正在不断完善中。。。

## Getting Started

主要包含项目中常用的html元素，项目布局和js方法,可作为项目模板使用

进入页面先设置下尺寸
````dart
      builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
````
设置颜色
````

/// 默认ui配置
  static configInit() {
    ///图片 默认样式支持svg 和 静态图片
    globalConfig.imgList = {
      XImageType.general: Icon(const IconData(0xe63f, fontFamily: 'iconfont')),
      XImageType.avatar: 'assets/common/avatar.png',
    };
    /// 对 XButton 的 按钮拦截 ,也可以在这里做数据埋点 
    XButtonInterceptor = () async {
      ApiClient.hideToast = false;
    };
  }
/// 支持换肤配置
  static themeColorInit() {
    globalConfig.theme = FontTextColor.theme;
    themeColor = ThemeColor(
      primary: FontTextColor.primary,
      ff3D3B48: FontTextColor.ff3D3B48,
      ff6C7480: FontTextColor.ff6C7480,
      ff9EA6AE: FontTextColor.ff9EA6AE,
      ffC1C6CB: FontTextColor.ffC1C6CB,
      ffFF4300: FontTextColor.ffFF4300,
      ffFF9538: FontTextColor.ffFF9538,
      ffFE424A: FontTextColor.ffFE424A,
      ffFFFFFF: FontTextColor.ffFFFFFF,
      ff0E1424: FontTextColor.ff0E1424,
      ff11BB70: FontTextColor.ff11BB70,
      ff4480FF: FontTextColor.ff4480FF,
      ff54C6EF: FontTextColor.ff54C6EF,
      ff846BF8: FontTextColor.ff846BF8,
      ffDEDFDE: FontTextColor.ffDEDFDE,
      ffF3F6F9: FontTextColor.ffF3F6F9,
    );
  }

//设置


````
 

## html 部分

####  布局:
````dart
    SizedBox()
    .margin(10.w) 
    .paddingAll(20.w)
    .background(color: Colors.white, width: 1216.w, height: 672.w, radius: 12.w)
   // background  来设置块装的背景，长宽，圆角，边框颜色宽度; 不可以直接设置在Container ，可以先包一个SizedBox
````
#### XButton 按钮:
````dart
    XButton(
      callback: () => Get.back(),
      child: Text(
        '确定',
        style: FontText.h26.copyWith(color: FontTextColor.ff333333),
      ).center.margin(right: 40.w),
    )
    

````

#### XCheckBox 复选框 or 单选:
````dart

    //复选框
    XCheckBox(
        right: Text(
            '记住账户',
            style: font(14, color: '#000000', weight: FontWeight.w400),
        ),
        value: value,
        activeColor: '#3399FF',
        onChanged: (v) {
            setState(() {
                value = v!;
            });
        },
    ),

    // 单选

    XCheckBox(
      radio: true,  //是否单选
      value: e['select'],
      activeImg: IconPath.login_radio_active,
      defaultImg: IconPath.login_radio_default,
      size: 42.w,
      onChanged: (v) {},
    ),
    
````


#### XDivision 分割线:
````dart
    XDivision(height: 1.w)
````

#### XImage 图片:
````dart
   XImage(
    type: XImageType.avatar,
    image: LoginService.userInfo?.driverPhotoUrl,
    width: 75.w,
    height: 75.w,
    borderRadius: 100,
  )
````

#### XInput 输入框:
````dart
  XInput(
  controller: state.code,
  keyboardType: TextInputType.number,
  hintText: '请输入验证码',
  hintStyle: FontText.h32.copyWith(color: FontTextColor.ffCCCCCC),
  style: FontText.h32.copyWith(color: FontTextColor.ff333333),
  validator: FormKeyEnum.empty,
  contentPadding: EdgeInsets.only(top: 30.w, bottom: 30.w),
  onChanged: (v) {},
)
````


#### XSelectInput 选择框:
````dart
//1
  XSelectInput(
      width: 200.w,
      initialValue: _data,
      onSelected: (c) {
          print(c);
      },
      list: data,
  )),
//2
  JhPickerTool.showStringPicker(
    context,
    data: messageToken!.posUserWharfModels!.map((e) => e.shipWharfName).toList(),
    title: '请选择码头',
    normalIndex: shipWharfIndex,
    clickCallBack: (int selectIndex, Object selectStr) {
      shipWharfIndex = selectIndex;
      setState(() {});
    },
  )
````


#### XP 多个text拼接:
````dart
  XP([
    XPConfig(
      title: '预估价格：',
      style: FontText.h30.copyWith(color: FontTextColor.ff333333),
    ),
    XPConfig(
      title: '${XChangePrice(state.orderEstimatedPriceData.value.price)}',
      style: FontText.h36.copyWith(color: FontTextColor.ff333333),
    ),
    XPConfig(
      title: ' 元',
      style: FontText.h30.copyWith(color: FontTextColor.ff333333),
    ),
  ])
````

#### XForm 表单布局:
````dart
 List list = [
      {
        'name': '上车站点',
        'value': '上车站点1111',
      },
      {
        'name': '下车站点',
        'child': () => _stationListData == null
            ? Container()
            : Text('下车站点'),
      },
      {
        'name': '单价',
        'value': '￥${params.price}',
      },
      {
        'name': '数量',
         'hidden':true,
        'child': () => XComputer(
              num: params.totalTicketCount,
              onValueChanged: (int value) {
                params.totalTicketCount = value;
                setState(() {});
              },
            )
      },
    ];


    XForm(
        child: (item, inline) => XFormItem(
                label: item['name'],
                value: item['value'],
                hidden: item['hidden'],
                align: (item['name'] == '下车站点' || item['name'] == '票型') ? CrossAxisAlignment.start : null,
                child: item.containsKey('child') ? item['child']() : null,
            ).margin(top: 16.w),
        list: list)

````


#### XTable 表单:
````dart

    receptionTicketOrderList = _ticketOrderList!
          .map((e) => {
                'orderNo': e.ticketOrderNumber,
                'type': ticketsEnumString(TicketsEnum.values[e.ticketType ?? 0]),
                'onUpSite': '${e.startStationName}-${e.endStationName}',
                'people': e.totalTicketCount,
                'price': e.totalAmount,
                'orderTime': e.createTime,
                'orderState': paymentStatusEnumString(PaymentStatusEnum.values[int.parse((e.paymentStatus ?? '0')) + 1]),
                'orderFrom': orderSourceEnumString(OrderSourceEnum.values[(e.orderSource ?? 1) - 1]),
                'businessState': businessTypeEnumString(BusinessTypeEnum.values[(e.businessType ?? 1) - 1]),
                'payWay': paymentTypeEnumString(e.paymentType),
                'id': e.id,
              })
          .toList();

    tableColumn = [
        TableColumn(prop: 'orderNo', label: '订单编号', width: 260.w, alignment: Alignment.centerLeft),
        TableColumn(prop: 'type', label: '票型', width: 100.w),
        TableColumn(prop: 'onUpSite', label: '上下车站点', width: 200.w, alignment: Alignment.centerLeft),
        TableColumn(prop: 'people', label: '人数', width: 40.w),
        TableColumn(prop: 'price', label: '金额', width: 100.w),
        TableColumn(prop: 'orderTime', label: '订单时间', width: 200.w, alignment: Alignment.centerLeft),
        TableColumn(prop: 'orderState', label: '订单状态', width: 100.w),
        TableColumn(prop: 'orderFrom', label: '订单来源', width: 100.w),
        TableColumn(prop: 'businessState', label: '业务状态', width: 100.w),
        TableColumn(prop: 'payWay', label: '支付方式', width: 100.w),
        TableColumn(
            prop: 'btn',
            label: '操作',
            maxLines: 3,
            widget: (i) => XButton( text: '详情', style: font(14, color: '#3399FF', weight: FontWeight.w400), callback: () async {
                    OrderDetailGetData model = await HomeApi.ticketOrderGet({'id': _search.receptionTicketOrderList[i]['id']});
                    Alert(context).orderDetail(
                    model: model,
                    title: '订单详情',
                    callback: (v) {},
                    );
                }))
    ];
  XTable(
    data: receptionTicketOrderList,
    onRefresh: () =>onRefresh(),
    tableColumn: tableColumn!,
    config: TableConfig()
        ..style = font(24, colorA: Color.fromRGBO(0, 0, 0, 0.65), weight: FontWeight.w400)
        ..headerBackground = '#144372'
        ..headerStyle = font(26, colorA: Color.fromRGBO(0, 0, 0, 0.65), weight: FontWeight.w500),
    )
````


#### XPaginatedTable 分页:
````dart
  XPaginatedTable(
    pageIndexKey: 'pageIndex',
    pageSizeKey: 'pageSize',
    totalNum:  HomeApi.model.ticketOrderListData?.total,
    params: _search.toJson(),
    api: _search.submit,
    onChange: (data, pageIndex) {
        _search.pageIndex = pageIndex;
        setState(() {});
    })
````

#### XSelectDateTime 时间筛选:
````dart
    XSelectDateTime(
      width: 300.w,
      initialValue: _startTime,
      format: 'yyyy-MM-dd HH:mm',
      onConfirm: (c) {
        _startTime = c;
        Routers.pop();
      },
    )   
````




#### XCustomScrollView sliver 布局 包含 loading 上拉 下拉刷新:
````dart
    XCustomScrollView(
      loadingWidget: const LoadingWidget(),
      emptyWidget: const EmptyWidget(status: EmptyStatus.empty),
      errorWidget: EmptyWidget(
        status: EmptyStatus.error,
        onTap: () {},
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      onRefresh: () {},
      onLoading: () {},
      xAppBar: XAppBar(context, title: '模版'),
      slivers: () => [],
      status: PageStatus.success,
    )  
````




##  js 部分



#### 验证表单填写信息:
````dart
  List<CheckFormItem> arr = [
      CheckFormItem()
        ..required = true
        ..key = FormKeyEnum.name
        ..value = params.loginName,
      CheckFormItem()
        ..required = true
        ..key = FormKeyEnum.empty
        ..info = "请输入密码"
        ..value = params.password,
    ];
    if (!checkAllForm(arr)) return ajax();
````

#### 未完~等待更新！！！:

