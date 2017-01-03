var province = {
	//'100000' : [ '省', '1', 'province' ],
	'110000' : [ '北京', '1', 'bei jing' ],
	'120000' : [ '天津', '1', 'tian jin' ],
	'130000' : [ '河北省', '1', 'he bei sheng' ],
	'140000' : [ '山西省', '1', 'shan xi sheng' ],
	'150000' : [ '内蒙古自治区', '1', 'nei meng gu zi zhi qu' ],
	'210000' : [ '辽宁省', '1', 'liao ning sheng' ],
	'220000' : [ '吉林省', '1', 'ji lin sheng' ],
	'230000' : [ '黑龙江省', '1', 'hei long jiang sheng' ],
	'310000' : [ '上海', '1', 'shang hai' ],
	'320000' : [ '江苏省', '1', 'jiang su sheng' ],
	'330000' : [ '浙江省', '1', 'zhe jiang sheng' ],
	'340000' : [ '安徽省', '1', 'an hui sheng' ],
	'350000' : [ '福建省', '1', 'fu jian sheng' ],
	'360000' : [ '江西省', '1', 'jiang xi sheng' ],
	'370000' : [ '山东省', '1', 'shan dong sheng' ],
	'410000' : [ '河南省', '1', 'he nan sheng' ],
	'420000' : [ '湖北省', '1', 'hu bei sheng' ],
	'430000' : [ '湖南省', '1', 'hu nan sheng' ],
	'440000' : [ '广东省', '1', 'guang dong sheng' ],
	'450000' : [ '广西壮族自治区', '1', 'guang xi zhuang zu zi zhi qu' ],
	'460000' : [ '海南省', '1', 'hai nan sheng' ],
	'500000' : [ '重庆', '1', 'chong qing' ],
	'510000' : [ '四川省', '1', 'si chuan sheng' ],
	'520000' : [ '贵州省', '1', 'gui zhou sheng' ],
	'530000' : [ '云南省', '1', 'yun nan sheng' ],
	'540000' : [ '西藏自治区', '1', 'xi zang zi zhi qu' ],
	'610000' : [ '陕西省', '1', 'shan xi sheng' ],
	'620000' : [ '甘肃省', '1', 'gan su sheng' ],
	'630000' : [ '青海省', '1', 'qing hai sheng' ],
	'640000' : [ '宁夏回族自治区', '1', 'ning xia hui zu zi zhi qu' ],
	'650000' : [ '新疆维吾尔自治区', '1', 'xin jiang wei wu er zi zhi qu' ],
	'710000' : [ '台湾省', '1', 'tai wan sheng' ],
	'810000' : [ '香港特别行政区', '1', 'xiang gang te bie xing zheng qu' ],
	'820000' : [ '澳门特别行政区', '1', 'ao men te bie xing zheng qu' ],
	'990000' : [ '海外', '1', 'hai wai' ]
};

function init_province(obj, val) {
	var ops = "";
	$.each(province, function(i, n) {
		ops += "<option value=" + n[0] + " label=" + i + ">" + n[0]
				+ "</option>";
	});
	//obj.empty();
	obj.append(ops);
	optionDefaultSelect(obj.children(), val);
}

function init_city(obj, provinceId, val) {
	var ops = "";
	if(provinceId){
		provinceId = parseInt(provinceId);
		var url = "static_/province_city/" + provinceId + ".js";
		$.get(url, function(msg) {
			$.each(province_city, function(i, n) {
				if (n[1] == provinceId) {
					ops += "<option value=" + n[0] + " label=" + i + ">" + n[0]
							+ "</option>";
				}
			});
			//obj.empty();
			obj.append(ops);
			optionDefaultSelect(obj.children(), val);
		});
	}else{
		ops += "<option value='' label=''>市</option>";
		obj.append(ops);
	}
}

function init_county(obj, provinceId, cityId, val) {
	var ops = "";
	if(provinceId){
		if(cityId == null){
			cityId = provinceId.substr(0, 2) + "0100";
		}
		cityId = parseInt(cityId);
		provinceId = parseInt(provinceId);
		var url = "static_/province_city/" + provinceId + ".js";
		$.get(url, function(msg) {
			$.each(province_city, function(i, n) {
				if (n[1] == cityId) {
					ops += "<option value=" + n[0] + " label=" + i + ">" + n[0]
							+ "</option>";
				}
			});
			obj.empty();
			obj.append(ops);
			optionDefaultSelect(obj.children(), val);
		});
	}else{
		ops += "<option value='' label=''>区县</option>";
		obj.empty();
		obj.append(ops);
	}
}

/*function optionDefaultSelect(obj, val) {
	$.each(obj, function(i, n) {
		if (n.value == val) {
			n.selected = "selected";
		}
	});
}*/