-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 22, 2025 at 02:36 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `moneysave`
--

-- --------------------------------------------------------

--
-- Table structure for table `daftar`
--

CREATE TABLE `daftar` (
  `id` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `agama` varchar(20) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `tujuan` varchar(255) DEFAULT NULL,
  `jenis_kelamin` enum('Laki-Laki','Perempuan') DEFAULT NULL,
  `no_rekening` varchar(20) DEFAULT NULL,
  `setoran` decimal(15,2) DEFAULT NULL,
  `tgl_daftar` datetime NOT NULL DEFAULT current_timestamp(),
  `status_konfirmasi` enum('pending','approved','rejected') DEFAULT 'pending',
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `no_hp` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daftar`
--

INSERT INTO `daftar` (`id`, `nik`, `nama`, `tgl_lahir`, `agama`, `alamat`, `tujuan`, `jenis_kelamin`, `no_rekening`, `setoran`, `tgl_daftar`, `status_konfirmasi`, `email`, `password`, `no_hp`) VALUES
(5, '1234567890', 'Aji Sayfullah', '2025-06-19', 'islam', 'Jln.Mati', NULL, 'Laki-Laki', '073704511', NULL, '2025-06-19 07:06:47', 'approved', NULL, '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `foto`
--

CREATE TABLE `foto` (
  `id` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `kartu` varchar(255) DEFAULT NULL,
  `wajah` varchar(255) DEFAULT NULL,
  `tanggal_upload` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','verified','rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `foto`
--

INSERT INTO `foto` (`id`, `nik`, `kartu`, `wajah`, `tanggal_upload`, `status`) VALUES
(4, '1234567890', 'uploads/ktp/ktp_1234567890_1750291887.png', 'uploads/wajah/wajah_1234567890_1750291895.png', '2025-06-19 07:11:27', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `tanggal_notifikasi` datetime NOT NULL,
  `status_baca` enum('belum_dibaca','dibaca') DEFAULT 'belum_dibaca',
  `is_deleted` tinyint(1) DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rekening_tabungan`
--

CREATE TABLE `rekening_tabungan` (
  `id` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `no_rekening` varchar(16) NOT NULL,
  `nama_pemilik` varchar(100) NOT NULL,
  `cabang` varchar(50) DEFAULT NULL,
  `tgl_pembuatan` date DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rincian_pengeluaran`
--

CREATE TABLE `rincian_pengeluaran` (
  `id` int(11) NOT NULL,
  `target_id` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `amount` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `target`
--

CREATE TABLE `target` (
  `id` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `tujuan` varchar(225) NOT NULL,
  `deadline` date DEFAULT NULL,
  `jumlah_target` int(20) DEFAULT NULL,
  `nominal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_riwayat`
--

CREATE TABLE `transaksi_riwayat` (
  `id` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `tipe_transaksi` enum('masuk','keluar') NOT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `jumlah` decimal(15,2) NOT NULL,
  `tanggal_waktu_transaksi` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `waktu`
--

CREATE TABLE `waktu` (
  `id` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `timer_end` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','completed','rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `waktu`
--

INSERT INTO `waktu` (`id`, `nik`, `timer_end`, `created_at`, `status`) VALUES
(5, '1234567890', '2025-06-20 07:06:47', '2025-06-19 00:06:47', 'completed');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `daftar`
--
ALTER TABLE `daftar`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nik` (`nik`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_daftar_nik` (`nik`);

--
-- Indexes for table `foto`
--
ALTER TABLE `foto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nik` (`nik`);

--
-- Indexes for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nik` (`nik`);

--
-- Indexes for table `rekening_tabungan`
--
ALTER TABLE `rekening_tabungan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `no_rekening` (`no_rekening`),
  ADD KEY `nik` (`nik`);

--
-- Indexes for table `rincian_pengeluaran`
--
ALTER TABLE `rincian_pengeluaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `target_id` (`target_id`),
  ADD KEY `nik` (`nik`);

--
-- Indexes for table `target`
--
ALTER TABLE `target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nik` (`nik`);

--
-- Indexes for table `transaksi_riwayat`
--
ALTER TABLE `transaksi_riwayat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nik` (`nik`);

--
-- Indexes for table `waktu`
--
ALTER TABLE `waktu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nik` (`nik`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `daftar`
--
ALTER TABLE `daftar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `foto`
--
ALTER TABLE `foto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rekening_tabungan`
--
ALTER TABLE `rekening_tabungan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rincian_pengeluaran`
--
ALTER TABLE `rincian_pengeluaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `target`
--
ALTER TABLE `target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transaksi_riwayat`
--
ALTER TABLE `transaksi_riwayat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `waktu`
--
ALTER TABLE `waktu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `foto`
--
ALTER TABLE `foto`
  ADD CONSTRAINT `foto_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `daftar` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD CONSTRAINT `notifikasi_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `daftar` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rekening_tabungan`
--
ALTER TABLE `rekening_tabungan`
  ADD CONSTRAINT `rekening_tabungan_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `daftar` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rincian_pengeluaran`
--
ALTER TABLE `rincian_pengeluaran`
  ADD CONSTRAINT `rincian_pengeluaran_ibfk_1` FOREIGN KEY (`target_id`) REFERENCES `target` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rincian_pengeluaran_ibfk_2` FOREIGN KEY (`nik`) REFERENCES `daftar` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `target`
--
ALTER TABLE `target`
  ADD CONSTRAINT `target_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `daftar` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaksi_riwayat`
--
ALTER TABLE `transaksi_riwayat`
  ADD CONSTRAINT `transaksi_riwayat_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `daftar` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `waktu`
--
ALTER TABLE `waktu`
  ADD CONSTRAINT `waktu_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `daftar` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
