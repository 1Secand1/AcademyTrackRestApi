-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 09, 2024 at 10:04 AM
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
-- Database: `academytrack`
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
(1, 'ИСП-216', '2021', '2025'),
(6, 'ИСП-215', '2022', '2024');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `user_id` int(225) NOT NULL,
  `name` varchar(225) NOT NULL,
  `surname` varchar(225) NOT NULL,
  `patronymic` varchar(225) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`user_id`, `name`, `surname`, `patronymic`, `group_id`) VALUES
(16, 'Дима', 'Иванов', 'Филинов', 1),
(19, 'Андрей ', 'Степанов ', 'Григорьевич', 6),
(20, 'Виолетта', 'Горшкова', 'Михайловна', 6),
(23, 'Даниил', 'Воронин', 'Тимофеевич', 1),
(24, 'Роман', 'Чекмарев', 'Александрович', 1);

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
(3, 14, 1, 1),
(4, 14, 2, 1),
(5, 14, 3, 1);

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
(14, '0315afe9fae85bea8f075c329e4f3957f19dc1e8c5aef4b17ac1c83e982c64b10e10f4f74eba27bd2691cf750378cb668cd45225f8bef4759530badc192ab7a813f46bbba8f4b1251d53836565a9457616a5114f2454f19da9060996c79d9ca5509bc253', '2024-04-06 12:03:05'),
(14, '1cc27aea58f8a35a500da0dcc56f0992a2ce6a74ebea8e1e5cc289d2fb701411475eebfaf61b35f3b042cd3cc60d8d6f903621f8d8e4f34b9464fe38936797ecf1fcf2581f132e443ed3768811a4d01c6014837dcd89e430b85f24bdfa148cf8190cb8bc', '2024-04-03 09:46:37'),
(14, '1ffc30b36d813f50d410ba3f24606828d3fa338a909556c37475a2ed2f115e7c440c18fcfe531097757a57b2cf9e685d593eac39fd0be45abe57ee35c2ad29cb456adec4c3aa9e6f7046321e3be612bc948032c069e48ff3ccd853b524f0085de33edf13', '2024-04-05 07:35:25'),
(14, '2d3d929d6474f611c3cb5492b7d01490f42cc5d4426d66fcd2b40f736eabadc35bfb14d455446a24465b314efed170545bfb821f12cc446dc65be9c87237671dca65bde949227bb004934ee2606be8fdf03848c9beb1865e10ba744ca904397da582fe34', '2024-04-09 09:54:48'),
(14, '37e8aaa2d0ea45b7dc2601d96611fbee3361c11833cdd25ec8423c44d13dac7aa54cdf4e34bebdfa9ea85b5b371c0ce8be4c2c34eeb4ff817f3c0ef417dfbb6cfdb15e16cc76324486ca66b798f36d04d942e8d932be53394187539a8f75d1929bdb6cd5', '2024-03-30 14:03:20'),
(14, '3f9afa9e862383cfd6df77c8e8be3412f2d4dd61caf6cacd6f3f0845c512d9de05785359862115fbc8ab0217c91e9159d8a12d18cc259f048600cd711fa9eb3fe6dccbce8ebb619e7924aba98e784ece531490a5cdcb4768921e4766c6c844f2fbabd44e', '2024-04-04 17:57:19'),
(14, '57716a63b180e168e057b7db3f435fe83e8c5a009a46a531ea8b8ef306ccc3888461dce8ee5c77399268facdb65c726d976a24f7db0b9c6a6af3f09be72f1b6e6c59826a98a9c5936c2c37ddb795d47f4bbd120d68dc2a9f16962d88f652d3847d8ebcf2', '2024-03-30 14:41:44'),
(14, '6821d58d419498de569b1ed2c7cde1d5a0d031f067e88afd97b23ca4d1c4564e291c244bdd25ab7f8e40eabaaf046d1229f7eae6a90f558d38c0fddb5bac98c34eca7975123f4949002045a591643d206275911ef66ba0b508d33e0bdee5547ffbc9e41f', '2024-04-04 15:20:04'),
(14, '76b3a8d9b4c6398d33e77c58390966b107b32b2af5f154916c9b7fd48cf033fdfafe008ff2638a0b72a6fb47c6e72b39e3271082ad0a5d9629c662664c154ef96b82ceb0781f1d65283111e81994a15e26b3c3b0b8d3851ec074b322e911671ffa0f71cd', '2024-04-05 08:49:29'),
(14, '78d50ee00a57f67d9dd58503f3ef7f2a9c4c1da0974455755491034947f191d247b0551885c9baa946c1c8e3923be68b4b9b905db693d03d559367e4bbcfbfacb5a3882e9c839baf551bf6a43c9a3c1e6f63f14879ae05c4876355932d4d33e161b4fd02', '2024-04-09 09:19:27'),
(14, '85b4c5f644778cc2eda1300ab051e9051c0394e6680083760fddb22b0a3ad4b1f54ed65c48cc3658e79a7fcd1cafbee3efcf38f527972a1539d2e09442f711cb36649c2dcdcaf065e3d6c4d64723f0344fb0a35b20ccd25049987642468f9c554855aa9e', '2024-04-05 07:29:34'),
(14, '876e603844927133fa726e7833bd1e974c3987cf58a3922a8f7e8de93665b8e39394504112d92657ee860cf3cfa525a97a01bce0156419c78ef3783f0bb3badd3a00e87566a8266b77f7f4bb54ccaeb3d124b90370dff98ad2d3b65775eb342f34c8407f', '2024-04-03 11:12:23'),
(14, '9733a08910e543c243cf8acd33d4e20b350d15bbb470ed32fb2bc16adee3ffeeb72ae719f1098c81bdf9916ea532ca949f2f60a0af59a55cd8209a6d60ec430f00181b36df645864e33ca934ccacf7e84b6bd2aa9efb6c25caece95f23fbedd531fb6427', '2024-04-03 11:12:18'),
(14, 'afdc1422fcf89709a7f142eb77058ea51353aec1292f6c99d0ab980c17a9bae8b4b8ad5e0259494a969647bb05cdeddeaaffbdb65c633dc347967288b1b6fa4b3b0a825dd22c187667baa026f2394f1d41c43ffa62dca00dd41b84715030bbe118c73507', '2024-03-30 13:44:19'),
(14, 'b295c3ad5f615d762f5555efaeb07ac601c83a39957061a6ab959880ed9364fef5485516af360f11cd8e475002a75f970867e5bfd6a20165802b74b547133da5672b57881c71c102df215dad0182e95ad900e88573abcbdc14d709a589c1d9b320fe4710', '2024-04-04 16:03:01'),
(14, 'b6710dd7998c4c8d32792d2e0f93d76770205cf10fd6aeaa21f7e14791d4529356c0f6df876b83e53ba1be24fd2b27d412c96cfea75ca7c6d72e39af941735ca07f2a405fc1a6ddb118c04682c6fd4720d10e73bf02320ce9a1bfd27a0a9001db1085f2a', '2024-03-30 13:20:03'),
(14, 'bdb77608aa9f4c407ed821644da3daa8a10e152adc815a5f7b194d13532a48777e2bdcc01d9cd7faa4ac5010f40a3fcd40ce420e4d7642f41465521c0b776bff5256a2086f085dfe52e9b68429670b868d7b6271e440a630dffd48fb69ef50c5f28c31d9', '2024-04-06 14:13:26'),
(14, 'c04727cce2a591e82610e568f7ea9d88334ee0d0657b4398a804dd3c7255c8312803ee806a75b3a561688cc3021b34b7be22f3b5697bdc4a7fa67f4ff370a6ddf1b937a112d0cc99eaa11e4a6bb42bb5f1c665803fc16d4bf7c14efd9280526853ac96d9', '2024-04-04 17:57:21'),
(14, 'c566fb52bcd6fa9899f073c20fa18b64f6114ccd59a4fd2b87b3476f7082c97440da239754bd09e9915f3110e4ef3d3bf7366373ef62ce1262c9f572212cbe0bfa5b6ce8abcfd35b33dd0ee8d5f3ede7546cbb07e0df45030776ad0d511adb029e4f135d', '2024-04-06 12:02:03'),
(14, 'c9802fcd9846dc738f38cdea61d7d3476334c48cbef15c3b5ec1a4d0fd8d646981b2e3a7febb7f98fb3a9f3475a7987c6e95fcb41a984f99f47d6469fa81f692cb83dcb52d3bacb7aab0002df66a625499961e1e3340cba55cd3868aa68b1e6a83608386', '2024-04-09 09:21:45'),
(14, 'd125b79b7498642ca713fc7ac0c75f803b5539c653003f29a17305237c8085b04878aa10fda1ac1ff9807ffbbdd01be25c75531dd8fb6ad6f2b90131508b5e9ac7683febc11635304f1c8e1b9848e97f68403934ac7cec7f25c293577e9675688f81343f', '2024-03-30 14:03:35'),
(14, 'd278b90138e4c911ebdcfeda53b8d250740b69adcf3cf5cf3bd8f707576fa16a3726fda753bd42ec285864b552ec4e7f35ef82fb8fde58e50b7ebfc68de7acd3991fd0fc499f6f2cfa319eadc3cb396c1f2b7b03644e10ad22ee7d4aa58a75868be3a53e', '2024-04-04 10:54:29'),
(14, 'd343b2509f17241700012a6131672b72041390a6089c193a4ecf03b5143ecc74354ea4252f0345e4105d87e6b2b933f4fc19f97eec75919144f45ebb59f260e554c476513bd09a06ee2b020dd3c6c71b1bec5a1671e39947844b84a0d744dfaa7d8aa464', '2024-04-05 07:23:18'),
(14, 'dbc356e96c2fd0f581a62d0d44b40cda6f3bfd96c0281ab8b6afe252d098cf7f8310ebe53ec444a07d8c860c9fde023a111c5e5437ad7269b1eb58263c18953440744662ec1e2d1ea483e0d2cb8be5c357e5f183a0a81609bebf91d3e4ee9a6652c27649', '2024-04-03 11:31:54'),
(14, 'e34aa0bf86d75acb31216c168d8fffee3c52293799a443e921bd9024ffedfe309cddb7a8b327406916ad6adef8530015b69c9b55f20c6023863819854aa5de30977f4702ba8527a110e742dac9754c08741c9c5683cab320e7f9a12ff1f447f2a64220e3', '2024-04-04 16:02:51'),
(14, 'e887c2d8b2a4dff774a1d0dd090daa91f13d4bc55351db3357047d987de611f8b3ab70d61f86e7bc3ab6804831353145658bde4c92eb6d1f5156dcd45a0ee18da5681418a4b2174774ae756f21c5e323f0e7b4c19c167d5c4d200cbd2c540a8e0840a0b9', '2024-04-05 08:41:06'),
(14, 'ebc042fb2046fc5e75258ab947368bb905d781dc58ddf07f96da1aa8a145d67e30af4516e0bcff070391e02637ecc16cf2812bd190a0813799985606e563497b69d271734e51dd0e8b92dfc0168fd9048c77dfcb0f6d14aa3df34a11882862bae21b0a68', '2024-04-04 17:57:28'),
(14, 'f6265ac420fd91b87a9473109b74f1a2d958bf31a4c002a1758acc37d6ff32bfa863fa6d1bd2e7d6e2e74373fd4fcbeac4039192c82e5e4969290550df511f0361da7b2bdd1b4386a316168adf7e192459d843bb913c9218044459a834b7bcc74e93c57f', '2024-04-05 07:20:38');

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
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `user_id` int(225) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `teacher_group_subject`
--
ALTER TABLE `teacher_group_subject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
