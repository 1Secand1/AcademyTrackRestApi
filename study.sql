-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 03, 2024 at 08:32 AM
-- Server version: 5.7.24
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `study`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(255) NOT NULL,
  `teacher` varchar(55) NOT NULL,
  `date` date NOT NULL,
  `subjects_id` json NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `group_code` varchar(15) NOT NULL,
  `year_of_entry` varchar(4) NOT NULL,
  `year_of_issue` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `group_code`, `year_of_entry`, `year_of_issue`) VALUES
(1, 'исп-216', '2021', '2025'),
(6, 'Исп-21', '2022', '2024');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`user_id`, `group_id`) VALUES
(15, 1),
(14, 6);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `name`) VALUES
(1, 'Математика'),
(2, 'Физика'),
(3, 'Литература');

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`user_id`) VALUES
(14);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_group_subject`
--

CREATE TABLE `teacher_group_subject` (
  `id` int(11) NOT NULL,
  `teacher_id` int(225) NOT NULL,
  `subjects_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `teacher_group_subject`
--

INSERT INTO `teacher_group_subject` (`id`, `teacher_id`, `subjects_id`, `group_id`) VALUES
(3, 14, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `user_id` int(225) NOT NULL,
  `value` varchar(255) NOT NULL,
  `valid_until` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`user_id`, `value`, `valid_until`) VALUES
(14, '37e8aaa2d0ea45b7dc2601d96611fbee3361c11833cdd25ec8423c44d13dac7aa54cdf4e34bebdfa9ea85b5b371c0ce8be4c2c34eeb4ff817f3c0ef417dfbb6cfdb15e16cc76324486ca66b798f36d04d942e8d932be53394187539a8f75d1929bdb6cd5', '2024-03-30 14:03:20'),
(14, '57716a63b180e168e057b7db3f435fe83e8c5a009a46a531ea8b8ef306ccc3888461dce8ee5c77399268facdb65c726d976a24f7db0b9c6a6af3f09be72f1b6e6c59826a98a9c5936c2c37ddb795d47f4bbd120d68dc2a9f16962d88f652d3847d8ebcf2', '2024-03-30 14:41:44'),
(14, 'afdc1422fcf89709a7f142eb77058ea51353aec1292f6c99d0ab980c17a9bae8b4b8ad5e0259494a969647bb05cdeddeaaffbdb65c633dc347967288b1b6fa4b3b0a825dd22c187667baa026f2394f1d41c43ffa62dca00dd41b84715030bbe118c73507', '2024-03-30 13:44:19'),
(14, 'b6710dd7998c4c8d32792d2e0f93d76770205cf10fd6aeaa21f7e14791d4529356c0f6df876b83e53ba1be24fd2b27d412c96cfea75ca7c6d72e39af941735ca07f2a405fc1a6ddb118c04682c6fd4720d10e73bf02320ce9a1bfd27a0a9001db1085f2a', '2024-03-30 13:20:03'),
(14, 'd125b79b7498642ca713fc7ac0c75f803b5539c653003f29a17305237c8085b04878aa10fda1ac1ff9807ffbbdd01be25c75531dd8fb6ad6f2b90131508b5e9ac7683febc11635304f1c8e1b9848e97f68403934ac7cec7f25c293577e9675688f81343f', '2024-03-30 14:03:35');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `surname` varchar(225) DEFAULT NULL,
  `name` varchar(225) DEFAULT NULL,
  `patronymic` varchar(225) DEFAULT NULL,
  `login` varchar(55) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `surname`, `name`, `patronymic`, `login`, `password`, `role`) VALUES
(14, 'Боев', 'Владислав', 'Владимировичь', 'admin', '$2y$10$UtZz3k2e7vBSbfkeBgo0GuidR1ZKrQtWGCQkWZ2TijR65wl6eZp6.', 'admin'),
(15, 'ivanov', 'ivan', 'ivani', '', '$2y$10$t3t2CCU5VW7G7ug2ZHsgp.4XQygS980.Pl5nRfiflGcVkMawofHDq', 'student');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD KEY `lesson_name` (`teacher`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_name` (`group_code`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `teacher_group_subject`
--
ALTER TABLE `teacher_group_subject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`teacher_id`,`subjects_id`,`group_id`),
  ADD KEY `teacher_group_subject_ibfk_1` (`group_id`),
  ADD KEY `teacher_group_subject_ibfk_2` (`subjects_id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`value`),
  ADD KEY `user__id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`login`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `teacher_group_subject`
--
ALTER TABLE `teacher_group_subject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacher`
--
ALTER TABLE `teacher`
  ADD CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacher_group_subject`
--
ALTER TABLE `teacher_group_subject`
  ADD CONSTRAINT `teacher_group_subject_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_group_subject_ibfk_2` FOREIGN KEY (`subjects_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_group_subject_ibfk_3` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
