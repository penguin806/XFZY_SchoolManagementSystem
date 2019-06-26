-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1:3306
-- 生成日期： 2019-06-25 16:03:50
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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `realname`, `email`, `role`, `remarks`) VALUES
(1, 'lxf', '12345678', '李学锋', 'admin@xuefeng.space', 'admin', 'Admin Account'),
(2, '1000000', '123456', '李重文', 'a1@xuefeng.space', 'teacher', NULL),
(3, '201630185001', '123456', '伍芳兰', 'a2@xuefeng.space', 'student', NULL),
(4, '201630185002', '123456', '张敏', 'a3@xuefeng.space', 'student', NULL);

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
('test', '男', '43112610000000', '信工院', NULL, '桃子湖', '永州'),
('test2', '男', '43112610000000', '信工院', NULL, '桃子湖', '永州');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
