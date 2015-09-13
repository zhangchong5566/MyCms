CREATE DATABASE  IF NOT EXISTS `shishuocms` ;
USE `shishuocms`;

CREATE TABLE `admin` (
  `adminId` BIGINT(10) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `name` VARCHAR(50) DEFAULT NULL COMMENT '管理员名称',
  `password` VARCHAR(32) DEFAULT NULL COMMENT '密码 MD5加密',
  `createTime` DATETIME DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`adminId`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员';

CREATE TABLE `admin_folder` (
  `adminId` BIGINT(20) DEFAULT NULL,
  `folderId` BIGINT(20) DEFAULT NULL,
  `createTime` DATETIME DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

CREATE TABLE `article` (
  `articleId` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `folderId` BIGINT(20) DEFAULT NULL,
  `path` VARCHAR(200) DEFAULT NULL,
  `adminId` BIGINT(20) DEFAULT '0' COMMENT '管理员ID',
  `picture` VARCHAR(60) DEFAULT NULL,
  `title` VARCHAR(200) DEFAULT '' COMMENT '文件名称',
  `summary` VARCHAR(2000) DEFAULT NULL,
  `content` MEDIUMTEXT COMMENT '文件内容',
  `viewCount` INT(11) DEFAULT '0' COMMENT '浏览数',
  `commentCount` INT(11) DEFAULT '0' COMMENT '评论数',
  `status` VARCHAR(20) DEFAULT 'init' COMMENT '状态：0 隐藏 1 显示',
  `check` ENUM('yes','no','init') DEFAULT NULL,
  `createTime` DATETIME DEFAULT NULL COMMENT '创建时间',
  `updateTime` DATETIME DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`articleId`),
  KEY `idx_folder` USING BTREE (`status`) 
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='文件';

CREATE TABLE `comment` (
  `commentId` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `userId` BIGINT(20) DEFAULT NULL COMMENT '用户ID',
  `fatherId` BIGINT(20) DEFAULT NULL COMMENT '父评论ID',
  `kindId` BIGINT(20) DEFAULT NULL,
  `kind` VARCHAR(45) DEFAULT NULL COMMENT '文件ID',
  `name` VARCHAR(45) DEFAULT NULL COMMENT '评论者',
  `email` VARCHAR(45) DEFAULT NULL COMMENT '评论者邮件地址',
  `url` VARCHAR(200) DEFAULT NULL COMMENT '评论者网址',
  `phone` BIGINT(20) DEFAULT NULL,
  `content` TEXT COMMENT '内容',
  `ip` VARCHAR(45) DEFAULT NULL COMMENT 'Ip',
  `status` VARCHAR(20) DEFAULT NULL COMMENT '状态',
  `createTime` DATETIME DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`commentId`),
  KEY `idx_status` USING BTREE (`status`) 
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='评论';

CREATE TABLE `config` (
  `key` VARCHAR(45) NOT NULL COMMENT 'Key',
  `value` VARCHAR(45) DEFAULT NULL COMMENT '值',
  `description` TEXT COMMENT '描述',
  `createTime` DATETIME DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`key`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='网站配置';

CREATE TABLE `folder` (
  `folderId` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '目录ID',
  `fatherId` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '父亲Id，用于构建目录树',
  `ename` VARCHAR(45) NOT NULL COMMENT '英文名',
  `name` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '中文名',
  `path` VARCHAR(200) NOT NULL DEFAULT '' COMMENT '路径',
  `content` TEXT,
  `level` TINYINT(4) DEFAULT '1' COMMENT '层级',
  `sort` TINYINT(4) DEFAULT '0' COMMENT '排序',
  `width` INT(11) DEFAULT '0',
  `height` INT(11) DEFAULT '0',
  `count` INT(11) DEFAULT '0' COMMENT '文件数',
  `status` VARCHAR(20) DEFAULT 'hidden' COMMENT '状态：0 隐藏 1 现实',
  `check` ENUM('yes','no') DEFAULT 'no',
  `createTime` DATETIME DEFAULT NULL COMMENT '创建时间',
  `updateTime` DATETIME DEFAULT NULL,
  PRIMARY KEY (`folderId`),
  UNIQUE KEY `idx_ename` USING BTREE (`ename`) ,
  KEY `idx_status` USING BTREE (`fatherId`,`status`) 
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='目录';

CREATE TABLE `guestbook` (
  `guestbookId` BIGINT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) DEFAULT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `website` VARCHAR(100) DEFAULT NULL,
  `title` VARCHAR(200) DEFAULT NULL,
  `content` VARCHAR(2000) DEFAULT NULL,
  `reply` VARCHAR(2000) DEFAULT NULL,
  `status` ENUM('display','hidden','init') DEFAULT NULL,
  `createTime` DATETIME DEFAULT NULL,
  `replyTime` DATETIME DEFAULT NULL,
  PRIMARY KEY (`guestbookId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

CREATE TABLE `headline` (
  `headlineId` BIGINT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) DEFAULT NULL,
  `picture` VARCHAR(100) DEFAULT NULL,
  `url` VARCHAR(100) DEFAULT NULL,
  `sort` TINYINT(4) DEFAULT NULL,
  `createTime` DATETIME DEFAULT NULL,
  PRIMARY KEY (`headlineId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

CREATE TABLE `media` (
  `mediaId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `kindId` BIGINT(20) DEFAULT '0',
  `name` VARCHAR(200) DEFAULT NULL,
  `path` VARCHAR(200) DEFAULT NULL,
  `size` INT(11) DEFAULT NULL,
  `type` VARCHAR(45) DEFAULT NULL,
  `kind` VARCHAR(20) DEFAULT NULL,
  `createTime` DATETIME DEFAULT NULL,
  PRIMARY KEY (`mediaId`),
  KEY `idx_kind` USING BTREE (`kind`,`kindId`)
) ENGINE=INNODB DEFAULT CHARSET=ucs2 ROW_FORMAT=COMPACT;

CREATE TABLE `user` (
  `userId` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `openId` BIGINT(20) DEFAULT NULL COMMENT '公共用户ID，只有是师说，QQ，微博等其它网站登录时才有。',
  `type` VARCHAR(20) DEFAULT NULL COMMENT '帐号类型：0 本站 1 师说 2 QQ 3 微博',
  `name` VARCHAR(45) DEFAULT NULL COMMENT '用户名',
  `createTime` DATETIME DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`userId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户';


INSERT INTO `admin` VALUES (1,'shishuocms','6158f875bf826e15923779855b6eef2e','2012-08-08 00:00:00');

INSERT INTO `config` VALUES ('shishuo_headline_image_height','420','首页头图的高（px）','2012-08-08 00:00:00');
INSERT INTO `config` VALUES ('shishuo_headline_image_width','858','首页头图的宽（px）','2012-08-08 00:00:00');
INSERT INTO `config` VALUES ('shishuo_seo_headline','师说CMS是用Java开发的内容管理系统','网站口号','2012-08-08 00:00:00');
INSERT INTO `config` VALUES ('shishuo_seo_title','师说CMS','网站名称','2012-08-08 00:00:00');
INSERT INTO `config` VALUES ('shishuo_static','false','是否启用全站静态化','2012-08-08 00:00:00');
INSERT INTO `config` VALUES ('shishuo_template','blog','模板','2012-08-08 00:00:00');

INSERT INTO `admin_folder` VALUES (1,1,'2014-10-29 20:48:42');
INSERT INTO `admin_folder` VALUES (1,3,'2014-10-29 20:48:43');
INSERT INTO `admin_folder` VALUES (1,4,'2014-10-29 20:48:44');
INSERT INTO `admin_folder` VALUES (1,5,'2014-10-29 20:48:45');
INSERT INTO `admin_folder` VALUES (1,2,'2014-10-29 20:48:46');

INSERT INTO `article` VALUES (1,1,'1',1,'','Hello World','Hello World!!','<p>Hello World!!</p><div id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\"></div>',0,0,'display','yes','2014-10-29 00:00:00','2014-10-29 20:49:54');

INSERT INTO `folder` VALUES (1,0,'blog','博客','1','',1,1,0,0,0,'display','no','2014-10-29 18:37:39',NULL);
INSERT INTO `folder` VALUES (2,0,'about','关于博主','2','<p>朕就是这样一汉子。<br/></p><div id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\"></div>',1,1,0,0,0,'display','no','2014-10-29 18:38:02',NULL);
INSERT INTO `folder` VALUES (3,1,'life','生活','1#3','',2,1,0,0,0,'display','no','2014-10-29 20:16:53',NULL);
INSERT INTO `folder` VALUES (4,1,'work','工作','1#4','',2,1,0,0,0,'display','no','2014-10-29 20:17:06',NULL);
INSERT INTO `folder` VALUES (5,1,'travel','旅游','1#5','',2,1,0,0,0,'display','no','2014-10-29 20:17:39',NULL);