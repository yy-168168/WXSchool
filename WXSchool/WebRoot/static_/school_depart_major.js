var school = new Array();
var depart = new Array();
var major = new Array();

//学校
school['gh_b315c2abe8ce'] = '哈尔滨师范大学';
school['gh_26842d2f265d'] = '浙江师范大学';
school['gh_bfcaab4728a8'] = '江西农业大学';
school['gh_f3340ae1a364'] = '石家庄经济学院华信学院';
school['gh_8ee3037c7c58'] = '掌上南铁';
school['gh_b2edc49c87a2'] = '江西财经大学';

//院系
//-----------
depart['gh_b315c2abe8ce'] = new Array();
depart['gh_b315c2abe8ce'][1] = '文学院';
depart['gh_b315c2abe8ce'][2] = '历史文化学院';
depart['gh_b315c2abe8ce'][3] = '马克思主义学院';
depart['gh_b315c2abe8ce'][4] = '法学院';
depart['gh_b315c2abe8ce'][5] = '教育科学学院';
depart['gh_b315c2abe8ce'][6] = '经济学院';
depart['gh_b315c2abe8ce'][7] = '管理学院';
depart['gh_b315c2abe8ce'][8] = '西语学院';
depart['gh_b315c2abe8ce'][9] = '东语学院';
depart['gh_b315c2abe8ce'][10] = '斯拉夫语学院';
depart['gh_b315c2abe8ce'][11] = '数学科学学院';
depart['gh_b315c2abe8ce'][12] = '计算机科学与信息工程学院';
depart['gh_b315c2abe8ce'][13] = '物理与电子工程学院';
depart['gh_b315c2abe8ce'][14] = '化学化工学院';
depart['gh_b315c2abe8ce'][15] = '生命科学与技术学院';
depart['gh_b315c2abe8ce'][16] = '地理科学学院';
depart['gh_b315c2abe8ce'][17] = '音乐学院';
depart['gh_b315c2abe8ce'][18] = '美术学院';
depart['gh_b315c2abe8ce'][19] = '传媒学院';
depart['gh_b315c2abe8ce'][20] = '体育科学学院';


//-------------
depart['gh_26842d2f265d'] = new Array();
depart['gh_26842d2f265d'][1] = '初阳学院';
depart['gh_26842d2f265d'][2] = '经管学院';
depart['gh_26842d2f265d'][3] = '法政学院';
depart['gh_26842d2f265d'][4] = '教育学院';
depart['gh_26842d2f265d'][5] = '幼师学院';
depart['gh_26842d2f265d'][6] = '体育学院';
depart['gh_26842d2f265d'][7] = '人文学院';
depart['gh_26842d2f265d'][8] = '音乐学院';
depart['gh_26842d2f265d'][9] = '美术学院';
depart['gh_26842d2f265d'][10] = '文传学院';
depart['gh_26842d2f265d'][11] = '数理信息学院';
depart['gh_26842d2f265d'][12] = '生化学院';
depart['gh_26842d2f265d'][13] = '地理环境学院';
depart['gh_26842d2f265d'][14] = '工学职教学院';
depart['gh_26842d2f265d'][15] = '外语院';
depart['gh_26842d2f265d'][16] = '国际学院';
depart['gh_26842d2f265d'][17] = '中非商学院';
depart['gh_26842d2f265d'][18] = '行知商学分院';
depart['gh_26842d2f265d'][19] = '行知法学分院';
depart['gh_26842d2f265d'][20] = '行知文学分院';
depart['gh_26842d2f265d'][21] = '行知艺体分院';
depart['gh_26842d2f265d'][22] = '行知理学分院';
depart['gh_26842d2f265d'][23] = '行知工学分院';

//---------
depart['gh_bfcaab4728a8'] = new Array();
depart['gh_bfcaab4728a8'][1] = '园林院';
depart['gh_bfcaab4728a8'][2] = '动科院';
depart['gh_bfcaab4728a8'][3] = '工学院';
depart['gh_bfcaab4728a8'][4] = '经管院';
depart['gh_bfcaab4728a8'][5] = '人文院';
depart['gh_bfcaab4728a8'][6] = '生工院';
depart['gh_bfcaab4728a8'][7] = '食品院';
depart['gh_bfcaab4728a8'][8] = '国土院';
depart['gh_bfcaab4728a8'][9] = '计信院';
depart['gh_bfcaab4728a8'][10] = '理学院';
depart['gh_bfcaab4728a8'][11] = '外语院';
depart['gh_bfcaab4728a8'][12] = '职师院';
depart['gh_bfcaab4728a8'][13] = '软件院';
depart['gh_bfcaab4728a8'][14] = '农学院';

//-------------
depart['gh_f3340ae1a364'] = new Array();
depart['gh_f3340ae1a364'][1] = '电子信息学院';
depart['gh_f3340ae1a364'][2] = '文法系管理学院';
depart['gh_f3340ae1a364'][3] = '资源环境学院';
depart['gh_f3340ae1a364'][4] = '会计学院';
depart['gh_f3340ae1a364'][5] = '护理学院';

//-------------
depart['gh_8ee3037c7c58'] = new Array();
depart['gh_8ee3037c7c58'][1] = '电力工程学院';
depart['gh_8ee3037c7c58'][2] = '经贸学院';
depart['gh_8ee3037c7c58'][3] = '软件与艺术设计学院';
depart['gh_8ee3037c7c58'][4] = '通信信号学院';
depart['gh_8ee3037c7c58'][5] = '运输管理学院';
depart['gh_8ee3037c7c58'][6] = '机车车辆学院';

//-------------
depart['gh_b2edc49c87a2'] = new Array();
depart['gh_b2edc49c87a2'][1] = '国际学院';
depart['gh_b2edc49c87a2'][2] = '工商管理学院';
depart['gh_b2edc49c87a2'][3] = '财税与公共管理学院';
depart['gh_b2edc49c87a2'][4] = '会计学院';
depart['gh_b2edc49c87a2'][5] = '国际经贸学院';
depart['gh_b2edc49c87a2'][6] = '经济学院';
depart['gh_b2edc49c87a2'][7] = '金融学院';
depart['gh_b2edc49c87a2'][8] = '统计学院';
depart['gh_b2edc49c87a2'][9] = '信息管理学院';
depart['gh_b2edc49c87a2'][10] = '旅游与城市管理学院';
depart['gh_b2edc49c87a2'][11] = '法学院';
depart['gh_b2edc49c87a2'][12] = '软件与通信工程学院';
depart['gh_b2edc49c87a2'][13] = '外国语学院';
depart['gh_b2edc49c87a2'][14] = '人文学院';
depart['gh_b2edc49c87a2'][15] = '艺术学院 ';
depart['gh_b2edc49c87a2'][16] = '体育学院';


//专业
//-----------
major['gh_b315c2abe8ce'] = new Array();

major['gh_b315c2abe8ce'][0] = new Array();
major['gh_b315c2abe8ce'][0][1] = '专业';

major['gh_b315c2abe8ce'][1] = new Array();
major['gh_b315c2abe8ce'][1][1] = '汉语言文学';
major['gh_b315c2abe8ce'][1][2] = '汉语言文学（非师范）';
major['gh_b315c2abe8ce'][1][3] = '汉语国际教育';

major['gh_b315c2abe8ce'][2] = new Array();
major['gh_b315c2abe8ce'][2][1] = '历史学';
major['gh_b315c2abe8ce'][2][2] = '文物保护技术';
major['gh_b315c2abe8ce'][2][3] = '旅游管理';

major['gh_b315c2abe8ce'][3] = new Array();
major['gh_b315c2abe8ce'][3][1] = '思想政治教育';

major['gh_b315c2abe8ce'][4] = new Array();
major['gh_b315c2abe8ce'][4][1] = '法学';

major['gh_b315c2abe8ce'][5] = new Array();
major['gh_b315c2abe8ce'][5][1] = '教育学';
major['gh_b315c2abe8ce'][5][2] = '心理学';
major['gh_b315c2abe8ce'][5][3] = '教育技术学';
major['gh_b315c2abe8ce'][5][4] = '小学教育';
major['gh_b315c2abe8ce'][5][5] = '学前教育';

major['gh_b315c2abe8ce'][6] = new Array();
major['gh_b315c2abe8ce'][6][1] = '经济学';
major['gh_b315c2abe8ce'][6][2] = '会计学';
major['gh_b315c2abe8ce'][6][3] = '贸易经济';
major['gh_b315c2abe8ce'][6][4] = '经济统计学';

major['gh_b315c2abe8ce'][7] = new Array();
major['gh_b315c2abe8ce'][7][1] = '人力资源管理';
major['gh_b315c2abe8ce'][7][2] = '市场营销';
major['gh_b315c2abe8ce'][7][3] = '物流管理';
major['gh_b315c2abe8ce'][7][4] = '公共事业管理';
major['gh_b315c2abe8ce'][7][5] = '社会工作';
major['gh_b315c2abe8ce'][7][6] = '劳动会社会保障';
major['gh_b315c2abe8ce'][7][7] = '行政管理';

major['gh_b315c2abe8ce'][8] = new Array();
major['gh_b315c2abe8ce'][8][1] = '英语';
major['gh_b315c2abe8ce'][8][2] = '英语（非师范）';
major['gh_b315c2abe8ce'][8][3] = '英语（非师范，中英合作）';
major['gh_b315c2abe8ce'][8][4] = '翻译';
major['gh_b315c2abe8ce'][8][5] = '法语';
major['gh_b315c2abe8ce'][8][6] = '葡萄牙语';
major['gh_b315c2abe8ce'][8][7] = '西班牙语';

major['gh_b315c2abe8ce'][9] = new Array();
major['gh_b315c2abe8ce'][9][1] = '日语';
major['gh_b315c2abe8ce'][9][2] = '日语（非师范）';
major['gh_b315c2abe8ce'][9][3] = '朝鲜语';
major['gh_b315c2abe8ce'][9][4] = '阿拉伯语';

major['gh_b315c2abe8ce'][10] = new Array();
major['gh_b315c2abe8ce'][10][1] = '俄语';
major['gh_b315c2abe8ce'][10][2] = '俄语（非师范）';
major['gh_b315c2abe8ce'][10][3] = '波兰语';

major['gh_b315c2abe8ce'][11] = new Array();
major['gh_b315c2abe8ce'][11][1] = '数学与应用数学';
major['gh_b315c2abe8ce'][11][2] = '信息与计算科学';
major['gh_b315c2abe8ce'][11][3] = '应用统计学';

major['gh_b315c2abe8ce'][12] = new Array();
major['gh_b315c2abe8ce'][12][1] = '计算机科学与技术';
major['gh_b315c2abe8ce'][12][2] = '数字媒体技术';
major['gh_b315c2abe8ce'][12][3] = '软件工程';
major['gh_b315c2abe8ce'][12][4] = '物联网工程';

major['gh_b315c2abe8ce'][13] = new Array();
major['gh_b315c2abe8ce'][13][1] = '物理学';
major['gh_b315c2abe8ce'][13][2] = '电子信息科学与技术';

major['gh_b315c2abe8ce'][14] = new Array();
major['gh_b315c2abe8ce'][14][1] = '化学';
major['gh_b315c2abe8ce'][14][2] = '材料化学';
major['gh_b315c2abe8ce'][14][3] = '制药工程';

major['gh_b315c2abe8ce'][15] = new Array();
major['gh_b315c2abe8ce'][15][1] = '生物科学';
major['gh_b315c2abe8ce'][15][2] = '生物技术';
major['gh_b315c2abe8ce'][15][3] = '园林';
major['gh_b315c2abe8ce'][15][4] = '生态学';

major['gh_b315c2abe8ce'][16] = new Array();
major['gh_b315c2abe8ce'][16][1] = '地理科学';
major['gh_b315c2abe8ce'][16][2] = '自然地理与资源环境';
major['gh_b315c2abe8ce'][16][3] = '人文地理与城乡规划';
major['gh_b315c2abe8ce'][16][4] = '地理信息科学';
major['gh_b315c2abe8ce'][16][5] = '资源勘查工程';

major['gh_b315c2abe8ce'][17] = new Array();
major['gh_b315c2abe8ce'][17][1] = '作曲与作曲技术理论';
major['gh_b315c2abe8ce'][17][2] = '音乐表演';
major['gh_b315c2abe8ce'][17][3] = '音乐学';
major['gh_b315c2abe8ce'][17][4] = '舞蹈编导';
major['gh_b315c2abe8ce'][17][5] = '表演';

major['gh_b315c2abe8ce'][18] = new Array();
major['gh_b315c2abe8ce'][18][1] = '美术学';
major['gh_b315c2abe8ce'][18][2] = '中国画';
major['gh_b315c2abe8ce'][18][3] = '书法学';
major['gh_b315c2abe8ce'][18][4] = '服装与服饰的设计';
major['gh_b315c2abe8ce'][18][5] = '视觉传达设计';
major['gh_b315c2abe8ce'][18][6] = '雕塑';
major['gh_b315c2abe8ce'][18][7] = '工艺美术';
major['gh_b315c2abe8ce'][18][8] = '环境艺术';
major['gh_b315c2abe8ce'][18][9] = '产品设计';
major['gh_b315c2abe8ce'][18][10] = '绘画';

major['gh_b315c2abe8ce'][19] = new Array();
major['gh_b315c2abe8ce'][19][1] = '广播电视编导';
major['gh_b315c2abe8ce'][19][2] = '播音与主持艺术';
major['gh_b315c2abe8ce'][19][3] = '广播电视学';
major['gh_b315c2abe8ce'][19][4] = '动画';
major['gh_b315c2abe8ce'][19][5] = '摄影';
major['gh_b315c2abe8ce'][19][6] = '数字媒体艺术';
major['gh_b315c2abe8ce'][19][7] = '录音艺术';
major['gh_b315c2abe8ce'][19][8] = '表演（影视表演）';

major['gh_b315c2abe8ce'][20] = new Array();
major['gh_b315c2abe8ce'][20][1] = '体育教育';
major['gh_b315c2abe8ce'][20][2] = '运动训练';
major['gh_b315c2abe8ce'][20][3] = '社会体育指导与管理';
major['gh_b315c2abe8ce'][20][4] = '武术与民族传统体育';
major['gh_b315c2abe8ce'][20][5] = '运动康复';

//--------------
major['gh_26842d2f265d'] = new Array();

major['gh_26842d2f265d'][0] = new Array();
major['gh_26842d2f265d'][0][1] = '专业';

major['gh_26842d2f265d'][1] = new Array();
major['gh_26842d2f265d'][1][1] = '英语';
major['gh_26842d2f265d'][1][2] = '汉语言文学';
major['gh_26842d2f265d'][1][3] = '对外汉语';
major['gh_26842d2f265d'][1][4] = '历史学';
major['gh_26842d2f265d'][1][5] = '思想政治教育';
major['gh_26842d2f265d'][1][6] = '法学';
major['gh_26842d2f265d'][1][7] = '小学教育';
major['gh_26842d2f265d'][1][8] = '应用心理学';
major['gh_26842d2f265d'][1][9] = '地理科学';
major['gh_26842d2f265d'][1][10] = '数学与应用数学';
major['gh_26842d2f265d'][1][11] = '物理学';
major['gh_26842d2f265d'][1][12] = '化学';
major['gh_26842d2f265d'][1][13] = '生物科学';
major['gh_26842d2f265d'][1][14] = '地理科学';
major['gh_26842d2f265d'][1][15] = '应用心理科学';

major['gh_26842d2f265d'][2] = new Array();
major['gh_26842d2f265d'][2][1] = '财务管理';
major['gh_26842d2f265d'][2][2] = '会计学';
major['gh_26842d2f265d'][2][3] = '电子商务';
major['gh_26842d2f265d'][2][4] = '市场营销';
major['gh_26842d2f265d'][2][5] = '工商管理';
major['gh_26842d2f265d'][2][6] = '国际经济与贸易';
major['gh_26842d2f265d'][2][7] = '金融学';
major['gh_26842d2f265d'][2][8] = '旅游管理与服务教育';
major['gh_26842d2f265d'][2][9] = '财务会计教育';

major['gh_26842d2f265d'][3] = new Array();
major['gh_26842d2f265d'][3][1] = '思想政治教育';
major['gh_26842d2f265d'][3][2] = '法学';
major['gh_26842d2f265d'][3][3] = '社会工作';
major['gh_26842d2f265d'][3][4] = '行政管理';

major['gh_26842d2f265d'][4] = new Array();
major['gh_26842d2f265d'][4][1] = '小学教育';
major['gh_26842d2f265d'][4][2] = '应用心理学';
major['gh_26842d2f265d'][4][3] = '教育技术学';

major['gh_26842d2f265d'][5] = new Array();
major['gh_26842d2f265d'][5][1] = '学前教育';
major['gh_26842d2f265d'][5][2] = '特殊教育';
major['gh_26842d2f265d'][5][3] = '艺术教育';
major['gh_26842d2f265d'][5][4] = '动画';

major['gh_26842d2f265d'][6] = new Array();
major['gh_26842d2f265d'][6][1] = '体育教育';
major['gh_26842d2f265d'][6][2] = '社会体育';

major['gh_26842d2f265d'][7] = new Array();
major['gh_26842d2f265d'][7][1] = '汉语言文学';
major['gh_26842d2f265d'][7][2] = '历史学';
major['gh_26842d2f265d'][7][3] = '人文教育';

major['gh_26842d2f265d'][8] = Array();
major['gh_26842d2f265d'][8][1] = '音乐学';
major['gh_26842d2f265d'][8][2] = '音乐表演';

major['gh_26842d2f265d'][9] = new Array();
major['gh_26842d2f265d'][9][1] = '美术学';
major['gh_26842d2f265d'][9][2] = '环境设计';
major['gh_26842d2f265d'][9][3] = '产品设计';
major['gh_26842d2f265d'][9][4] = '视觉传达设计';

major['gh_26842d2f265d'][10] = new Array();
major['gh_26842d2f265d'][10][1] = '广告学';
major['gh_26842d2f265d'][10][2] = '戏剧影视';
major['gh_26842d2f265d'][10][3] = '数字媒体技术';
major['gh_26842d2f265d'][10][4] = '文化产业管理';

major['gh_26842d2f265d'][11] = new Array();
major['gh_26842d2f265d'][11][1] = '数学与应用数学';
major['gh_26842d2f265d'][11][2] = '信息与计算科学';
major['gh_26842d2f265d'][11][3] = '物理学';
major['gh_26842d2f265d'][11][4] = '光电信息工程';
major['gh_26842d2f265d'][11][5] = '材料物理';
major['gh_26842d2f265d'][11][6] = '计算机科学与技术(师范)';
major['gh_26842d2f265d'][11][7] = '计算机科学与技术(非师范)';
major['gh_26842d2f265d'][11][8] = '电子信息工程';
major['gh_26842d2f265d'][11][9] = '通信工程';
major['gh_26842d2f265d'][11][10] = '软件工程';
major['gh_26842d2f265d'][11][11] = '网络工程';

major['gh_26842d2f265d'][12] = new Array();
major['gh_26842d2f265d'][12][1] = '化学';
major['gh_26842d2f265d'][12][2] = '生物科学）';
major['gh_26842d2f265d'][12][3] = '应用化学';
major['gh_26842d2f265d'][12][4] = '生物技术与科学教育';
major['gh_26842d2f265d'][12][5] = '硕士招收';
major['gh_26842d2f265d'][12][6] = '培养研究生';

major['gh_26842d2f265d'][13] = new Array();
major['gh_26842d2f265d'][13][1] = '地理科学';
major['gh_26842d2f265d'][13][2] = '环境科学';
major['gh_26842d2f265d'][13][3] = '城市规划';

major['gh_26842d2f265d'][14] = new Array();
major['gh_26842d2f265d'][14][1] = '应用电子技术教育';
major['gh_26842d2f265d'][14][2] = '汽车维修工程教育';
major['gh_26842d2f265d'][14][3] = '工业设计';
major['gh_26842d2f265d'][14][4] = '机械设计制造及其自动化';
major['gh_26842d2f265d'][14][5] = '交通运输';

major['gh_26842d2f265d'][15] = new Array();
major['gh_26842d2f265d'][15][1] = '英语';
major['gh_26842d2f265d'][15][2] = '日语';
major['gh_26842d2f265d'][15][3] = '翻译';

major['gh_26842d2f265d'][16] = new Array();
major['gh_26842d2f265d'][16][1] = '汉语国际教育';

major['gh_26842d2f265d'][17] = new Array();
major['gh_26842d2f265d'][17][1] = '国际经济与贸易';

major['gh_26842d2f265d'][18] = new Array();
major['gh_26842d2f265d'][18][1] = '国际经济与贸易';
major['gh_26842d2f265d'][18][2] = '金融学';
major['gh_26842d2f265d'][18][3] = '会计学';
major['gh_26842d2f265d'][18][4] = '财务管理';
major['gh_26842d2f265d'][18][5] = '工商管理';
major['gh_26842d2f265d'][18][6] = '市场营销';
major['gh_26842d2f265d'][18][7] = '电子商务';
major['gh_26842d2f265d'][18][8] = '旅游管理';

major['gh_26842d2f265d'][19] = new Array();
major['gh_26842d2f265d'][19][1] = '法学';

major['gh_26842d2f265d'][20] = new Array();
major['gh_26842d2f265d'][20][1] = '汉语言文学';
major['gh_26842d2f265d'][20][2] = '英语';

major['gh_26842d2f265d'][21] = new Array();
major['gh_26842d2f265d'][21][1] = '视觉传达设计';
major['gh_26842d2f265d'][21][2] = '环境设计';
major['gh_26842d2f265d'][21][3] = '产品设计';

major['gh_26842d2f265d'][22] = new Array();
major['gh_26842d2f265d'][22][1] = '应用化学';
major['gh_26842d2f265d'][22][2] = '生物技术';

major['gh_26842d2f265d'][23] = new Array();
major['gh_26842d2f265d'][23][1] = '计算机科学与技术';
major['gh_26842d2f265d'][23][2] = '电子信息工程';
major['gh_26842d2f265d'][23][3] = '机械设计制造及其自动化';

//----------
major['gh_bfcaab4728a8'] = new Array();

major['gh_bfcaab4728a8'][0] = new Array();
major['gh_bfcaab4728a8'][0][1] = '专业';

major['gh_bfcaab4728a8'][1] = new Array();
major['gh_bfcaab4728a8'][1][1] = '林学';
major['gh_bfcaab4728a8'][1][2] = '园林';
major['gh_bfcaab4728a8'][1][3] = '风景园林';
major['gh_bfcaab4728a8'][1][4] = '林产化工';
major['gh_bfcaab4728a8'][1][5] = '城市规划';
major['gh_bfcaab4728a8'][1][6] = '中药资源与开发';
major['gh_bfcaab4728a8'][1][7] = '艺术设计';


major['gh_bfcaab4728a8'][2] = new Array();
major['gh_bfcaab4728a8'][2][1] = '动物科学';
major['gh_bfcaab4728a8'][2][2] = '动物医学';
major['gh_bfcaab4728a8'][2][3] = '动物药学';
major['gh_bfcaab4728a8'][2][4] = '动物水产养殖学';

major['gh_bfcaab4728a8'][3] = new Array();
major['gh_bfcaab4728a8'][3][1] = '农业机械及其自动化';
major['gh_bfcaab4728a8'][3][2] = '机械设计制造及其自动化';
major['gh_bfcaab4728a8'][3][3] = '土木工程';
major['gh_bfcaab4728a8'][3][4] = '交通运输';
major['gh_bfcaab4728a8'][3][5] = '工程管理';
major['gh_bfcaab4728a8'][3][6] = '电子信息工程';
major['gh_bfcaab4728a8'][3][7] = '农业建筑环境与能源';
major['gh_bfcaab4728a8'][3][8] = '车辆工程';

major['gh_bfcaab4728a8'][4] = new Array();
major['gh_bfcaab4728a8'][4][1] = '农林经济管理';
major['gh_bfcaab4728a8'][4][2] = '工商管理';
major['gh_bfcaab4728a8'][4][3] = '经济学';
major['gh_bfcaab4728a8'][4][4] = '会计学';
major['gh_bfcaab4728a8'][4][5] = '金融学';
major['gh_bfcaab4728a8'][4][6] = '财务管理';
major['gh_bfcaab4728a8'][4][7] = '市场营销';
major['gh_bfcaab4728a8'][4][8] = '国际经济与贸易';
major['gh_bfcaab4728a8'][4][9] = '劳动与社会保障';

major['gh_bfcaab4728a8'][5] = new Array();
major['gh_bfcaab4728a8'][5][1] = '汉语言文学';
major['gh_bfcaab4728a8'][5][2] = '新闻学';
major['gh_bfcaab4728a8'][5][3] = '法学';
major['gh_bfcaab4728a8'][5][4] = '管理科学';
major['gh_bfcaab4728a8'][5][5] = '公共事业管理';
major['gh_bfcaab4728a8'][5][6] = '音乐表演';

major['gh_bfcaab4728a8'][6] = new Array();
major['gh_bfcaab4728a8'][6][1] = '生物工程';
major['gh_bfcaab4728a8'][6][2] = '生物科学';
major['gh_bfcaab4728a8'][6][3] = '生物技术';
major['gh_bfcaab4728a8'][6][4] = '制药工程';

major['gh_bfcaab4728a8'][7] = new Array();
major['gh_bfcaab4728a8'][7][1] = '食品科学与工程';
major['gh_bfcaab4728a8'][7][2] = '食品质量与安全';
major['gh_bfcaab4728a8'][7][3] = '轻化工程';
major['gh_bfcaab4728a8'][7][4] = '制药工程';

major['gh_bfcaab4728a8'][8] = new Array();
major['gh_bfcaab4728a8'][8][1] = '土地资源管理';
major['gh_bfcaab4728a8'][8][2] = '农业水利工程';
major['gh_bfcaab4728a8'][8][3] = '农业资源与环境';
major['gh_bfcaab4728a8'][8][4] = '环境科学';
major['gh_bfcaab4728a8'][8][5] = '环境工程';
major['gh_bfcaab4728a8'][8][6] = '地理信息科学';
major['gh_bfcaab4728a8'][8][7] = '旅游管理';

major['gh_bfcaab4728a8'][9] = new Array();
major['gh_bfcaab4728a8'][9][1] = '计算机科学与技术';
major['gh_bfcaab4728a8'][9][2] = '信息管理与信息系统';
major['gh_bfcaab4728a8'][9][3] = '网络工程';
major['gh_bfcaab4728a8'][9][4] = '电子商务';
major['gh_bfcaab4728a8'][9][5] = '数字媒体技术';

major['gh_bfcaab4728a8'][10] = new Array();
major['gh_bfcaab4728a8'][10][1] = '信息与计算科学';
major['gh_bfcaab4728a8'][10][2] = '应用化学';

major['gh_bfcaab4728a8'][11] = new Array();
major['gh_bfcaab4728a8'][11][1] = '英语';
major['gh_bfcaab4728a8'][11][2] = '日语';
major['gh_bfcaab4728a8'][11][3] = '商务英语';

major['gh_bfcaab4728a8'][12] = new Array();
major['gh_bfcaab4728a8'][12][1] = '教育技术学';
major['gh_bfcaab4728a8'][12][2] = '文秘教育';
major['gh_bfcaab4728a8'][12][3] = '应用电子技术教育';
major['gh_bfcaab4728a8'][12][4] = '财务会计教育';
major['gh_bfcaab4728a8'][12][5] = '应用心理学';

major['gh_bfcaab4728a8'][13] = new Array();
major['gh_bfcaab4728a8'][13][1] = '软件工程';
major['gh_bfcaab4728a8'][13][2] = '软英';
major['gh_bfcaab4728a8'][13][3] = '物联网工程';

major['gh_bfcaab4728a8'][14] = new Array();
major['gh_bfcaab4728a8'][14][1] = '农学';
major['gh_bfcaab4728a8'][14][2] = '园艺';
major['gh_bfcaab4728a8'][14][3] = '植物保护';
major['gh_bfcaab4728a8'][14][4] = '动植物检疫';
major['gh_bfcaab4728a8'][14][5] = '种子科学与工程';
major['gh_bfcaab4728a8'][14][6] = '茶学';

//----------
major['gh_f3340ae1a364'] = new Array();

major['gh_f3340ae1a364'][0] = new Array();
major['gh_f3340ae1a364'][0][1] = '专业';

//----------
major['gh_8ee3037c7c58'] = new Array();

major['gh_8ee3037c7c58'][0] = new Array();
major['gh_8ee3037c7c58'][0][1] = '专业';

major['gh_8ee3037c7c58'][1] = new Array();
major['gh_8ee3037c7c58'][1][1] = '工程造价';
major['gh_8ee3037c7c58'][1][2] = '铁道工程';
major['gh_8ee3037c7c58'][1][3] = '铁道工程（预算）';
major['gh_8ee3037c7c58'][1][4] = '铁道供电';
major['gh_8ee3037c7c58'][1][5] = '铁道供电3+2';

major['gh_8ee3037c7c58'][2] = new Array();
major['gh_8ee3037c7c58'][2][1] = '国际商务';
major['gh_8ee3037c7c58'][2][2] = '国际商务（报关）';
major['gh_8ee3037c7c58'][2][3] = '国际商务（海本）';
major['gh_8ee3037c7c58'][2][4] = '国际商务（中外）';
major['gh_8ee3037c7c58'][2][5] = '会计';
major['gh_8ee3037c7c58'][2][6] = '会计(中外)';
major['gh_8ee3037c7c58'][2][7] = '连锁经营';
major['gh_8ee3037c7c58'][2][8] = '市场营销';
major['gh_8ee3037c7c58'][2][9] = '物流(3+2)';
major['gh_8ee3037c7c58'][2][10] = '物流(国际)';
major['gh_8ee3037c7c58'][2][11] = '物流(企业)';
major['gh_8ee3037c7c58'][2][12] = '物流(铁路)';
major['gh_8ee3037c7c58'][2][13] = '物流管理';

major['gh_8ee3037c7c58'][3] = new Array();
major['gh_8ee3037c7c58'][3][1] = '动画设计';
major['gh_8ee3037c7c58'][3][2] = '动漫设计';
major['gh_8ee3037c7c58'][3][3] = '广告设计';
major['gh_8ee3037c7c58'][3][4] = '环艺（室内）';
major['gh_8ee3037c7c58'][3][5] = '计算机网络';
major['gh_8ee3037c7c58'][3][6] = '计算机网络3+2';
major['gh_8ee3037c7c58'][3][7] = '计算机网络技术';
major['gh_8ee3037c7c58'][3][8] = '计算机应用';
major['gh_8ee3037c7c58'][3][9] = '景观设计';
major['gh_8ee3037c7c58'][3][10] = '软件技术';
major['gh_8ee3037c7c58'][3][11] = '室内设计';
major['gh_8ee3037c7c58'][3][12] = '室内设计(景观)';
major['gh_8ee3037c7c58'][3][13] = '数字媒体设计';
major['gh_8ee3037c7c58'][3][14] = '网络技术（3+2）';
major['gh_8ee3037c7c58'][3][15] = '网络技术（安防技术）';

major['gh_8ee3037c7c58'][4] = new Array();
major['gh_8ee3037c7c58'][4][1] = '城市轨道交通控制';
major['gh_8ee3037c7c58'][4][2] = '电气自动化技术';
major['gh_8ee3037c7c58'][4][3] = '高速铁路信号与控制';
major['gh_8ee3037c7c58'][4][4] = '铁道通信信号';
major['gh_8ee3037c7c58'][4][5] = '通信技术';

major['gh_8ee3037c7c58'][5] = new Array();
major['gh_8ee3037c7c58'][5][1] = '城市交通运营管理';
major['gh_8ee3037c7c58'][5][2] = '高速铁路动车乘务';
major['gh_8ee3037c7c58'][5][3] = '铁道交通运营管理';
major['gh_8ee3037c7c58'][5][4] = '旅游管理';

major['gh_8ee3037c7c58'][6] = new Array();
major['gh_8ee3037c7c58'][6][1] = '城轨车辆';
major['gh_8ee3037c7c58'][6][2] = '动车组检修';
major['gh_8ee3037c7c58'][6][3] = '机车车辆';
major['gh_8ee3037c7c58'][6][4] = '铁道车辆';

//----------
major['gh_b2edc49c87a2'] = new Array();

major['gh_b2edc49c87a2'][0] = new Array();
major['gh_b2edc49c87a2'][0][1] = '专业';

major['gh_b2edc49c87a2'][1] = new Array();
major['gh_b2edc49c87a2'][1][1] = '会计学（国际会计）';
major['gh_b2edc49c87a2'][1][2] = '金融学（国际金融）';
major['gh_b2edc49c87a2'][1][3] = '金融学（CFA方向-注册金融分析师）';
major['gh_b2edc49c87a2'][1][4] = '国际经济与贸易（CITF方向-特许国际贸易金融师）';

major['gh_b2edc49c87a2'][2] = new Array();
major['gh_b2edc49c87a2'][2][1] = '工商管理';
major['gh_b2edc49c87a2'][2][2] = '人力资源管理';
major['gh_b2edc49c87a2'][2][3] = '市场营销';
major['gh_b2edc49c87a2'][2][4] = '物流管理';
major['gh_b2edc49c87a2'][2][5] = '市场营销（国际市场营销）';

major['gh_b2edc49c87a2'][3] = new Array();
major['gh_b2edc49c87a2'][3][1] = '财政学';
major['gh_b2edc49c87a2'][3][2] = '税收学';
major['gh_b2edc49c87a2'][3][3] = '劳动与社会保障';
major['gh_b2edc49c87a2'][3][4] = '行政管理';

major['gh_b2edc49c87a2'][4] = new Array();
major['gh_b2edc49c87a2'][4][1] = '会计学';
major['gh_b2edc49c87a2'][4][2] = '财务管理';
major['gh_b2edc49c87a2'][4][3] = '会计学（注册会计师）';
major['gh_b2edc49c87a2'][4][4] = '会计学（CIMA方向-特许管理会计师）';
major['gh_b2edc49c87a2'][4][5] = '会计学（ACCA方向-英国特许注册会计师）';

major['gh_b2edc49c87a2'][5] = new Array();
major['gh_b2edc49c87a2'][5][1] = '贸易经济';
major['gh_b2edc49c87a2'][5][2] = '国际经济与贸易';
major['gh_b2edc49c87a2'][5][3] = '国际商务';
major['gh_b2edc49c87a2'][5][4] = '电子商务';
major['gh_b2edc49c87a2'][5][5] = '国际经济与贸易（国际投资与结算）';
major['gh_b2edc49c87a2'][5][6] = '国际经济与贸易';
major['gh_b2edc49c87a2'][5][7] = '电子商务';

major['gh_b2edc49c87a2'][6] = new Array();
major['gh_b2edc49c87a2'][6][1] = '经济学';
major['gh_b2edc49c87a2'][6][2] = '国民经济管理';

major['gh_b2edc49c87a2'][7] = new Array();
major['gh_b2edc49c87a2'][7][1] = '金融学';
major['gh_b2edc49c87a2'][7][2] = '保险学';
major['gh_b2edc49c87a2'][7][3] = '金融工程';
major['gh_b2edc49c87a2'][7][4] = '金融学（FRM方向-全球金融风险管理师） ';

major['gh_b2edc49c87a2'][8] = new Array();
major['gh_b2edc49c87a2'][8][1] = '经济统计学';
major['gh_b2edc49c87a2'][8][2] = '应用统计学（金融精算）';

major['gh_b2edc49c87a2'][9] = new Array();
major['gh_b2edc49c87a2'][9][1] = '计算机科学与技术（财经大数据管理）';
major['gh_b2edc49c87a2'][9][2] = '信息与计算科学（经济计量）';
major['gh_b2edc49c87a2'][9][3] = '管理科学（金融风险管理）';
major['gh_b2edc49c87a2'][9][4] = '信息管理与信息系统（互联网金融）';

major['gh_b2edc49c87a2'][10] = new Array();
major['gh_b2edc49c87a2'][10][1] = '工程管理';
major['gh_b2edc49c87a2'][10][2] = '房地产开发与管理';
major['gh_b2edc49c87a2'][10][3] = '土地资源管理';
major['gh_b2edc49c87a2'][10][4] = '旅游管理';

major['gh_b2edc49c87a2'][11] = new Array();
major['gh_b2edc49c87a2'][11][1] = '法学';
major['gh_b2edc49c87a2'][11][2] = '法学（法务会计）';

major['gh_b2edc49c87a2'][12] = new Array();
major['gh_b2edc49c87a2'][12][1] = '通信工程';
major['gh_b2edc49c87a2'][12][2] = '电子信息工程';
major['gh_b2edc49c87a2'][12][3] = '物联网工程';
major['gh_b2edc49c87a2'][12][4] = '软件工程（中外合作办学）';
major['gh_b2edc49c87a2'][12][5] = '软件工程';

major['gh_b2edc49c87a2'][13] = new Array();
major['gh_b2edc49c87a2'][13][1] = '商务英语';
major['gh_b2edc49c87a2'][13][2] = '日语';

major['gh_b2edc49c87a2'][14] = new Array();
major['gh_b2edc49c87a2'][14][1] = '社会工作';
major['gh_b2edc49c87a2'][14][2] = '新闻学';
major['gh_b2edc49c87a2'][14][3] = '广告学';
major['gh_b2edc49c87a2'][14][4] = '文化产业管理';
major['gh_b2edc49c87a2'][14][5] = '汉语国际教育';

major['gh_b2edc49c87a2'][15] = new Array();
major['gh_b2edc49c87a2'][15][1] = '音乐学';
major['gh_b2edc49c87a2'][15][2] = '数字媒体艺术';
major['gh_b2edc49c87a2'][15][3] = '环境设计';
major['gh_b2edc49c87a2'][15][4] = '产品设计';

major['gh_b2edc49c87a2'][16] = new Array();
major['gh_b2edc49c87a2'][16][1] = '社会体育指导与管理';


function init_depart(obj, school, val) {
	//alert(school);
	//alert(val);
	var ops = "";
	if(depart[school]) {
		for ( var i = 1; i < depart[school].length; i++) {
			ops += "<option value=" + depart[school][i] + " label=" + i + ">"
					+ depart[school][i] + "</option>";
		}
	}
	obj.append(ops);
	optionDefaultSelect(obj.children(), val);
}

function init_major(obj, school, depart, val) {
	var ops = "";
	if(major[school][depart] != undefined){
		for ( var i = 1; i < major[school][depart].length; i++) {
			ops += "<option value=" + major[school][depart][i] + ">"
					+ major[school][depart][i] + "</option>";
		}
	}else{
		ops += "<option value=''>专业</option>";
	}
	//obj.empty();
	obj.append(ops);
	optionDefaultSelect(obj.children(), val);
}

/*function optionDefaultSelect(obj, val) {
	$.each(obj, function(i, n) {
		if (n.value == val) {
			n.selected = "selected";
		}
	});
}*/

function init_gradeInSchool(obj) {
	var curDate = new Date();
	var curYear = curDate.getFullYear();
	var start = curYear;
	var len = 5;
	var ops = "";

	if ((curDate.getMonth() + 1) < 8) {
		start = curYear - 1;
		len = 4;
	}

	for ( var i = start; i > start - len; i--) {
		ops += "<option value=" + i + ">" + i + "</option>";
	}
	obj.append(ops);
}