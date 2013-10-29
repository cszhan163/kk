//
//  EiConstant.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-5.
//  Copyright 2011 baosteel. All rights reserved.
//

static NSString* EF_FORM_ENAME  = @"efFormEname";
static NSString* EF_FORM_CNAME = @"efFormCname";

static NSString* EF_FORM_POPUP = @"efFormPopup";

/**
 * 发起请求的当前页面号，可能与efformename同，特殊情况，可能不同
 */
static NSString* EF_CUR_FORM_ENAME = @"efCurFormEname";

static NSString* EF_FORM_LOAD_PATH = @"efFormLoadPath";

/*	static NSString* EF_FORM_TYPE = "efFormType";
 static NSString* EF_FORM_MODULE_ENAME_1 ="efFormModuleEname1";
 static NSString* EF_FORM_MODULE_ENAME_2 ="efFormModuleEname2";	
 */	



/** The service name. */
static NSString* serviceName = @"serviceName";

/** The method name. */
static NSString* methodName = @"methodName";

static NSString* status = @"status";

/** The sql name. */
static NSString* sqlName = @"sqlName";

/** The ei */
static NSString* ei = @"ei";

/** The ei str. */
static NSString* eiStr = @"eiinfo";

/** The property str. */
static NSString* propertyStr = @"property";

/** The package str. */
static NSString* packageName = @"packageName";

/** The limit str. */
static NSString* limitStr = @"limit";

/** The offset str. */
static NSString* offsetStr = @"offset";

/** The count str. */
static NSString* countStr = @"count";

/** The isCount flag. */
static NSString* isCountFlag = @"showCount";

/** The order by str. */
static NSString* orderByStr = @"orderBy";
/** The separator. */
static NSString* separator = @"-";// :value(r-1-limit)

/** The default limit. */
//static int defaultLimit = 10;

/** The default offset. */
//static int defaultOffset = 0;

/** The default method name. */
static NSString* defaultMethodName = @"initLoad";

/** The query block. */
static NSString* queryBlock = @"inqu_status";// 

/** The result block. */
static NSString* resultBlock = @"result";// 

/** The request url */
static NSString* requestURL = @"reqUrl";

/** The render str */
static NSString* renderStr = @"render";

/** The string to replace Carriage Return(\r\n) */
static NSString* CARRIAGE_RETURN_IDENTIFIER = @"¶¶";

/** The default date formatter, yyyy-mm-dd */
static NSString* DEFAULT_DATEFORMAT = @"yyyy-mm-dd";

/** 调用基类方法时传入的方法参数map对象的属性名称 */
static NSString* methodParamObj = @"mothodParamObj";

/** eai消息体	 */
static NSString* eaiMessageBody = @"messageBody";

/** eai消息号 */
static NSString* eaiMessageCode = @"messageCode";

/** eai返回码 */
static NSString* eaiResultCode = @"resultCode";

/** eai mappingInfo对象 */
static NSString* eaiMappingInfo = @"mappingInfo";

static NSString* reportUserName = @"username";

static NSString* reportPassWord = @"password";

static NSString* reportName = @"name";

/**
 * 报表url的占位符，会被系统的数据替换
 */
static NSString* reportPlaceholder = @"#";

static NSString* COLUMN_TYPE_CHAR = @"C";
static NSString* COLUMN_TYPE_NUMBER = @"N";

//static int STATUS_SUCCESS = 1;
//static int STATUS_FAILURE = -1;

/**保存查询条件名*/
static NSString* SEARCHNAME=@"iplat4jSName";

/** 总计map名称 放置于block的attr属性中**/
static NSString* COLUMN_TOTAL_SUM = @"columnTotalSum";
/**动态查询，查询条件块，排序块*/
static NSString* queryConditionBlock = @"inqu_dy";
static NSString* queryOrderBlock = @"inqu_dy_orderby";


static NSString* anonymous = @"anonymous";


static NSString* COLUMN_NAME = @"name";

static NSString* COLUMN_POS = @"pos";

static NSString* COLUMN_DESC_NAME = @"descName";

static NSString* COLUMN_TYPE = @"type";

static NSString* COLUMN_REGEX = @"regex";

static NSString* COLUMN_FORMATTER = @"formatter";

static NSString* COLUMN_EDITOR = @"editor";

static NSString* COLUMN_LENGTH_MIN = @"minLength";

static NSString* COLUMN_LENGTH_MAX = @"maxLength";

static NSString* COLUMN_PRIMARYKEY = @"primaryKey";

static NSString* COLUMN_NULLABLE = @"nullable";

static NSString* COLUMN_WIDTH = @"width";

static NSString* COLUMN_HEIGHT = @"height";

static NSString* COLUMN_ALIGN = @"align";

static NSString* COLUMN_DISPLAYTYPE = @"displayType";

static NSString* COLUMN_DATEFORMAT = @"dateFormat";

static NSString* COLUMN_VALIDATETYPE = @"validateType";

static NSString* COLUMN_DEFAULTVALUE = @"defaultValue";

static NSString* COLUMN_ERRORPROMPT = @"errorPrompt";

static NSString* COLUMN_VISIBLE = @"visible";

static NSString* COLUMN_READONLY = @"readonly";

static NSString* COLUMN_BLOCKNAME = @"blockName";

static NSString* COLUMN_SOURCENAME = @"sourceName";

static NSString* COLUMN_LABELPROPERTY = @"labelProperty";

static NSString* COLUMN_VALUEPROPERTY = @"valueProperty";

static NSString* COLUMN_ATTR_ENABLE = @"enable";

static NSString* COLUMN_ATTR_SERVICENAME = @"serviceName";

static NSString* COLUMN_ATTR_QUERYMETHOD = @"queryMethod";

static NSString* COLUMN_SORT = @"sort";

static NSString* COLUMN_CANPERSONAL = @"canPersonal";

static NSString* COLUMN_SUMTYPE = @"sumType";

