-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1:3306
-- 生成日期： 2019-06-28 16:34:03
-- 服务器版本： 5.7.26
-- PHP 版本： 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `xfzy_school_mng_sys`
--

-- --------------------------------------------------------

--
-- 表的结构 `class`
--

DROP TABLE IF EXISTS `class`;
CREATE TABLE IF NOT EXISTS `class` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(20) DEFAULT NULL,
  `class_teacher_username` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `course`
--

DROP TABLE IF EXISTS `course`;
CREATE TABLE IF NOT EXISTS `course` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(30) DEFAULT NULL,
  `course_teacher_username` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `course_name` (`course_name`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `course`
--

INSERT INTO `course` (`course_id`, `course_name`, `course_teacher_username`) VALUES
(1, 'Web应用系统设计', '李重文'),
(2, 'JAVA程序开发', '钟坚成'),
(6, '计算机专业英语', '付玉');

-- --------------------------------------------------------

--
-- 表的结构 `course_selection`
--

DROP TABLE IF EXISTS `course_selection`;
CREATE TABLE IF NOT EXISTS `course_selection` (
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  UNIQUE KEY `student_id` (`student_id`,`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `course_selection`
--

INSERT INTO `course_selection` (`student_id`, `course_id`) VALUES
(1, 1),
(1, 2),
(18, 1),
(18, 2);

-- --------------------------------------------------------

--
-- 表的结构 `score`
--

DROP TABLE IF EXISTS `score`;
CREATE TABLE IF NOT EXISTS `score` (
  `student_id` int(11) NOT NULL,
  `student_course_id` varchar(5) NOT NULL,
  `score` varchar(5) DEFAULT NULL,
  UNIQUE KEY `student_id` (`student_id`,`student_course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `score`
--

INSERT INTO `score` (`student_id`, `student_course_id`, `score`) VALUES
(18, '1', '95'),
(18, '2', '90'),
(1, '1', '85');

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `realname` varchar(10) DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  `role` varchar(10) NOT NULL,
  `remarks` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `realname`, `email`, `role`, `remarks`) VALUES
(1, 'lxf', '12345678', '李学锋', 'admin@xuefeng.space', 'admin', 'Admin Account'),
(18, '201630185001', '123456', '伍芳兰', 'a1@xuefeng.space', 'student', 'NULL'),
(19, '201630185002', '123456', '张敏', 'a2@xuefeng.space', 'student', 'NULL'),
(20, '1000000', '123456', '李重文', 'a3@xuefeng.space', 'teacher', '《Web应用系统设计》指导老师');

-- --------------------------------------------------------

--
-- 表的结构 `user_info`
--

DROP TABLE IF EXISTS `user_info`;
CREATE TABLE IF NOT EXISTS `user_info` (
  `username` varchar(20) NOT NULL,
  `sex` char(2) DEFAULT NULL,
  `idcard_number` varchar(18) DEFAULT NULL,
  `department` varchar(20) DEFAULT NULL,
  `class` varchar(20) DEFAULT NULL,
  `home_address` varchar(40) DEFAULT NULL,
  `train_station` varchar(10) DEFAULT NULL,
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user_info`
--

INSERT INTO `user_info` (`username`, `sex`, `idcard_number`, `department`, `class`, `home_address`, `train_station`) VALUES
('lxf', '男', '43112610000000', '信息科学与工程学院', '16计科', '桃子湖', ''),
('201630185002', '女', '123456789', '信息科学与工程学院', '16计科', '桃子湖', '永州'),
('201630185001', '女', '123456789', '信息科学与工程学院', '16计科', '桃子湖', '常德'),
('1000000', '男', '123456789', '信息科学与工程学院', '', '桃子湖', '长沙');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
