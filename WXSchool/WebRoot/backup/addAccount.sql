#第一步：添加账号
INSERT INTO `tb_account`(`wxAccount`, `wxNum`, `wxName`, `fans`, `status`, `textChat`, `voiceChat`, `translate`, `weather`, `express`, `regTime`, `expireTimeOfToken`) 
VALUES ('','','','','2','1','1','1','1','1', now(), now());

#第二步：添加管理员
INSERT INTO `tb_admin`( `wxaccount`, `userwx`, `key`, `token`,  `type`, `regTime`, `status`) 
VALUES ('','','','','account',now(),'1');

#第三步：分配权限
INSERT INTO `tb_permission`( `adminId`, `moduleId`, `edit`) VALUES (,1020,'false');#自定义菜单
INSERT INTO `tb_permission`( `adminId`, `moduleId`, `edit`) VALUES (,1022,'false');#照片活动
INSERT INTO `tb_permission`( `adminId`, `moduleId`, `edit`) VALUES (,2006,'false');#文字活动
INSERT INTO `tb_permission`( `adminId`, `moduleId`, `edit`) VALUES (,2008,'false');#寻物招领
INSERT INTO `tb_permission`( `adminId`, `moduleId`, `edit`) VALUES (,1014,'false');#表白墙
INSERT INTO `tb_permission`( `adminId`, `moduleId`, `edit`) VALUES (,2015,'false');#树洞
INSERT INTO `tb_permission`( `adminId`, `moduleId`, `edit`) VALUES (,1008,'false');#外卖订餐
INSERT INTO `tb_permission`( `adminId`, `moduleId`, `edit`) VALUES (,1015,'false');#自定义回复

#第四步：添加主题
INSERT INTO `tb_topic`(`title`, `desc`, `cate`, `wxaccount`, `pubTime`, `overTime`, `capacity`) 
VALUES ('图片活动', '活动详细说明', '21', '', now(), now(), 50);#图片活动，21/22
INSERT INTO `tb_topic`(`title`, `desc`, `cate`, `wxaccount`, `pubTime`, `overTime`, `capacity`) 
VALUES ('表白活动', '这是表白投票活动', '1', '', now(), now(), 50);#表白活动
INSERT INTO `tb_topic`(`title`, `desc`, `cate`, `wxaccount`, `pubTime`, `overTime`, `capacity`) 
VALUES ('寻物招领', '这是寻物招领版块', '4', '', now(), now(), 50);#寻物招领
INSERT INTO `tb_topic`(`title`, `desc`, `cate`, `wxaccount`, `pubTime`, `overTime`, `capacity`) 
VALUES ('文字投票', '这是一个文字活动', '3', '', now(), now(), 50);#文字活动
INSERT INTO `tb_topic`(`title`, `desc`, `cate`, `wxaccount`, `pubTime`, `overTime`, `capacity`) 
VALUES ('树洞', '这是一个树洞活动', '6', '', now(), now(), 50);#树洞
INSERT INTO `tb_topic`(`title`, `desc`, `cate`, `wxaccount`, `pubTime`, `overTime`, `capacity`) 
VALUES ('餐店', '这是一个餐店', '5', '', now(), now(), 30);#餐店

#第五步：添加图文回复
INSERT INTO `tb_article`(`keyword`, `title`, `desc`, `picUrl`, `locUrl`, `cate`, `wxaccount`) 
VALUES ('key_hole|树洞', '点击进入【树洞】', '那些现实中没有发出的声音，请把它留在这里...', 
'http://t2.qpic.cn/mblogpic/25e64d9aef91c7858f16/460', '/mobile/reply?ac=listshit&topicId=&orderBy=2', 'menu', '');#树洞
INSERT INTO `tb_article`(`keyword`, `title`, `desc`, `picUrl`, `locUrl`, `cate`, `wxaccount`) 
VALUES ('寻物|招领|key_thing', '点击进入【寻物/招领】', '帮助他人，快乐自己', 
'http://yy-pic.bj.bcebos.com/9AisoEscog.jpg', '/mobile/board?ac=listthing&topicId=', 'menu', '');#寻物招领
INSERT INTO `tb_article`(`keyword`, `title`, `desc`, `picUrl`, `locUrl`, `cate`, `wxaccount`) 
VALUES ('表白|key_biaobai', '点击进入【表白墙】', '希望在这面墙上，能留下属于您的幸福。', 
'http://t2.qpic.cn/mblogpic/19f51391fba6a85e185c/460', '/mobile/love?ac=list&topicId=', 'menu', '');#表白
INSERT INTO `tb_article`(`keyword`, `title`, `desc`, `picUrl`, `locUrl`, `cate`, `wxaccount`) 
VALUES ('老乡|同乡|key_fellow', '点击开启【同城老乡会】', '同在异乡，亲如家人', 
'http://yy-pic.bj.bcebos.com/wxylx38248230942384092384.jpg', '/mobile/friend?ac=list', 'menu', '');#老乡
INSERT INTO `tb_article`(`keyword`, `title`, `desc`, `picUrl`, `locUrl`, `cate`, `wxaccount`) 
VALUES ('随手拍|key_wall', '点击进入【随手拍照片分享】', '欢迎随时分享各种照片，种类不限，恶搞、自拍、美景、生活。。。', 
'http://yy-pic.bj.bcebos.com/hsdzsxyssp934857439.jpg', '/mobile/vote?ac=listpic&topicId=', 'menu', '');#随手拍
INSERT INTO `tb_article`(`keyword`, `title`, `desc`, `picUrl`, `locUrl`, `cate`, `wxaccount`) 
VALUES ('外卖|订餐|key_food', '点击进入【外卖订餐】', '掌握在您手中的菜单', 
'http://yy-pic.bj.bcebos.com/5Rab74ceam.jpg', '/mobile/food?ac=getRess', 'menu', '');#订餐
INSERT INTO `tb_article`(`keyword`, `title`, `desc`, `picUrl`, `locUrl`, `cate`, `wxaccount`) 
VALUES ('四级|六级|key_cet', '英语四六级查询', '我们衷心希望您通过人生中的每一次考试', 
'http://yy-pic.bj.bcebos.com/SYvrbL8A9a.jpg', '/mobile/edu?ac=cet', 'menu', '');#四六级




