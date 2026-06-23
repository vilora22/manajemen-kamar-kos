-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 23, 2026 at 10:19 AM
-- Server version: 8.0.46
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kostku_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `id` int NOT NULL,
  `nomor_kamar` varchar(10) NOT NULL,
  `harga_sewa` decimal(10,2) NOT NULL,
  `fasilitas` text,
  `status` enum('tersedia','terisi','nonaktif') DEFAULT 'tersedia',
  `foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`id`, `nomor_kamar`, `harga_sewa`, `fasilitas`, `status`, `foto`) VALUES
(1, 'A01', 700000.00, 'LEMARI, KASUR', 'tersedia', 'kamar_1_1782130636.jpg'),
(2, 'A02', 700000.00, 'LEMARI, KASUR', 'terisi', NULL),
(3, 'B01', 900000.00, 'LEMARI, KASUR, KM DALAM', 'terisi', NULL),
(4, 'B02', 900000.00, 'LEMARI, KASUR, KM DALAM', 'terisi', NULL),
(5, 'C01', 1200000.00, 'LEMARI, KASUR, AC, KM DALAM', 'terisi', NULL),
(6, 'A03', 700000.00, 'LEMARI, KASUR', 'nonaktif', ''),
(7, 'B03', 900000.00, 'LEMARI, KASUR, KM DALAM', 'tersedia', NULL),
(8, 'C02', 1200000.00, 'LEMARI, KASUR, AC, KM DALAM', 'tersedia', ''),
(9, 'C03', 1200000.00, 'LEMARI, KASUR, AC, KM DALAM', 'terisi', NULL),
(10, 'D01', 500000.00, 'KASUR', 'tersedia', NULL),
(11, 'D02', 500000.00, 'KASUR', 'tersedia', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `pesan` text NOT NULL,
  `dibaca` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `notifikasi`
--

INSERT INTO `notifikasi` (`id`, `user_id`, `pesan`, `dibaca`, `created_at`) VALUES
(1, 1, 'Pengingat: Tagihan sewa kamar A01 periode Jul 2025 belum dibayar. Segera lakukan pembayaran.', 0, '2026-06-13 08:58:25'),
(2, 1, 'Pengingat: Tagihan sewa kamar A01 periode Jul 2025 belum dibayar. Segera lakukan pembayaran.', 0, '2026-06-16 02:53:47'),
(3, 8, 'Pengingat: Tagihan sewa kamar Menunggu Konfirmasi periode Jun 2026 belum dibayar. Segera lakukan pembayaran.', 0, '2026-06-18 00:15:01'),
(4, 1, 'Pengingat: Tagihan sewa kamar A01 periode Jul 2025 belum dibayar. Segera lakukan pembayaran.', 0, '2026-06-18 03:09:17'),
(5, 1, 'Pengingat: Tagihan sewa kamar A01 periode Jul 2025 belum dibayar. Segera lakukan pembayaran.', 0, '2026-06-18 03:18:37');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id` int NOT NULL,
  `tagihan_id` int NOT NULL,
  `metode` enum('transfer','cash') NOT NULL,
  `bukti_transfer` varchar(255) DEFAULT NULL,
  `tanggal_bayar` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id`, `tagihan_id`, `metode`, `bukti_transfer`, `tanggal_bayar`, `created_at`) VALUES
(1, 1, 'transfer', 'bukti_transfer_001.jpg', '2025-06-08', '2026-06-06 12:38:48'),
(2, 2, 'transfer', 'bukti_transfer_002.jpg', '2026-06-10', '2026-06-06 12:38:48'),
(3, 3, 'cash', NULL, '2025-07-09', '2026-06-06 12:38:48'),
(6, 2, 'cash', NULL, NULL, '2026-06-17 15:13:54'),
(12, 4, 'cash', NULL, '2026-06-22', '2026-06-18 00:26:05'),
(14, 4, 'cash', NULL, '2026-06-22', '2026-06-18 03:10:16'),
(16, 5, 'transfer', 'BUKTI_7_1781753432.jpg', '2026-06-18', '2026-06-18 03:30:32'),
(17, 4, 'transfer', 'BUKTI_8_1781754451.jpg', '2026-06-22', '2026-06-18 03:47:31'),
(18, 4, 'transfer', 'BUKTI_8_1781754638.jpg', '2026-06-22', '2026-06-18 03:50:39'),
(19, 4, 'cash', NULL, '2026-06-22', '2026-06-22 09:25:15');

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan`
--

CREATE TABLE `pemesanan` (
  `id` int NOT NULL,
  `kamar_id` int NOT NULL,
  `user_id` int NOT NULL,
  `tanggal_masuk_diinginkan` date NOT NULL,
  `metode` enum('transfer','cash') NOT NULL,
  `bukti_transfer` varchar(255) DEFAULT NULL,
  `nominal` decimal(12,2) NOT NULL,
  `status` enum('menunggu_verifikasi_transfer','menunggu_verifikasi_cash','diterima','ditolak','expired') NOT NULL,
  `batas_waktu_cash` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengaduan`
--

CREATE TABLE `pengaduan` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `isi_pengaduan` text NOT NULL,
  `tanggal_pengaduan` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pengaduan`
--

INSERT INTO `pengaduan` (`id`, `user_id`, `isi_pengaduan`, `tanggal_pengaduan`, `created_at`) VALUES
(1, 1, 'Lampu kamar mati dan perlu diganti.', '2025-06-05', '2026-06-06 12:38:48'),
(2, 2, 'Keran kamar mandi bocor.', '2025-06-07', '2026-06-06 12:38:48'),
(3, 1, 'Jaringan WiFi sering terputus.', '2025-06-12', '2026-06-06 12:38:48'),
(4, 5, '[ac rusak] anginnya tidak mau keluar', '2026-06-10', '2026-06-10 13:47:42'),
(5, 7, '[ada tikus] ada tikus di kamar mandi saya, saya takut', '2026-06-18', '2026-06-18 00:16:19'),
(6, 7, '[cihuyy] mana ada', '2026-06-18', '2026-06-18 03:33:54');

-- --------------------------------------------------------

--
-- Table structure for table `penghuni`
--

CREATE TABLE `penghuni` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `kamar_id` int NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `tanggal_keluar` date DEFAULT NULL,
  `status` enum('aktif','nonaktif') DEFAULT 'aktif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `penghuni`
--

INSERT INTO `penghuni` (`id`, `user_id`, `kamar_id`, `tanggal_masuk`, `tanggal_keluar`, `status`) VALUES
(1, 1, 1, '2025-01-10', '2026-06-13', 'nonaktif'),
(2, 2, 2, '2025-02-15', '2026-06-10', 'nonaktif'),
(3, 1, 3, '2024-01-01', '2024-12-31', 'nonaktif'),
(4, 5, 3, '2026-06-10', '2026-06-10', 'nonaktif'),
(5, 5, 3, '2026-06-10', '2026-06-13', 'nonaktif'),
(6, 2, 2, '2026-06-11', '2026-06-13', 'nonaktif'),
(7, 1, 1, '2026-06-13', '2026-06-17', 'nonaktif'),
(8, 5, 4, '2026-06-13', NULL, 'aktif'),
(9, 6, 5, '2026-06-13', NULL, 'aktif'),
(10, 3, 9, '2026-06-13', NULL, 'aktif'),
(11, 7, 7, '2026-06-17', '2026-06-17', 'nonaktif'),
(12, 2, 2, '2026-06-17', NULL, 'aktif'),
(13, 7, 7, '2026-06-18', '2026-06-18', 'nonaktif'),
(14, 8, 3, '2026-06-18', '2026-06-18', 'nonaktif'),
(15, 7, 7, '2026-06-18', '2026-06-18', 'nonaktif'),
(16, 8, 3, '2026-06-18', '2026-06-18', 'nonaktif'),
(17, 7, 7, '2026-06-18', '2026-06-22', 'nonaktif'),
(18, 8, 3, '2026-06-18', NULL, 'aktif');

-- --------------------------------------------------------

--
-- Table structure for table `tagihan`
--

CREATE TABLE `tagihan` (
  `id` int NOT NULL,
  `penghuni_id` int NOT NULL,
  `bulan` varchar(7) NOT NULL,
  `nominal` decimal(10,2) NOT NULL,
  `tanggal_jatuh_tempo` date NOT NULL,
  `status` enum('belum_dibayar','menunggu_verifikasi_transfer','menunggu_verifikasi_cash','lunas') DEFAULT 'belum_dibayar',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tagihan`
--

INSERT INTO `tagihan` (`id`, `penghuni_id`, `bulan`, `nominal`, `tanggal_jatuh_tempo`, `status`, `created_at`) VALUES
(1, 1, '2025-06', 500000.00, '2025-06-10', 'lunas', '2026-06-06 12:38:48'),
(2, 2, '2025-06', 600000.00, '2025-06-10', 'belum_dibayar', '2026-06-06 12:38:48'),
(3, 1, '2025-07', 500000.00, '2025-07-10', 'belum_dibayar', '2026-06-06 12:38:48'),
(4, 8, '2026-06', 900000.00, '2026-06-20', 'lunas', '2026-06-17 23:34:06'),
(5, 7, '2026-06', 900000.00, '2026-06-20', 'lunas', '2026-06-17 23:46:14');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nama` varchar(100) NOT NULL,
  `no_telepon` varchar(20) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('pemilik','penyewa') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama`, `no_telepon`, `username`, `password`, `role`, `created_at`) VALUES
(1, 'La Ode Muhamad Indra Rukmana', '081234567890', 'indra', '$2y$10$TKh8H1.PfYi1I0BmS.Ork.S5ZkfQbS7YMQnX6Gg5bLNzKCQMH.2S', 'penyewa', '2026-06-06 12:38:48'),
(2, 'Muhammad Rizky', '082345678901', 'rizky', '$2y$10$vI2bExA7gLQHFGIZ5ZQYY.pYxDQHWq8BIHZB3jBGJ1qsHFk3KIHW', 'penyewa', '2026-06-06 12:38:48'),
(3, 'Andi Saputra', '083456789012', 'andi', '$2y$10$89vM3l2p2zQ3yvG6zK3eO.uR2mB1vK8wG8zK3eO.uR2mB1vK8wG8z', 'penyewa', '2026-06-06 12:38:48'),
(4, 'Budi Siregar', '082396533851', 'budi', '$2y$10$H/ysEU4SD2PakjVJ/yQpY.OdW/LhRG.DxTZDD489tS9ZaPoAd8KmC', 'pemilik', '2026-06-10 12:47:48'),
(5, 'Rain Skill', '082227246611', 'rain', '$2y$10$l9uQrXVAZvHnkm9mebnj.ufxKZ6Oy2iOHIILSFPFspiR/ZbcgKGj.', 'penyewa', '2026-06-10 13:10:14'),
(6, 'Supri', '081341804303', 'supri', '$2y$10$3y10BesIMWKYb.tV.wCJgeIXOPWXoAXpHGt.EcDdK.KTFiAvHBFPa', 'penyewa', '2026-06-13 09:13:00'),
(7, 'Abdul Kliat', '081134768970', 'abdul', '$2y$10$5n.RK3BPizDhe.B3iLxo1uTRKtNsl/hkWTzihq7lJMGbAvdFVJSRm', 'penyewa', '2026-06-13 09:14:36'),
(8, 'Arya Bot', '082227246612', 'arya', '$2y$10$lJsc.X8GAIFjPXsUog3m.OOT56TDxLWhuggWRinjAkRcw2CLP..nC', 'penyewa', '2026-06-17 14:42:13'),
(9, 'Rahim Sengkuni', '082227246613', 'rahim', '$2y$10$yknlRAFKME806jyHoEAPaO/ze9JrcGFwyBsFdnOHeISd5FC83r6Ra', 'penyewa', '2026-06-22 09:39:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nomor_kamar` (`nomor_kamar`);

--
-- Indexes for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pembayaran_tagihan` (`tagihan_id`);

--
-- Indexes for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kamar_id` (`kamar_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `pengaduan`
--
ALTER TABLE `pengaduan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pengaduan_user` (`user_id`);

--
-- Indexes for table `penghuni`
--
ALTER TABLE `penghuni`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_penghuni_user` (`user_id`),
  ADD KEY `fk_penghuni_kamar` (`kamar_id`);

--
-- Indexes for table `tagihan`
--
ALTER TABLE `tagihan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tagihan_penghuni` (`penghuni_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `pemesanan`
--
ALTER TABLE `pemesanan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pengaduan`
--
ALTER TABLE `pengaduan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `penghuni`
--
ALTER TABLE `penghuni`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `tagihan`
--
ALTER TABLE `tagihan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD CONSTRAINT `notifikasi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `fk_pembayaran_tagihan` FOREIGN KEY (`tagihan_id`) REFERENCES `tagihan` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD CONSTRAINT `pemesanan_ibfk_1` FOREIGN KEY (`kamar_id`) REFERENCES `kamar` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `pemesanan_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `pengaduan`
--
ALTER TABLE `pengaduan`
  ADD CONSTRAINT `fk_pengaduan_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `penghuni`
--
ALTER TABLE `penghuni`
  ADD CONSTRAINT `fk_penghuni_kamar` FOREIGN KEY (`kamar_id`) REFERENCES `kamar` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_penghuni_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `tagihan`
--
ALTER TABLE `tagihan`
  ADD CONSTRAINT `fk_tagihan_penghuni` FOREIGN KEY (`penghuni_id`) REFERENCES `penghuni` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
