-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3307
-- Létrehozás ideje: 2026. Nov 09. 11:13
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `filmfroccs`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `achievementek`
--

CREATE TABLE `achievementek` (
  `id` int(11) NOT NULL,
  `nev` varchar(100) NOT NULL,
  `leiras` varchar(255) DEFAULT NULL,
  `ikon` varchar(50) DEFAULT 'fa-trophy'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `achievementek`
--

INSERT INTO `achievementek` (`id`, `nev`, `leiras`, `ikon`) VALUES
(1, 'Film Guru', 'Nézz meg több mint 100 filmet', 'fa-film'),
(2, 'Kritikus', 'Írj legalább 10 értékelést', 'fa-clapperboard'),
(3, 'Sztár', 'Értékelj egy filmet 10/10-re', 'fa-star');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `ertekelesek`
--

CREATE TABLE `ertekelesek` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `film_id` int(11) NOT NULL,
  `pontszam` tinyint(4) NOT NULL CHECK (`pontszam` between 1 and 10),
  `velemeny` text DEFAULT NULL,
  `ertekeles_datum` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `ertekelesek`
--

INSERT INTO `ertekelesek` (`id`, `user_id`, `film_id`, `pontszam`, `velemeny`, `ertekeles_datum`) VALUES
(1, 1, 1, 10, 'Fantasztikus film! A zene és a látvány páratlan.', '2026-11-09 11:12:12'),
(2, 2, 1, 9, 'Nagyon jó volt, sokadszorra is élvezhető.', '2026-11-09 11:12:12');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `user_id` int(11) NOT NULL,
  `felhasznalonev` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `jelszo` varchar(255) NOT NULL,
  `szint` int(11) DEFAULT 1,
  `regisztracio_datum` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`user_id`, `felhasznalonev`, `email`, `jelszo`, `szint`, `regisztracio_datum`) VALUES
(1, 'MintaFelhasznalo', 'minta@filmfroccs.hu', 'jelszo123', 14, '2026-11-09 11:12:12'),
(2, 'FilmKedvelo', 'kedvelo@filmfroccs.hu', 'jelszo123', 5, '2026-11-09 11:12:12');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalo_achievementek`
--

CREATE TABLE `felhasznalo_achievementek` (
  `user_id` int(11) NOT NULL,
  `achievement_id` int(11) NOT NULL,
  `megszerezve` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `felhasznalo_achievementek`
--

INSERT INTO `felhasznalo_achievementek` (`user_id`, `achievement_id`, `megszerezve`) VALUES
(1, 1, '2026-11-09 11:12:12'),
(1, 2, '2026-11-09 11:12:12'),
(1, 3, '2026-11-09 11:12:12');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalo_filmek`
--

CREATE TABLE `felhasznalo_filmek` (
  `user_id` int(11) NOT NULL,
  `film_id` int(11) NOT NULL,
  `statusz` enum('MEGNEZVE','TERVEZETT','FOLYAMATBAN') DEFAULT 'MEGNEZVE',
  `hozzaadva` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `felhasznalo_filmek`
--

INSERT INTO `felhasznalo_filmek` (`user_id`, `film_id`, `statusz`, `hozzaadva`) VALUES
(1, 1, 'MEGNEZVE', '2026-11-09 11:12:12'),
(1, 2, 'MEGNEZVE', '2026-11-09 11:12:12'),
(1, 6, 'TERVEZETT', '2026-11-09 11:12:12');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `filmek`
--

CREATE TABLE `filmek` (
  `id` int(11) NOT NULL,
  `cim` varchar(150) NOT NULL,
  `leiras` text DEFAULT NULL,
  `megjelenesi_ev` int(11) DEFAULT NULL,
  `hossz_perc` int(11) DEFAULT NULL,
  `korhatar` int(11) DEFAULT 0,
  `oszkardij` tinyint(1) DEFAULT 0,
  `tipus` enum('FILM','SOROZAT') DEFAULT 'FILM',
  `poszter_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `filmek`
--

INSERT INTO `filmek` (`id`, `cim`, `leiras`, `megjelenesi_ev`, `hossz_perc`, `korhatar`, `oszkardij`, `tipus`, `poszter_url`) VALUES
(1, 'Interstellar', 'Egy csapat felfedező egy féreglyukon keresztül utazik az űrben.', 2014, 169, 12, 1, 'FILM', NULL),
(2, 'The Dark Knight', 'Batman megküzd a Joker néven ismert bűnözővel.', 2008, 152, 16, 1, 'FILM', NULL),
(3, 'Inception', 'Egy tolvaj, aki álmokból lop titkokat, megkapja az utolsó feladatát.', 2010, 148, 16, 1, 'FILM', NULL),
(4, 'Fight Club', 'Egy álmatlanságban szenvedő irodai dolgozó és egy szappanmanufaktúrás harci klubot alapít.', 1999, 139, 18, 0, 'FILM', NULL),
(5, 'Pulp Fiction', 'Különböző bűnözők élete összefonódik Los Angelesben.', 1994, 154, 18, 1, 'FILM', NULL),
(6, 'Dune: Part Two', 'Paul Atreides egyesíti erejét Chani-val és a fremenekkel.', 2024, 166, 16, 0, 'FILM', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `film_mufaj`
--

CREATE TABLE `film_mufaj` (
  `film_id` int(11) NOT NULL,
  `mufaj_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `film_mufaj`
--

INSERT INTO `film_mufaj` (`film_id`, `mufaj_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2),
(2, 4),
(2, 5),
(3, 1),
(3, 4),
(4, 2),
(5, 2),
(5, 5),
(6, 1),
(6, 3);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `mufajok`
--

CREATE TABLE `mufajok` (
  `mufaj_id` int(11) NOT NULL,
  `nev` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `mufajok`
--

INSERT INTO `mufajok` (`mufaj_id`, `nev`) VALUES
(4, 'Akció'),
(2, 'Dráma'),
(3, 'Kaland'),
(5, 'Krimi'),
(1, 'Sci-Fi');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `achievementek`
--
ALTER TABLE `achievementek`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `ertekelesek`
--
ALTER TABLE `ertekelesek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `film_id` (`film_id`);

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `felhasznalonev` (`felhasznalonev`),
  ADD UNIQUE KEY `email` (`email`);

--
-- A tábla indexei `felhasznalo_achievementek`
--
ALTER TABLE `felhasznalo_achievementek`
  ADD PRIMARY KEY (`user_id`,`achievement_id`),
  ADD KEY `achievement_id` (`achievement_id`);

--
-- A tábla indexei `felhasznalo_filmek`
--
ALTER TABLE `felhasznalo_filmek`
  ADD PRIMARY KEY (`user_id`,`film_id`),
  ADD KEY `film_id` (`film_id`);

--
-- A tábla indexei `filmek`
--
ALTER TABLE `filmek`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `film_mufaj`
--
ALTER TABLE `film_mufaj`
  ADD PRIMARY KEY (`film_id`,`mufaj_id`),
  ADD KEY `mufaj_id` (`mufaj_id`);

--
-- A tábla indexei `mufajok`
--
ALTER TABLE `mufajok`
  ADD PRIMARY KEY (`mufaj_id`),
  ADD UNIQUE KEY `nev` (`nev`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `achievementek`
--
ALTER TABLE `achievementek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `ertekelesek`
--
ALTER TABLE `ertekelesek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `filmek`
--
ALTER TABLE `filmek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `mufajok`
--
ALTER TABLE `mufajok`
  MODIFY `mufaj_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `ertekelesek`
--
ALTER TABLE `ertekelesek`
  ADD CONSTRAINT `ertekelesek_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `felhasznalok` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ertekelesek_ibfk_2` FOREIGN KEY (`film_id`) REFERENCES `filmek` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `felhasznalo_achievementek`
--
ALTER TABLE `felhasznalo_achievementek`
  ADD CONSTRAINT `felhasznalo_achievementek_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `felhasznalok` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `felhasznalo_achievementek_ibfk_2` FOREIGN KEY (`achievement_id`) REFERENCES `achievementek` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `felhasznalo_filmek`
--
ALTER TABLE `felhasznalo_filmek`
  ADD CONSTRAINT `felhasznalo_filmek_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `felhasznalok` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `felhasznalo_filmek_ibfk_2` FOREIGN KEY (`film_id`) REFERENCES `filmek` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `film_mufaj`
--
ALTER TABLE `film_mufaj`
  ADD CONSTRAINT `film_mufaj_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `filmek` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `film_mufaj_ibfk_2` FOREIGN KEY (`mufaj_id`) REFERENCES `mufajok` (`mufaj_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
