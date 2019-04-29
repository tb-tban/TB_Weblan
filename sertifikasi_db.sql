/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 10.1.35-MariaDB : Database - sertifikasi_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sertifikasi_db` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `sertifikasi_db`;

/*Table structure for table `tb_jadwaltes` */

DROP TABLE IF EXISTS `tb_jadwaltes`;

CREATE TABLE `tb_jadwaltes` (
  `id_jadwal` int(11) NOT NULL AUTO_INCREMENT,
  `tgl_tes` date NOT NULL,
  `id_lokasi` int(10) NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL,
  `kuota` int(11) NOT NULL,
  `status` enum('Open','Close') DEFAULT NULL,
  PRIMARY KEY (`id_jadwal`),
  KEY `id_lokasi` (`id_lokasi`),
  CONSTRAINT `tb_jadwaltes_ibfk_1` FOREIGN KEY (`id_lokasi`) REFERENCES `tb_lokasites` (`id_lokasi`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `tb_jadwaltes` */

insert  into `tb_jadwaltes`(`id_jadwal`,`tgl_tes`,`id_lokasi`,`jam_mulai`,`jam_selesai`,`kuota`,`status`) values 
(1,'2019-01-10',1,'10:00:00','11:30:00',18,'Open'),
(2,'2019-01-15',1,'12:00:00','13:30:00',18,'Open'),
(3,'2019-01-30',1,'12:00:00','13:30:00',30,'Open'),
(4,'2019-01-30',1,'15:00:00','16:00:00',25,'Open'),
(5,'2019-01-31',1,'08:00:00','09:00:00',24,'Open');

/*Table structure for table `tb_keterangan` */

DROP TABLE IF EXISTS `tb_keterangan`;

CREATE TABLE `tb_keterangan` (
  `kodeKet` varchar(11) NOT NULL,
  `detailKet` varchar(200) NOT NULL,
  PRIMARY KEY (`kodeKet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tb_keterangan` */

insert  into `tb_keterangan`(`kodeKet`,`detailKet`) values 
('ket1','BARU MENGIKUTI TES UNTUK PERTAMA KALI'),
('ket2','MENGULANG'),
('ket3','MASA BERLAKU SERTIFIKAT HABIS');

/*Table structure for table `tb_lokasites` */

DROP TABLE IF EXISTS `tb_lokasites`;

CREATE TABLE `tb_lokasites` (
  `id_lokasi` int(10) NOT NULL AUTO_INCREMENT,
  `namaLokasi` varchar(70) NOT NULL,
  PRIMARY KEY (`id_lokasi`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `tb_lokasites` */

insert  into `tb_lokasites`(`id_lokasi`,`namaLokasi`) values 
(1,'Labkom 1&2');

/*Table structure for table `tb_nopeserta` */

DROP TABLE IF EXISTS `tb_nopeserta`;

CREATE TABLE `tb_nopeserta` (
  `id_peserta` varchar(100) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_jadwal` int(11) NOT NULL,
  `noPeserta` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_peserta` (`id_peserta`),
  KEY `id_jadwal` (`id_jadwal`),
  CONSTRAINT `tb_nopeserta_ibfk_1` FOREIGN KEY (`id_peserta`) REFERENCES `tb_pendaftar` (`id_peserta`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_nopeserta_ibfk_2` FOREIGN KEY (`id_jadwal`) REFERENCES `tb_jadwaltes` (`id_jadwal`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

/*Data for the table `tb_nopeserta` */

insert  into `tb_nopeserta`(`id_peserta`,`id`,`id_jadwal`,`noPeserta`) values 
('1611016310007_1',29,1,001),
('1611016310007_2',32,2,001),
('1611016310008_2',33,2,002),
('1611016310009_2',34,2,003);

/*Table structure for table `tb_pendaftar` */

DROP TABLE IF EXISTS `tb_pendaftar`;

CREATE TABLE `tb_pendaftar` (
  `nim` varchar(13) NOT NULL,
  `id_peserta` varchar(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `kontak` varchar(20) NOT NULL,
  `waktuDaftar` datetime NOT NULL,
  `kodeKet` varchar(11) NOT NULL,
  `kodeProdi` varchar(10) NOT NULL,
  `id_jadwal` int(11) DEFAULT NULL,
  `status_peserta` enum('Disetujui','Ditolak','Belum Ditanggapi') DEFAULT NULL,
  PRIMARY KEY (`id_peserta`),
  KEY `kodeProdi` (`kodeProdi`),
  KEY `id_jadwal` (`id_jadwal`),
  KEY `kodeKet` (`kodeKet`),
  CONSTRAINT `tb_pendaftar_ibfk_1` FOREIGN KEY (`kodeProdi`) REFERENCES `tb_prodi` (`kodeProdi`) ON UPDATE CASCADE,
  CONSTRAINT `tb_pendaftar_ibfk_2` FOREIGN KEY (`id_jadwal`) REFERENCES `tb_jadwaltes` (`id_jadwal`) ON UPDATE CASCADE,
  CONSTRAINT `tb_pendaftar_ibfk_3` FOREIGN KEY (`kodeKet`) REFERENCES `tb_keterangan` (`kodeKet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tb_pendaftar` */

insert  into `tb_pendaftar`(`nim`,`id_peserta`,`nama`,`email`,`kontak`,`waktuDaftar`,`kodeKet`,`kodeProdi`,`id_jadwal`,`status_peserta`) values 
('1611016310007','1611016310007_1','Arie Sapta Nugraha','ariefujiwarasan@gmail.com','082299041770','2019-01-10 11:25:39','ket1','11014',1,'Disetujui'),
('1611016310007','1611016310007_2','Arie Fujiwara','ariefujiwarasan@gmail.com','082349328955','2019-01-11 01:48:26','ket1','11011',2,'Disetujui'),
('1611016310008','1611016310008_2','Arie Sapta Nugraha','ariesapta.nugraha@gmail.com','082299041770','2019-01-11 15:06:23','ket1','11011',2,'Disetujui'),
('1611016310009','1611016310009_2','Arie Sapta N','ariesapta.nugraha@gmail.com','082299041770','2019-01-11 15:17:22','ket1','11013',2,'Disetujui');

/*Table structure for table `tb_pendaftartes` */

DROP TABLE IF EXISTS `tb_pendaftartes`;

CREATE TABLE `tb_pendaftartes` (
  `id_daftartes` varchar(50) NOT NULL,
  `id_peserta` varchar(100) NOT NULL,
  `kodeTes` int(11) NOT NULL,
  `status` enum('Lulus','Tidak Lulus','Belum Tes') NOT NULL DEFAULT 'Belum Tes',
  PRIMARY KEY (`id_daftartes`),
  KEY `tb_pendaftartes_ibfk_1` (`kodeTes`),
  KEY `id_peserta` (`id_peserta`),
  CONSTRAINT `tb_pendaftartes_ibfk_1` FOREIGN KEY (`kodeTes`) REFERENCES `tb_tes` (`kodeTes`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_pendaftartes_ibfk_2` FOREIGN KEY (`id_peserta`) REFERENCES `tb_pendaftar` (`id_peserta`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tb_pendaftartes` */

insert  into `tb_pendaftartes`(`id_daftartes`,`id_peserta`,`kodeTes`,`status`) values 
('1611016310007_1(1)','1611016310007_1',1,'Lulus'),
('1611016310007_1(2)','1611016310007_1',2,'Belum Tes'),
('1611016310007_2(1)','1611016310007_2',1,'Lulus'),
('1611016310007_2(2)','1611016310007_2',2,'Belum Tes'),
('1611016310007_2(3)','1611016310007_2',3,'Belum Tes'),
('1611016310008_2_1','1611016310008_2',1,'Belum Tes'),
('1611016310008_2_2','1611016310008_2',2,'Belum Tes'),
('1611016310008_2_3','1611016310008_2',3,'Belum Tes'),
('1611016310009_2(1)','1611016310009_2',1,'Belum Tes'),
('1611016310009_2(2)','1611016310009_2',2,'Belum Tes'),
('1611016310009_2(3)','1611016310009_2',3,'Belum Tes');

/*Table structure for table `tb_post` */

DROP TABLE IF EXISTS `tb_post`;

CREATE TABLE `tb_post` (
  `id_post` int(11) NOT NULL AUTO_INCREMENT,
  `judul` varchar(50) NOT NULL,
  `konten` longtext NOT NULL,
  `status` enum('published','notpublished') NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `user_id` varchar(40) NOT NULL,
  PRIMARY KEY (`id_post`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tb_post` */

/*Table structure for table `tb_prodi` */

DROP TABLE IF EXISTS `tb_prodi`;

CREATE TABLE `tb_prodi` (
  `kodeProdi` varchar(10) NOT NULL,
  `namaProdi` varchar(50) NOT NULL,
  PRIMARY KEY (`kodeProdi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tb_prodi` */

insert  into `tb_prodi`(`kodeProdi`,`namaProdi`) values 
('01011','D3 Analis Farmasi dan Makanan'),
('11011','S1 Matematika'),
('11012','S1 Kimia'),
('11013','S1 Biologi'),
('11014','S1 Fisika'),
('11015','S1 Farmasi'),
('11016','S1 Ilmu Komputer'),
('11017','S1 Statistika');

/*Table structure for table `tb_tes` */

DROP TABLE IF EXISTS `tb_tes`;

CREATE TABLE `tb_tes` (
  `kodeTes` int(11) NOT NULL AUTO_INCREMENT,
  `namaTes` varchar(70) NOT NULL,
  `logo` longblob NOT NULL,
  `durasi` int(11) NOT NULL,
  PRIMARY KEY (`kodeTes`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `tb_tes` */

insert  into `tb_tes`(`kodeTes`,`namaTes`,`logo`,`durasi`) values 
(1,'MS WORD','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0€\0\0\0€\0\0\0Ã>aË\0\0+IDATxÚí]|TÅóŸëý’KïÐ‘f¤)\"HŠ \"¢ * ¢ˆ¢€èQDÚ¤H¤Hï½·\0!!½^.¹þþ³{%—ä’\\5”|ù<r÷î½}ûvfggvfgYP‡‡\Z¬Ú®@juð£ŽrÔ1ÀCŽ:xÈQÇ\09êà!G8\'ßY-ÖkKK·Ï‘©íºx\nu`Æ );Ykg<Îœ¼Å0L Ñ Kà	$\rzmC`±ês8ü†,6\'*3ùxƒReÎÍcë> ˜à¡e€þÍesxÑ½†8Ãå7`Œ††ž ›%€…°ÓNÌ™mó#sl¸~d¾¶ßÁxà ßÄRWDnÈõ‰,67_º›ËÃs’\n\rPS{0—öþñIúÕƒßä¦^(­íwóîk8ykÝçÝ™mcÛúD®@Ü\0{hC|±$r‹…™ã¡wfR/îYz~×Â·”9)EµýþžÀ}Å\0ý\'må±9Üh£AÛ€]ŸÍå¡Ø6¢Øæ±íBÛžØö(\n2nù÷×·žhÐaX!2Â}¯Ü“ðÔÄ2“ë#=†l\'hhÛb\'Å¶GaÐkOmþnj@t³;\"Ÿ ty`L6—/ÎEI£\\ÿEOCm·³¨5ÀÞÌÆ?AF—ÙlnCÓ\r€ŠmŠmŠm`ßõ4\r0«…,þžPRE(¤~€:ùA…—åã…ù8e¢ÕÍ€1Ï ÓdsxÂl,!Ï`Ðe#cg1Œ11\n°ÄRdšZ•\"^oØ¾Öó°‡Ä`£ Ø¢m\'êuêFhbÕÇðÃ^îu±í Fò?öp«‘yãå‰\"D²@àð…À²_õjˆË+¢ËÉCë#õ—´@ð³1;E‡ÃË#Œ‚”åçR¦Ñë‹þúêIZiðmg!QeXŽË|Ô¶\r‰8V\'âO\rÑÔŠÃ®#òÆsÿ Aô,6%>­3ÒòR/€¦¤€2€X¨xBy«±Œò_”±9G?3•.b°Û@ä´šH\"M°½³anë5¥ßëu¥ç¶ÎyÖ%Iâ!žú`3{BƒÚ6‹Ãi@Æh<hÛì,î^Û^CQöMPæÜ±oHðà¥øælå(liQU30þVÕuöaŠ²oJ2èuW®˜ä4ÔH¤¦=Þ`Æ´|Bêþ1Žu	Èé~Î–ñ Á_Pm#A\nŠÀp\0®T\Z#(KtP¨ÒÑ¿EäPiéßµ´z#H‹rã¹VcrRÎ.È¸vää\0­³7×XÐ„ö¼€èæO×lðrVû>†£‡¾	ÙõêÕƒÀÀ@àóùT/(i*ÓwB÷RŠKõ”9\nŠµPˆG12F‘ÊÄ(ÊRý\\ˆŸÉuäz=¹ÑÄ3&£¬HüÃXŸR˜•¼çðŸŸöÅáH…ÒÀ))P#AÅ>Á\"‘Op›N/~÷¯#×?`aã÷«Ÿá!”‚ƒƒA(VÒj‚‰_lµ…2Ú‰¡BQ!3¦ÈWÆ0I—\'Ó!»@m½6ëæ‰­—OzAÖ ?/í¢Ñ¹w©<¡”(p1}Þ]w\nÇ9Am5ú½B¸Ç£3!>RA ,•A±ØipíÙ¼¿à$ßUZÏ¥_=ø¿#k¦•Dåe%{–P« VúÄØ•;…REœ×ßð>A«\\h-‚¸¸8ˆŒŒ©T\nl6Ûý‚k\0a€×¾9Ù…V	ÀÜ>½eáé-s&‹¡yª¼4Ï2\0‡\'âõš¶ÏÍ\\Û¢‡×ßð>A¢¢’âXQQQàããÇý‚k€`øô=TG0ƒ¹´÷÷¯®ì_:K$Ê/-Êò¬Àá	9½&°Y7§Åµî?Ú‘{„IUÐ%^ÑÑÑ”	\np¹\\¯?—~Øô©$°èƒw/šxóä¦_8\\~¡F•ïY`sl”\0Šø¤Á£w{õËª¦¼6Èø:è“X‘t –€·‘]P\n£¿Ú,6Ë¢32§6Ï~5ýÚÁUºR¥ÓÊ\Z‰ÉbsHl„Ü?²ivÏ}µ\nŸWÇ\06‹Ar @Â\0Ä^Wo¦+aÜ‡€]öæÀòž.Ì¼þN]\\ìlyÕ–ÍáI„2ÿÝ__|ßÐûšÎ}]Æ	ð÷“£‹&aø+d óA.æB&\0¹„R$\".ð8\'IÍ’šåœH=u->ýõDY,³oÉø.%™Ç5ª¼gßÁ¡gs¸¡Ñ¨ë=~Í._Rk-~!ûÖi0êµ€Ú7ˆd€m–&%¦¢Å…Èå°@$ä‚™ÁGJÄÄ$rüì#áSñ•\n@ßebÓˆ\\*æ+h÷É»0gõ9ëw|Œq×Ï£Z }®•f:¥äð„|TC:ÿv¥_xÃ¶µÝð÷q3®B©2—úPž@lš¶c*NëX¾³ÌÓ÷æo¬²_©Rg¾„çqÙ0o|{ñ—=ûoÁ¢ÍW¬³Žc,Þòí Gø\"YªZ™£qö=¸ø ÀGú¼7+¢Q×ç½ïAGq^*(³oÈ\'ˆÌ˜\"È¨SÈ ô]6µ#|›s,ûç\Z¬Ú•l=gÐ©Ó·Îœ$(2‘<ï @	ÀÆùÕo÷Ü¸^˜\\g	˜ Q@NÊÚûÅ>!ÀÉÁ6`ëË«*$*üPQb	°jZ>ÊŠ0Àë.ÀßGî”Õ¡8÷òŽŸFtÇçg©òÓtÎ¾ƒC„d±¹¤Ê>Áõ’¶8e‘£÷=ð0ê!^x„8þ‹|BÁÈ•B±Úhrî”èLƒI´S‡ŽÙ©cÞÕMtƒ?>~¼œUA`æÒSpð|†õ\\þÝË,ðJ¡lÔœq˜,W*óz¤Óˆ¹{¹ïA!ìÀFyL}¡¡¡Ô)dNo¤r˜:\Zêñ+.ÑÒïÄ#hr!kèwâøÑèÔm,…ïuªÄ\0ý|Î%çY	uóø†ck§½&úg«‹²œŽIt˜8ˆ£!¢×¸ÕÇØ®Om7þ½\0êŠ+„Ñ¾”ÂÃÃA\"‘Ô8P•Û˜±ºu(9Œ -0Gî3{/ÜÉ²šûÌÝËû–žÞüÍrppÊ`yºC`sø|45B;\\°IªoR[~¯¡U˜ZÆ‰‘LN!™Læ5§a€áÓv ä°*ûLò±us/íùmšÈ\'8¿´0Ã‹Àp£>¸e¿çÇ\'\rôÊÞ‡Hð/õ¹Cý¾¾¾^s\n©0xòß 3XèÌ0W÷/ýôúáUsq(@…Ðó!a˜-€„/LŠOzf¼3÷>È–já‰Fê$N!¯9…HÏîÓí¶\rÏ\\ÜýË¸´‹»—àXQ¤+-ò°9<¾‘MzoÒóÍï¹÷A†˜g„§›•Ðð°8Ô‚ÇãyÅ\'–]£¾Ü	lKÙ,srÃ—/æÝ9÷—N]¬t¥L§j‰L “×kßvèW[œ½÷Á\"åY‚˜˜8d„PPÈ¥à+P€LÌ™„!8VNy«ßQf¹t+ÞùaŸ#ˆÅ^9éIenÊ>½F¥r¥öN2\0_Ìæòbº¿ñÇI¨£ \r˜yã¥dJX(õ6O@ékñÙ‚ñ¸ˆxÔà#P;_&!¾\0õF!þ\0_Ê4<ð“ËM8wfüvÌöáÌÁ¥ï>¦Ó¨Î—f:í²Ôßa 0Œ1´Ëè_v\n$¾uáad¡HÚÐkKèl ™B}É¥!€:ðŸu¼\'t…ú‘¾å~ßrèÌ]}ÚæzF÷ïÂQÍXlî-µ2[íäã(œª%¾Ï¨×†´\Z4u‘dó\"<Ì4-kš­#=4\"PJ\'a\"ƒe°ãX\n¤fÕ$Yê()Ê±<„rÔøf§‹ a_K>î!þ’²§`ýVïº\n¿mº`<P\'Ëß1whK¾Ø7]£ÊsÚDßß™‹Ñä\rÚÀ†]FO‹jÞû¾‹B\"÷n1!rJt?¹¨Ý^¹ÃvÒ¥J”fBQÖ\rºNzéJ!S±¸-Ê›õ‡²/–É!ÓTXóE_ÊeE0°pÃyXûïuë9ý·vÿ<¢£P˜YZ˜á´ \\U›Ëg£PÄ´ì7*¡ã‹3Ýbs/ ¢C¥&ôïojnW\\“üÑFºH£&p˜Rˆà¥Oâ<i è@ÊR(K´ Ö\ZÀ€v;¡/ÛÆ¿_]=…|¬›Ù^o[ŸYËNÀÎã)Ösªü´Óþß™.À¥E£NÅâÅ¼rEx£­M]åìýž„%àB,´ˆmUœþÜ}Ía¶|á‰†0¬WC»P¢ÖÁÀI*‡Ãbà¹Vj\ZOÃÃ,ñ„L:´_¤†´å•dÉä3]>¦ÒÐÏÄÎ\'ËÈˆB¸ì³Þü\0\0S€£ÊAy©çv_7íE¡Ä?K]œãRn§	HÂÃEb‡—æ«ð°¦qþÐ¾Y8D…È¨ð—#øøïvÃ¥Ûù½ø˜§›CÿNñvOÍRÂˆé;4­Kˆ3¨Y)Ô‹\n¢ñd¡ˆH$ªVdû2À`d@ƒL#FñÏªpýÛßî†+)yÖsÙÉÇWŸÙòÍX”\09%éÿpùBÆhëòêâ\\Þ†µûLèÛ¾žÝ^N\ZiŠÈ™u(daÒ‹m [ëh»¿¾šïÏÛãP9„”ÝâÕÐ¬ž‚2@DD](âÉÉ òn/NÛ\n™¹VkI»¸kÑÅ]?ˆçŠÀÜ¤Î-A¾-6ƒ§¯ô	Ip8<ŒŽÏŒIÃ¸Žb;\n•/2A²ñÀ\rÇ\ZïŸöj;hÛ4¼ÊK´:ÿd3äkj,ë«·:AËÄ`»?o;|f/?îNAjÞ\"\\m%t:˜øär¹GB„L\\%6B’®þ:ùÈê¯Q	ÌG3Ðûùhx˜ÑØ¨Ç˜Y¡	j#ŠL¯¤ˆDbGË)Ñ\"ët&aŠÓ¶@znÍY„yLì	Q~U^C\Zjñ¦ó°|û¥\ZËúåÃ^îk§€•ÿ\\‚_7žGQ/@Ýó!&&†d¡ˆ\'BÄM<`â::DXì†ë‡–OJ9³õÿ¸|q¡¶¤à?b\0®-µ_l›§ÇÅ%=3¹FK\0[óë·:C‹Ä*Å¶©±Ï×ØÛH ÄÊé}!ÈORíu9%0lê&005”5ËRT.‹ÔiÞê“ð×¾·K Ä\0Z° 22ŠÄ)D|žBv~	²Ñ¶\r™Ë»¾ž™|d¥^]ìrÊ:§€,Á?>1-4ëýÞ¯Ž”‘Ô8f¼Þ©J1_ TÃÉ(wWûl¼}Óì§AÀ¯ÞÛF8}ÑAØ{:µÚë6ÍBÏîýŸ¢Æ}àlšÃíÂe ž8•Žÿ		ñþ¾R\ZÔ)ñiŒ_U/å’Ó\n`ôçD)µÞÈœükÆ`eöÍízÊé!ÖR\\º‰Í•JüÂyôÙ™…‡Âýöñ“hªÉíþN\ZüóßÂîwª-‡4æÚ¯:¤/œ¹–ïÎÙYeõHÜýFd¦ªæ\0Þšõ\\¾Î ëúaà	% ’Oì,ŽI“ç\"ñ‰¹Z6ß/¤ïBü\0ä3=OœGhÆ’s¾\"ê;°Å‰Ë0qînÛ÷aN¬Úµ´(ûŠ—ü\0\0.2\0ÛÖyô\"‡ÃÃžêã†¶®’x§¯f\"ÁvU; [ÿ·û8Ä\0„ˆ¯~±’ïÚý˜+gô«’žýh=ä97½ž›r†y„Hú8´˜hù– Ð²ò­~åÎ?\0ÉIöÃ„îÐ,>¨\\Ù;ŽÞ‚/?d{½ñÈÊ÷[\ZõÚ«¨\0ºœ¶Ö5àðøF£!4iè×›Ä¾¡…‡	xøßóí;I£¿<m3¤dV=œµH†oÆus˜6ï¿ß®8j÷÷ú\nøéÃ\'ì–¥×áÉwVÑgP˜q\rtj%HýÍd§\'K‰nòû§}!:¤¬_‘qÝî+0ÿÏÖc†1–ìýets”8w4Å®ù\\d\0>—aÁMzŽ›ÛÊáð°QýšÁó½\ZWÙëÖìº?®9Uåý]ZEÁÇ#Û;l_—jt0{2™‰«ˆV\rBàë±ÝìÒ‡(\\Ï|¸®ÜT¬#PåÝ’‚t@³Œ¨—ŸÍ³™¶ŸŒE­“µ_¢~	Û¶Y¼éü±¥Ì*AS<cß¯¯$ñE¾\ZU®ÓBÊžèÌKÆb}fRtË~ãeó\0,ŸÑ¿ÒøfR¥Á“ÖÒü8ö0¸[\"ŒÜªrN¾²4ž•Î/XsVï¼\\é·®„™Fu°{ß•Û¹ð\Z,\'€¥-¾G/0|èYB0Áf]@uå™X‹ÏÜ<gðyemDÞcÎŠc°aß5ë9÷¯úcÜãBy`–«Ž Zg—nbsY(|CtžØi¤Ãáaä\'¿Üº?\Z[%Á¾ÂqnÛád»÷¿:°íÙ¸»¥ç(i±gÜÍVÂð©UZ‰3 s¼=´Ýzì=y>ù¿}N·‹DÀÀðÇ¸±±qà£ðCf:ß_ˆ–N…tþ_C-Ëgâ# Ÿ‹Kµ”ðëg\r®´à³…û`ÏÉk;*³“\\ûé`¡, u\0—³‡º<W‰\Z®LÓ®Å€©[Éåcoï*{Ã…Ù0æë¿+™K†\'AŸõ+Ýsèl*]\\Ñë±8»ÒáÃù»áðùò&Ýˆ>Íà¥¾ÍìÖcÍ®K0oÕ	k*6g\Zó¥v,ˆ­6{Xùì`åÏkcDB^…ó¼ûÝ8u%ÃêòÌ»svÓù¿¿}…/ñËÖ¸è²ÔÙ% \"(Æ#¦ÝK?žd±#/3wB/h–\\åï£gl‚©•ÎýöãÔ¤ò4ð&äXPcAâOüag¹ßÆi\rOwkh÷ù×‚åÛ.8Ý&Ô)Ô’Ä˜ f3)Èáæ]k›0Ù7Ž.»¼û§÷„² œÒÂt—ü\0îH\0ª¬¡IÃ¾ÛÉù8Ö©E$L{½K•ÃÀ_{®ÀwËËkïD9úý“~‡Ú{ÅF_¹ý<ü´æüøAoh\\/¨R™D³~aêzêá³¼õ”—ÛCÇêÙ}þç¿î‡ŽÜt©]º$2Ð:ÁÏ£ÙÃH¾¿šfÉÁ¤žÛ6/ùðÊÏL~€¬ÿžPä1]H“Þï-R„7v*<ŒÐ}ùŒA(³û»\nÇÂAWƒºÌñA‰¸~ö³àï#.w-iœŸÐ<ZùÏª[LÕÑî0ðçŽ‹0oõqów€Ùã»C›Æ•¥	·ßn‡“W2À<É@—&>ÍFÌÑÞo/§Ž.‹xûØši)§7~Ï+\n´%Î%†*GWodsù£AX¯í°iaw:<lðã\rQ?Z¥˜½ôlØ{ÕzŽDÈnŸ7œÎªU¼öì±Ûß ×üùÕ3àç#ªT&Y9èýU Æ1Ödk÷‡z‘~vŸ=lÊÚ2iá$bèÓR\n1ÑÑ~~îg#Šbßñ+ÊU3ùÈÊw2¯XL„èÕÊZ`\0Ÿm4háMŸ—ôìLgË	x°fÖ³tžÜ®¢)6jú«2¨	Qµ«PMšû:gš÷ù©G`ö¤€‰©®PŸÃÚ¯Ÿ…`i¥ç’ëz]%\Z×,+.h!}Â#L–@Xh0J-)(ÐJñ¥yƒ qÒ7šUC&ýi;/Á\\Þµà¥‚»×ë5*×8Õò8×ïdc³åò„M{Op)<ìÍgZÃžMª”¯}¾	.ÝÊ¡ßãqìÿõ“þv	ûêçáò­\\úÌ£¯žùöºÊb79-^D]€”A¤IEm›€ÌEô~{™ËŠc4@ÎÍcÀû€HdJ\ZÁá–ËDæAˆo@.€2¶õ\r(“wm	h)ÙâBrm›”2ÌÙM_öQå§í5hK\\Zb-É­›Ù\\	_ì›ØúÙ™Ç*ìàB¤°ò‹Á8FV¾•4Ö–×àËßöÓïDûÿf|¯Jæ!\rÞœ¸\n2ó,íÀÀ´×ºbCÆÙ½vÜ¬­ÈTÙ°}þ‹v‰|5íç&ÿé²âFJÌ¹u‚Î€0€Ø‡KžCMM®øø•ÎÐ³‚rºïÔmøpÞÎr¯rfÃôvÚÒÂ³ZU¾ËŽ Ë3]BÆ¨K\Z>÷\0¾°Óáa¤WÌÓº´Š³;—¨F1<à½•t‚¤6Ê”ÑíJ€žo.±MJ)ó\'õµ»‹Çž7á»e‡í\'G/¤Â;³·¹ï\\p÷ ~D§ƒbekSWºl^Ÿðý„\'¡u£°r?mÄaë«ß÷Û¦Š×_5±9É\ZUžKBlë:Ðà£ÒôÉI+eAq.ekŠfÛ‚žªrø~ù!øsçEx¾w3xcpå™»µzŽYR¾MñËâÏ@ý¨€Jezò¼`æÛ=í>sãžË´±ÝÙÉ©8ç™ª¡4\0øR?àòDÍ–åtéŒ§¡^D™rJ:Éò¿ÏÂ‚ÕG­uÂa¦àÐ’1-pxIÇç¸ì\"pwÀÁÍßqä¬À¸$—²‡‘Ù¶_¦ô‡Fvìw‚[iù¨•¯±C“`H¯¦•ž­„V\0§‚ÈîÛ1&½lß$¼t3\ZÆÚýí÷M§aáºÎ-0¨\01«E*àŠ\0|_(ÑqÌ9ƒt4m¡ª) í&ÝXbÃwÏC ÂvEóW…Èèu¥)ÇV¼Û^@ÂÁ•Y.;‚À‚ÙÂìò‹hÞg\\d‹~5‡‡UIqðékÝª”oÎÜý:\'Âí*ý~Çó—?YWÉqCÜÏ}û<*ZBptñöþõ{.;|=¸—¡íät\"ˆdñó J)±ãÉú€\"•šNêä–Ba±\Z\nñ{ñ :yd§r>\r:1µhlÙOA&®T+³ÏžZ7µ·@êŸ¥qÃ@à¦àhEdó‰]_w(<Ìˆy³fÖsU˜e\0ÿ¾þ¾bhÕ°òÄÍÁÓ·á½9Û\rßóÌ£0ìÉækô¤±?ø~ì?âÐõUA€ô{¥›”æ\"3‚AAAt¡HUõ°]#`O*MÄ:°©Saúå]·ÏÎ—(²µª¼Úc\0Z\0›#ù„>Ò¬ß—³‡‘›†õncžM²ÛHÄABfý*Ìlø÷Ì\\¼×®ÄÁª¯†Úµ2ì4öÈO×ÀåÛ¹î5\nVfTDG„–ËæÚŠa^™¾.ÜÈ²žËO=ûçÕ~-ŒMq®[»•ºÍ\08Ðð°6ÏÍ9Ææp\\ÎF&„þš3ícÇS®Ólš[OÃüÿ®ò÷Yh:vlë`yôy{	Šg÷6§N¡ÖhìTö°ªêôôû+P×±FJ1Y×ýš|hé$4 Oã†€À}	ÀáñÑmÞï“BypSwÊšðB{xº{§D6!þÒ-gª¼¦M£pøáƒ¾•©Õé¡ë+‹jŒNvð }“@«OÀÕìaä{¼ñ—”eK;»å›Ô3›fò%~ù8¸UYO0\0Þàú_«ˆlæVö°È`XID¶ƒ\rE\ZgÚÿí‚­®V{ÝÊ™C &Ì¯Æò2r”ðÔø%?¿:4‹ä@¯–ng#¾‹n¯þ‚M\\¶+åÓ}”qi÷O¾°Ð•ÄP¶ðÀ@—ŒD<ÒoRX“^ne£^ºw{;%²\'|»•¶ÛÕ^7¥Ê„;Ö(Î_Ï :€\'Öôù\ntÐ8Dq±1˜X¢\"BÀO.™DˆZ~UŒÀªdGeç«àÉ±‹ËCákß<²üüÛ§Wèµ*—„”=ÑÝHx˜ÑàßnxlÒsngk‰šþõwˆTiûäO¸˜œUíudÎó/D\\}Ü\n±6¦ÌÛîn“Pô\Z(H=¨©ãá\\)i—còÈÈÜ¿\\DCÙät­€º\'ÅCãzåe®ßÉ…ç&­(Ç\0WvÍ¶8÷ößm‰ËB,ðÈòUd™Ä/ª]Ã^ïnu»L$êÒÏ‡@BL —2ÐEvFnÍíðÞàÙžÍª6ÅðX‰\nåœeÜš´}¼Û\'€+”*kÀÉÍáV¹«41c?\ZÕúwmTîü±©ðæëm®g1—¶Í~\\­Ì:¢×¨ÜòØ©†‹…ð067¦Åà™N…‡U…>aêkÝÊ¹ÛuôÿÑd5!:Ôþ÷õ0»¡Þ;ü‡`ÙæÓ5–å(òÓÎÑìa&09…ªZFfDg¿Û:µ*?üm;x>ž¿Ê6‹æÂæ/[¡„¹Œ\n {æ\nxNÐìaÍLÛ‰œîvö0²¿ÎÆF€¿oõ‹@KÕZè<êg‡z,]ð9©?$5¢ß‹ŠÕ’Q\07PÄÞNÏ‡[wàê\0dfÎ#ÀJ)³®ãP ¦@¼‚®Àº£ˆ©áÀº0€ø–ÌRiøß¶30{IÙ<¶sé©Õ4çðEwt%nWÖ#@ÂÃŒ]HB—7‘ø\0O”9r@xý™Çª•Ä6î3ö7›ŒÕ#*TA—„ÝJËƒÜÂRs?g39Ñ.šl`ë•`äÊáÉÀÀâ!Y¦gš÷°<›˜ž}ÿZBeËÕi€êÚ£°pÍëlçÌ“«\'>ÊùdèJòÝò\0xŠ8¦ð°ÈVƒ¦Õïä‘ìadÑä¦y/ƒo‰5iœ+·²àùWÚ*H÷B¹0¨]šQ\r<„®R*P–B^a	p\"~â ç&ìQÙJ#¡ÿ«·[A,Ðk”×Î®ŸÚ•/\rÈÒ(³\\^Ö=\0ÔØŒA§Nì:*¢E?d#?et7Ð­lé!™II/@Í8‡þ={5N^NûO6mvþR6Œ|<†‡‘A²¹dÅœ¶kìù>úa+µNLW1P’—zäòöoñ%~YZU®[~\0úL¼)\rcÉ¥õzÔïò†Ç²‡EùÀcÍ£àöÝ|¸‰b›$~ ááËKBÛ³ Qic{Ð©`Â\0Ä)äÌæ’tƒˆÏ×ÂÑóeËæ‹2.o¾¾wáhžP–­+-tË@à±®CÂÃPLlÜgÊ1|¿ºÍ%¨ÿ•Çfu\nÕ”=Ì„†N\\\n×Pâ™öˆ&ÿÎÙ·-y‡€wý\0žc\0fk>ðóý¨†z±]ï+h#ƒV\rC]ÊF ×ëQò‘xGª2Ù×öý˜zjý\'&?@î½Ã\0tKb	t{k¥$ ¦nsI3:6C×!”ˆSÈ™ìa$Ãh‡ó@cŽw$Åéç·NÏ¼´cZ8¸=zr ›KF·:KÝ²nsI3bXÐ¥©/4Hˆ‡F\r 88€NÛCEÉ@æ*:œo{ŠI;³ñÝ¼[ÇÃÖ-2hT÷˜Šø7ìþvhã^Sîµ<Âµ’1„L‘œAda©ÜäR±Éà#©úz´M€\r\"ÊµÚŒèóæBÛyæÖ‘e/+3¯®5hKÜZbçˆDòããÚh@L»—\\{Ð€æ1¤Ù °8…¨°Í0qd7x®wËr÷ïä°þ°wd®ÿûc?uaÆnƒ®Ô­!¶ÏöHx˜@üHb÷ñu›KÚ  õpøbêDóÍš=ŒÀ2Ã÷åø¾Ð»Cùåê{Žß€·g®-—KêÚ®¹íuê¢38þ»íð0‘p¡Ñ¤ÿ´cÈu›KR°@™aŠ2¦@½‚üJÂ~ùl(<Ú$ªÜëvž…Ïl3¹L£½þÒÖ/›ã½Éžð˜jçÉWesùcMèþÞF¡,Ð­ð°”æßA] ˜® N!ž \\¢uâZ÷ýHˆ*sÓ5\nŽÁwKþ-;g4žßðq_rW¯.rkAˆže\0šGØ“4|®<¬QÝæ’f´ŒE%¯U0ø…‚Ô\'\0´F®9GÉ\'@Ž	#ºQeÐšê=°xý‘²-bôš;6Mk‡LD¦ÝvxšˆO  ¸QÏIA‰]ë6—4#6H\0Ãº…WÚ\\²œ€þW>1ÔÔù[à¯]e©á´ªüsWþùæ	¾˜¬ÈuÛd}®§@Š0F£¯\"¦õ°ˆƒ~ðtù÷+ä\"6¼Õ7ÂÌ>@6—¤+™g®ÝG¯Y·œWå$ï¾¹ÿ—ahQdëJÜvxœ@$<LäÖ.®Óëî‡‡=  ðî€ˆŒ0ùBBBjt\nxáÃ?àÌ•²ìf¨L®½}déd€]I¾ÛŽ KÝ<û²l®˜ÅáÆ4|rÊI|ÁºÍ%Á¤åìâÃÎF©Œù	RÒMÛßI–ü;§§Zó¹žð˜Ëõ,,áa‰=\'îà\neõÜ/ñÁ@¿6~Ð¶™i°8…ªó	hÿÂwPTLÂþ(™˜ì+»gg]Þñ%Oä[€CÀ=Ê\0>1êC¢Û¾´ˆÄx«Aï7´k ƒÞI‘å¶”©n¡YùèÐYÔ!d“yéŸÉ9×÷-@3°Ð q=1”-¼À\0<cÐ„4í3Ý/6é¾ß\\ÒSh!‚!]¢(ñ	-eªË–WG|g;L0ég7¾Y”vn™AWêö‚¼1°Q(üëµÜ¸×=·¹dm!@Î…1}b \"2’º†í…‡ÙâFJ6ê\0l—©1)G–-ÉOÝbÔ•º½ ÄÏ‡„‡K.öîÝvD­n.y/ËaÁ{ƒb *2Â\ZfÙ\\’ ¢BxôÜmñÑÛÖcnø¥»¶8çˆ»™Áláâð0®PšßíZÙ\\ò^EiÖeªü‡FÐð°\0?ð•×°ÄœGPþ\n)øûHàäÅ˜þóß6û“¼g~k£^{	@·„Xà%à	Æ–ØëÃýl.¿.<ÌUÎ\r`àIÀÊE¶”Š‘Àe+•*ì¬¾º}fs6‡Ÿ¢W;¹—M5ðœ´ÚZ!RD¶óJkÞo@¢ªï‚^­ž@‘¼òJ¡j`4è2®nû2‰Ãe´*ø¼5Ðð°Ðæfù„7«3CSœÃh•Y$:ˆE×\nò„Ž£L¿´.íäêq¾8À#~\0oI\0âòóïôv`b×)ÞzÎýMqnNîõ={yb?	žÈÇ‡‹öj	Ù{Ž°Ld¬»œ ÈOM9¼ø]Iþ)6WkÔk<2\rLàÂ˜b˜|¤A	Â[\r©3Ã¨Wç]ÛþõËH\\âÈ!mÂ6ýeqPp9‰{¸õ&9W óá\n¤Rý¥ÊŒ‹{Œ:õ\rlW’[ŒrØ˜á=Â°8R4ð‘˜Ž¯Ö…‡™Aöú»¹gn7ìÉwÍ§8v®ÍgÒnd¼\'lüZ„¥xLüx‘08ˆS#ê÷œtŒÅzXÃÃË¢?¢Å±g¤_þ‚º0ý8¶M)@ÿZŽÍyrÚ|x”ø\0Þd\0f4„Æt|c#_êÿ`‡‡1eâ;—êJ\nHÄÎmqV~NÓg§á÷d€;dB•¿lü\\Q“gÙùkY?n/­a÷&K 8¬Åà¹ÒàÄ!<Œ±Äð2¤;ë5ù¨Ñ§kKò	qïj‹³ï¢h¿ƒŸs‘¸,TÔBdÒkÉ_ÒƒÉ>¶¹,6G‰Œâ1EÎxs áaþõ»Nò¯×þ~\nc,MƒDÒê5EÙÚâœT4áÒu¥iZef\Zý®AC2t1HD–ÞLèª]…ƒœÓƒ—z´³ðQHa£ÑWñÈ°à&}îµð0ÆvGg£^[¤UåŒ©Ø“Óµª¼»:\"ÂU¹YÈj [:[‰©ê‰Lˆk°9ŒP&Âï	¢ÛÂ«DAQ\'ÈCÛE>öÒÆØüO•0”¹\Zöf2ç¥ëJòÒ4Ê¬»ºÒüT´³ñ}½ÙBðŠ=™×BìŠD¾ç]¼Ì\0\\12AL\\·wO ëxÞvçÀ”­¯¡S¦*ìÉ™Hà;\Zev	ž“¦-ÎÍÀ!©Ä$¶­¢¸º­·9î‹Þì\n¼-¨/…Æv»ƒ#¸fÊ“Æ2í­bÐ•æš/\"®‰¦M>§â8‡[g£„ÙëÑ¶P‘ÈBßw½Ùx—8<\ZÖrè\"±¬#áaåz3’Y­+-ÌBÓ±?cOÎ¢\"ÜH–Ú8Þ›mÇfò×å{³GâëîGxYð8È\0\rzL÷jmVfR‘/zM¹§!±Q	Ë1›Ty9Hc¹7[]ql®HdÛ]‘ÐtovÞÖhx˜oô££üºNÓ#•Ñ¤B\"»\0M«¬4}IÁ]<_dšwØ¤ªil®#´ƒð²fN¢ÃØR6‡ƒÃvÜ|óô¨#½ù¾3©îGxß4#¹ƒ#IIâè°³+ŠmBÜ‡J	«mü¶9qjðW®ùy5m‹VGèZÀ½4;W‡Z@<ä¨c€‡ÿyŽºË†jt\0\0\0\0IEND®B`‚',35),
(2,'MS EXCEL','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0€\0\0\0€\0\0\0Ã>aË\0\0\'~IDATxÚí]|SÕ>Ù;MGºPZZKÙS–@Y²DdŠ ÈP‘å`êPdeˆ2\ne	\rZ–.ºÛ¤ivÞÿÞÛ6MJK›ä¥´Ð_HòúÞË{÷|÷Þsîùî}¨Ãs\rÆÓ¾€:<]Ôà9GžsÔà9GžsÔà9GžsÔÀtþ|ŒÐ Õ«Ï.ÜA=ík¡u(Fô×o3ŽN]Gu_=‘%7Œ¡l>7Üd0…£RjÈd³ÂLf`öÝ¤FÚ<Õƒß{&HðÜ ÛWØL63:}\rerØ(“)œÅa‡2à†eÙ”|¦îî9;³ÿá‰ë†§}tà™\'ÀK+Æ‰‘QCAÃMFS“ÅC›#˜V}dc‘MåAuÿÈ¥ù™7VäÝ¤~Ú÷Fj5º¯™È86m=ÕmÕ&n¶)#Æâq\Z‘ZÍ`„¢f»ƒÉD†fÑtÏTú•{Ûã÷ŸŸªz”«xÚ÷Ojº~õ5È¤7D £â~™4Û¨ùEwâÎ€r›mZ¡HÎº·ro¯}[åÿ³çl­÷j$P³-AMtCdPl`T‹I³^ÜlŸÆ=”XšÒÿü|v©ü…À¾LœÁw—¤³ù¼lD½ôç‚#“¿©U¤xj@µ™‰Þ<)Ô/3XLìi7B—Ê*n¶ÑwfM¸Îòu-ây ”»\0ÏE,îar”ˆ)ÙEå ÷Tt9ˆÀY&#•ŽÎ,ÊDe£W\Z“ÅÀï9F½¡àèôõÆ§y/N/Ø.KÇrX|N0e0E _Ãýr˜Qkˆ`¹¨†ƒ[ÞvFÎÝdr©˜\0¨\0]æ6¬@U°Õ„þ+@ÌLŠz„ZºLDD\Zê\"&	\"éª ˜<9¨²(þ˜ö­‰Î{¡¥À‘Æ0êô±!ò¸ÃÑEãZ]Ôl³I³-pÆï> zžŸ˜•¶ˆ\0®b`ó¹€j;m¿ð„ŸV¡ÿ1A²M:C&\"^ŠQoüÞ¤7þylÆ»º›®ú¥•ã™èF½MFcbk#FQ³Vìmû£]jl³M\'ÔéyP˜¡\0ž»„îàùÀd2?±í@\re(ÌÈY[ Ž=¿t·Í­C¥Fj8¨=Ã=Ì¯bû<&—ZÜlÛtŽg\rÞL)ôriî>rpó–ÅgBWJ­\nòÔ¯)\0…Fùj%äVëµ`0ŠŒaÑe8î3jêS‰Ç¯ö¸wè’ÎÖc+5ž<*˜ãÚÐwpÐKMvTeÿçB^“µ??hÐ Èåràr¹E¦¤Ê7¨Ö \"	&&INa>\"L!ú¬,&\"ŽZ¹jÙ^¨Ó“å	>˜Œ¦ôãïm\n•7V¦^øÇ&FUjP¾›XÀw“´jùî+\'«²ÿó\0\\Ã¥í À·ˆ\0^^^ÀçóŸh¤Š@U@Ñ\0*DiU”ˆ0ˆˆ<\n´í|â\r¸ŸbÞ×¨Ñ%ÆÎÚØJ ÏÉnSTQé³\\º³àÎKÞøÝ ¯º»&…{ÐOÔÂ|‚	|}}A(ÚE\0›få‰íÑ¼M•‘wíÏ?ôz¸dfäÙ”£¨ôŠ™2R>ŒåIõ~‡µø\r¡¹W(Ô¯_@,W‹#ˆ	°àÈz¸øð–y[öÝ¤Ø¸UûGñe¢LMnÍà±9”ÞèÝtRŸ·0ÿh§ßa-Ac®tòŒ„zõêA`` ¸¸¸\0‹ÅrüÄ•\0`ú/+àßÌDó¶Œëv]ÝpäžL”¥ÉVÒÛ ÏŸ…âLyèàö‹:EŽ¯Ê1Ï‚ØnÐË£¸ºº›ÍvúïbŒùa>dä˜7%Ÿ¹sëÇ“sîÒuf¾M¡`Uº\0&\"€k`×¨ñ\r_iûEUŽyàÂÀ«mÁßßŸt$p60Å¼…zyÓ½ƒ—¢p9rØs59ôF&‰A¤²>ÑÍ¦¼¼«*Ç<`¡bíÖ|ýP$€€#çtGP£×Á€M3JGG\Z¿ÿüìÄã×7²øœ|½RM/0˜l–ˆë\"lÔnÞ°‹ëÑ¾ç\Z‚-xºz@P½ ðCDp—º‚˜\'„à&”š÷³\nõp‰S¥Ÿ6Ö§eßò°J‡ž©›ÛŽOÈ¼‘°K¯ÒÚ¬Q¨\Z8l>e4úvübÌYã]…\\“‘ÿ_\Z„¡‡x21°y\"®8¢|’}°ñÇÿ¸ˆŒÊpˆAÂ½Ðw	_RôÙMèRü7!ù;‡UäO”mQîe%ÃÄŸ>&£¸2€º´jÿ`erÖQC¡¶ÀÖ{¨\Z¸l.ò¼›¿Óï\'—`ÏvO»àk\n”ÉÙ€š\\¸K€ï*!I!\"Àw#æC ›Ù`ÀÆ™ˆ\0š\nÎÂ0ïGZ\nô•Å`€Ã…ˆH!ò\0«½/=¼\rs÷¯±gPWþÒY­¼¬SÚzU\"\0ƒÍdƒ‰’‡ï¼Ü«EÈðª÷¬yÜP˜žGK	¤xÐ(T2»ß\\n\"²î³û¯Ÿnóˆ¿‰2ÂÖQŸ‚ŸÌÓjûÑ»çaù±-ç£LçýÔÌd4Æ#ÐfbU[\0¦IgpêÑlz½^Í?ªêqÏ:ô\ZÈ¿ŸNRÂ	pD\n²ààÛ«ÍMx¦2^ûnŽeŸ]%àÆà—·V’îÁ¼\r½~¹\ZëÎìG‚2Qªã37Eq%È#ÉSim½‡ªµ\0øê)ÊÅý…À‘c»ÇTõ¸g&ƒ²o>Dý¿ˆø\\±\0¤\"	1\\Iß}õÙãw,*í³«iÒ\ZDœÒãpñÝù}°ãÒó6£VŸzjÎ÷mÑ5¤k²•ôgÍ;²˜b‘—¬iËYOÛrÜ³Ž¬‰€åaL\0©ü=¼aëèÅf\\IºïïýØ\Zb‡q÷¸åVN &À—Ç·ÃáÛgÌÛ4yª;çìˆæ»K2Ô™\n½­×_åËBÝ€\057þ>Çd±\\ª½¤k\"Péåý›J>b`}`ã PXýêl³áŽ¡>{ÉßÙ|ê@Woˆ¹à1,ømœ½Õ¼-÷¿´ÓWÖ†üLäØ<Y¥ê`³¸(äñiõÁ ƒB¹Kd5sÍ2ˆ2)ô…Zâò]EÐ!¼%|ÚoŠÙp¿\\=ßœÞY¡N \"Dù‡Â—ƒf=F€é{–Ã­ÔÿÌÛ²n\'ýzcÓ“¸RA&òl˜V\0È«¡Œ&¯ˆ1]×¸G¬þÒ®™(ÌÈM–n\rôiÞf÷K‡\r¶õÂô:hóy;†4ƒù}Þ~Œ\0c¶Îƒ”¼ó¦G—â·ÜÙqêÔd£.€~IX	Š#à^Íçvmò®ÍCXÏ(´ù*(@­\0Gˆ#:ö‡·;¿j&Àª;`ÿõ“6Ÿ·OdG˜ÕmÔcxeÝ»P 5‡ûTÂÑ«_>8té‹â<€óÀ`3”‘’y·n82tpûU¶û,Ã¨3@îÝ	àPprÏ0¼M3Ú\0\'ã/Ù|Þ­ûÀ›íX@kÐAßµÓÀh2Û™ºw0î£¤“7¾åˆxù:…my\0›ŒˆH ‘øy¼ØdJŸC¶û¬9Rã©øˆ\0ýÚtƒ¶!MŠ€þ}ðóW—xLh?¦YÛg™(“;½CZD[rVAÙ`åPÿî9;9ãêƒ†BÛó\0\06\Z9‚Bô\nn;Ø³N†	0XÞ\ZùÖ\'iaœ²”‡Œ\"- ÐÈQåµ0~æ*‰ÞO©)‡æ*‰îç\rÞ½#;XýS»å«<ÀõõG†*f1¨u6çŠNaËÎl&QÙ§õ‡¯ÆrÄuò°¼$‹€V¾á6ÉÃpë`™´ltF=q±¸lŽÕ1—oÃÌ=+¬Z€¿Wè¦ÎR\\Ô«´*{®Ý¶\0]e0z¿ðf÷YˆO<¬ÍDÁð’_S§ËÃŽÞù>;´Éü‘ÈtiùÞÈùG›k{\0Ã6pX,“Á$¯ß¯Õ\"Ÿvj•<¬¨’Q¤/pxà+óW‘®$Ü›‡éÊ >OýüÛ8U†ˆŸ¯…¯OüX:SÙdR›÷CSŸ›¬Ë/ÔØs^[	@äa¾#ÆÕëÝb‰­ÇW7„<Ôóðƒ@wv÷… üŽ¾{K=ÈûÚ;áÇ‡þW¶Føwÿ\0çÉÃ°¯sv/l;_:¦€j~ÚÙyÛÛr%‚Gˆ\06ç0l3 rc¤Ò`ÏèÈqÑ5^¶ý­/Ñ}Íwj9tQ€¯Aß¼Kfà8\n&:o°Rõƒ`|Ÿa ÷ô$ò0<H?©@<¶!ìPa¬øc¸~Ê¼M—¯ºsá‹=Ñ|7I†&Ëö<@É¥Øv\0›)âJ„a-ÞÕ$ÃM·­ãN­ëEÂ—Ã>(W£‡sû_aÝÉ]´]cîÝdð•{Ã†)Ÿ··78ÿà¼·{°™,py æ‰ÀU(™+D$á#J‰*«ƒ°†\0ÿÍ…/&ïeæíûN[Œ)(f¹úÍo¯ñdâ­óJ`3P7À§Œ&ßÖ¥UF1è.Üdãš‹›mü9)ç¬=þS•—döÌkïC;—ª™ƒ¿™AB2º€u\rÜý`é³ÉœA	ºy–Ž©TRÒ ”¨‚\ZxÀ–±Ÿ>F€©?~×“ãÍÛrî&ÿzgËñI©0SgG ä·mB‰<,rBôO’\0¹Ãò°(ÿ†Ð-¢-Ô—û#cû‚»XfuQ%#j«m‡Té’Ý¼aÇÄeå†bø\\û¯ž„¥Ä›¦«£@•šá²@˜;tq¥R)ì¾üqÚl•µ~¾\Zúþc¾i$£ÊP²)ãêƒ­ÿî:ó>ê²Q`×ÂötDÖ`p»åò¨zËÃø.¬\Z1\"ýBžXÃ&#ÌÞýœ‹¿Zé9gö\rƒ[F—{><Œ:|ý”ý¨ÒóØMŽ¢Ä0¥ÿh¨\\d2l>÷+lýë€ÍçêÚ¨5,ì?ù1¼¼z\nT*Ù”|âÆW‰¿ÿý9ÏUœ‹º€ê!\0“‹\"ÑÍ¯Käô€®QÑ‘ÂÍþÚÑCyÀI FÛÛ[Á¿é‰î#BžÿþwÖ ,p!žú\'æîþŸÃ¡_YT\ZhÁ†ÑÑƒI$àææ_Ænƒƒ×NÙ|®ÍºÁÌ£Ëôør‚U\0ÿã”Ó·Ö²E|›ç”Àö€I®ÊEæ7 ìõN›í9GyÀÐú7>·\'»Š¿ù¢µ+ÃÚô†w¢GTèüÿn>ÜN¹GÇ%[ËÃÚr‚aPÇÞ„\0ž(XøÛzD8ÛAov€^­î!» ú­™fYß¨ûû.LÍº‘°™@i(ÔVÈA,¦X —6šÜ›Vy˜·‹¬{c>xIÝ+Ü1µ\0o¿Œ™[ßöLý\n|]=Ë=örÂm˜²u±Ófïtæ‡B·¦/’)ã>>>ðÞÏ+ájÒ?6ŸçÝèQðjËVÛîg&Áˆ\rs,ý\Zêöw±¯$g¶7PTfv€ÈÃŒ&ÿ–\r‰c²˜´ÊÃ‚<üHK ³˜YS˜gãÿ†÷w®DŸK»¾Na-aéÐ™Öþ;–Âù{×è¼\\+ôöh­‚#	ðœÁñÛBbNªgaÀ\'ýß†^‘/ZmÅäúÃçVón®ÿäPí·+PôköÄfrñšQS{¸Ki—‡5ò©ßŒ™GúóŠ€\rºëâïðå‘ïIÍÇ!äZtö Ën5F­›C÷¥Z¡³ûðb`Æ‘À°˜Ù$Ãgð}¬>ZÕ³.Ößož……û¿µŒ(¨««67é\rÿhóTv¯[l°èÝhò\ny­Ã\Z×0_§ÈÃš…“è€Ç©xH•¨dl]Ž@Cï Ø6qI…µÁÞoàÈ3àL4‘CÏàV$\n„Af‚²-<7!\'ï‡‰K!Ä3Ðjû®¸#ð¿?¶eÌPÇ-ÞÅòìÎ`Ø×å<ü»6žãÛ1â]{ÏSÚ7lË†Í2O²(8<œµc9thýšu)—\0iy™0hÕt½ÒºÆâcä{À«õ;‘Œ §¯¼þÝ‡€ºH›Î½üï~måao:ý3lþs¯yªùâ>ÛÓš#â§ëöå0ìu”É$“7«?2¸oK§ÊÃz4~šj5A¢,TZ5n-¯µ £‚‡¿\'­„³!a`|HO\"\n‘y¹ÃÇ‡Ö‚\Z…oxu0ƒÑHê.QAÑ²Öå	…1OÌÞ|N©ÞßÃ²Ã›aïåXó6}úß¿WìëÊsgh²•våÈïÙ} ›)ù¸¶Ûí°#ç©øæ‡´î¼<Î.ï«nú®œLâhg_Ý¤>àëOAœÀI!=V©ˆÚ\']éò‹Õ?¹*ñð2qy*%‰l~šôø„~^Çï\\0oS&eÿu{ãÑ!\\™(C—§²ûáŽ€ÈÃš½÷Êpöêa¨¦¼Ñi\0LîþºM$À·ñÄnØtr\rË1Ví÷FupÿUZ=¬¢uÊî÷›²íS	” ?>íÀ¿;NOàH™È°{Áiû	ÀbòÐ…ù4™Þ7õCN—‡açgZ‘0ºCÿ*“\0öCµ?¿Ðî0Ùfôônm#i]=àõoß‡™ÉæMÙ·’~¸ÿó_³¸®â,m¶ÒnçÆn Gc2˜¼C‡wˆ‘Öóª6yØÜþ``Ëî•’€„‰¨ß_ñÛæêº4‚V®\r!º^+Zåaø^z­˜ˆº³ð—J;{÷ëäc×¢. W—«z*`™Fy@¦‹<[†T›<þó¡ïB÷ÈvO$.´Í§~µG¬–KÐPìƒ\Zt¤U†#NŸ&¾DÉí%Ÿ¸¹ íôí5¨È³7@ÊÓîÙL&e0¹zµi8Î¿[Ô’êœ)ÄBÿŽ)Ë¡Wà÷Ã$øbÿøùâQºs?Â+7C{B­à\0r©+¸% ÅKÀð…Og”_ˆy¨æw_:ÞJ\rœôûÕéY×¶¢ÆB]õ D&ðˆn8¼cµÊÃ°fàÀ{kŸ8HT\\{>Üù»y¾Z®Œ;µQØwçÄ«Ò€-âaÆ’!klx<¦³ŸR¡Ø¬\0ÂÄÀŸ1IZÕ„Pï`«s&f¥ÂÀUÓñ‹Aý·óì(åÃ¬ýFµÎ¶¡Æ2pÈhÈq$ü°&õŒCÜ­¶ÕÃ&÷ovTå¦+€¦oý.þwÝé×†×z+¤ì½~ÒŒ\nàŠù¸»¬Ò±ø~p¸ûjëžVÛ¯>¼onü˜æûePw¿?Þ[“©8cÔèíÎ39t0›Å§L&ß&3úerYÕ²z˜+€Ã³7€D ²é8LÜ4nZHªœÔl¯œ„Ž¸NžU™¬_Ñ‘í­¶ÅÞ:³w®´ú•Ûµ1jt·ty¶/e	‡€˜ÍEŽ wèÈÎ?‰üÜªeõ°‘(œÑgŒ]Žp·þ#x‘ló±¶ £ç{ù,˜„,à¸+{¦dÈwübhaµ}÷…ßaÉA,a£JöÓ^ÿò`Tþ‰z…Ú!Y³£]\0]Œ<èåË]#ü¾z…Sß_^2ò°\nêáôü,»î#HËÍ\0g!B\Z\0þ¾l©\0x˜\0U|¦öWö¾»êyú—ÞžpêgøöØOæm¨Òe_]¶¯%ò/R\r\Z‡†8mpRÈÍ«}ØtŸá´ÈÃž„¾Í»À¢Wß©0ã÷kÜ1èÙ¤C¹r0K`§jì·B.ª`Kàu„ïü\\d|§“åãUH\náLà±¹›ÁCâju_Ë~‹ç›·\nµ÷n®:Ô…ë*J×fØÀpÌ`Åò0—Þê\rlM›<¬\"ìž±\ZB¼ËýðD^ŸƒÆa°zìÇOÌ âBý\'õŒ_ÿ1y*Ý Œ&È‹O£Ï@È&»rà(áÜ‚­&…âkýp×WðûõÒT¶:Cw7&v\0\"XòzˆµÃÃò0ž»¤iØ˜.N]=¬CxXóÆÇÖþÎ€ŠFý^iÕ\r™Zé@Ñå·`rÌBÐéªDå\"/>•Ô|Üpp$À®<ÀŽí©·>–šôÝB¸`Á(î§¾¿ëÜ›è¼™z¥Æ¡O:l0Ô\rÕÃ\ZOïÇ YfY1o-”/>Â}gÿe“ %\'½x€I=†ÁÄîÃ*%Áé;q0sË`¤Y+ LÈ$¥K Á¡ »ÒÒÆ‚Ø³Ö>F€¡«gESÉ¦ü»©?&ì‹›Z—,Ô8tát´\0\\\nú„íz€ç&nLk)£q`(l›º¬üÚþ¿qf #–ýû¢¡ï@ÿ–]+%ÁÁË\'`ÞÎU´fÓrÁ€ü3L\0\nV!ˆBÝ×–·¿xŒ\0Ñ_Œƒ¬R4•uùþÚ”c×ç£. uO™\0l	˜(¯àþ-×HxÓ.ÃþrÌ\\èVÁØ?. ±kçÂßn?ö7œ„ùúÍO ]hÓJI°ýÏý°|m}˜&[I\"Ž GœJç\"to«Fhu­xüÿÅÃA«7;ûÔ£ÓwgüõïÿØ~žA©qˆ·Ž\0E”ÞèáÕ¡ÑÏ6\ri—‡yøÂ¯|c9j…[IÿÁëÿ›Qaábaé÷S–@¨Op¥$øúÈ°ñØNZ&ðôLð	€Ô=YF‡‰»†YTú[ýš¿‹ËD9xì¢ó¢QV—š\Z{sFî­¤ïÑg…Qm\0ƒŽ.€ÈÃ\\#GúGGÑ*Ãw6ÈÜ¶g…µÿÃ_ÂoWN>ñ<ž.î°mÚrðq•?ù÷Ðù>ûå[Øyî°Ã7!áaj“DÒ ¸Ë=HVP¥Q5^\'(§ Ÿ4íJµŠ\Z¯3Ý¸½Õ½âµïÒ‰À°˜ðpÿ¥Ñ	™ûŒ\Z½Cy\0ZŒ…H x¹´¯?ìEZåaîüþQL…IŸŒülèùé80˜*w„C¼aë´e•!cQæìíËá÷kŽ)ˆq!Ìl2ü¬åaåû1`–ýûÕÄ»0òë÷­ò\0÷vœé£ÉRþiÒ:–(¹N‡ D¾@pø¤Wè|¸ä´Þ£à­îC+¬ý«m…M±»«|¾Ö!Qðí„…-¾d)ÍÂEbf*LÙ´ÐUØ|Î7Ã{AD`C‡.yìÆ9˜±m‰Õ©ÿÛrª­Qk¸©Ïw,€Aˆ<¬Ñøn±l!y˜€Ç‡cŸ|OÒ¦å\'w¢Ž%Í©-èÛò%øløÐè´ð0+\râÓˆÁï§\'‘ž5ŒÏ]¢Þu}ƒÛBûúMÌ3…ì‘‡íúë0,FÝ’eàŸuÇš¢.!A¯t,€A8,e0y\rl#ô E6ºó\0xÿ•ñÖþÝE»¿¶ù¼øX©+éF£SŸöÙÞ+z‡µ·[FD­ÇwÃš#ÛÌrÊhÊ¾½úpK¶€›fPim~@DYÐC\06‹ErïÎ‹Ü›;,Ãÿ‘y1:mxÌ|ÀÒÉ¤ÆÖdøÜá%ÿ¦Ð($\"ÂÂ!ÀÇxÜ\nzÈrÖ\nÂX²oå,A­»Z€Î(¼L×åªÂ¤«`\"fºº7¯7Î«c#‡WÃƒ7Ÿ˜egOhôZHBÍöŸw.ÃJ³W£ÖÏ /,$ÍóÈZÂ<‘\0ÄBQ\0a×UäRüÙdèóèN¯<–øà‡åpèïÓæmÚLÅ¥{Ûÿ|…#f À¡<\0=%HÔa¨»ös‹\ZØÚayØwS—\0…Lñ©‰‘Lò÷÷=„´ÜL20Âª†‡4ÓÊDâ^\Z°Å|2 ÄzBR\'¯./ùÅj¼`Â†ypîß¿ÍÛ\n²Ž<Ü7–-âf\Z\n´å0h«BXÆñÂBÆtŠäa%:âŠÏ$.×n(dàUUØ\">9-·åÂ‹Vþ¹hÇcÃÀƒWLƒÒ˜·)âÓv$º:ƒ+férì—ƒ—€>°™|Äxß°	ÝÎ09l§—l-*9¯èI”A¸%Àd(/ºÀ\"ƒsÖ?F€ÎFB–¢4s5áÛôSwæs¤‚}¾º&€ÅEŽ wÐà6?	½eu—,~¶ ¡PÈ`äU¤||¿–õÃ–©K­€Ýs¶t%*ã\\ü§Ùï}ÅóòPàpIg€“BrŸî‘Ë]Â|ë.Y]ž\n´9ÄøX\"ÆâqÊ•‡ujO„,–P@ë‡X­”ñçÝ™y7“¿c°\n£Z_ƒP4QÄÍ½eýwämB>¦óÜµ†B-¦åM\0ˆòË\'Àà¶½`ñ°éVÀUÝŽ±tz©”CWÇª’s~1ÑÀ ÏHÅò0q°|€_¯¦N—‡Õ`y˜2!ôÿ(t¶°|}àÄè×àÝ—ß°\"ÀµÄ»ðêÊw,gQ÷\\ì«ÍVž2i\rç0è5“!æ¹‰›m[÷pI(î§“šOÁrCAÌð¼Ñu•ƒˆ….“6Î·,H*q×…ö•æº¡€1#­FbpX0Qþ\rÇ¿Ç`:GVQœEÞ‹\"^‘>Ð¢¦ãOŸ¾>†´³ž´ëì!øÄR©DQÆ{›O5F-ÈƒRãø2ç@7ŠåaÁÃÚàÊDN‘‡Õ:PXÅ›Ÿñ[ä’PÐ:ÀÞøö§Ðù…Ö¥Ûð$‘ØÝ°bŸÅBLT~ü·±MYBnš‘†<\0ÝÀE¼|{D­A¾@ÝÃ%‹aRh\05Ù@	XÀq‰>;v%ý=^¼jïk!20Ô|™ðëFˆ9¾§ô<ZCâ½˜“C™¡ÏWÓ²æ\r½(Š<Ü[7˜ãÖ<Øi«‡Õ6„Èüàf/ƒŸ/¸{É¸,2å;S‘KÒÙ839ºË\0p—öš$°mì»xÌ¼M—Wx=qÇ¹>l‰ Ý P;œÀ Û	Äk»Ë¤a¾#¼:‡¯¦ýüµ.\\Ìj7|ýüˆ6@.—‡Ã1·\0DR&ˆ·M\\7NÜ,]ª09\'6õÀ•Qlçj ð	Y	ÏCÚ>`@‹Ãdª^ˆ¡ç¶U%yX	0-›7þkÞ¦zµ;í÷ëÓØ~–!_íp\"ˆ\\í7‹åa,fp½1i•‡ÕfÙ=ÍÀÁ¡U–‡ácºÌ©9¥ŠVÜIÙ”qêî‡l© Ç@C\0ƒþ\ZÊ*z¸dðˆöÇØnghmÄ °ÎÐ!´y•åa8ÐlÖ+–s©œ‹÷—æ^NXŽBÉ\\:ò\0ô·\0l&‡2RÞ¾½£b°>À)¥YÑ) 	ôìd^H\Z?RæIò0•¦šÎìo)X¥²Ïÿ÷AþÍäKa¢!€á°(£ÉÃ£]ÃÅ.þµêá’ÎÄÁ0²yï*¯–’>|Íêù\0™\'î¾¥JÈÜÂA»]œáy˜Kã€qm\ZÔø‡KV<…®0½ÝPð0?\\G;ý>›`•HÝÿ÷@]vA¬Ig måKúS4ßI*ðv‰öíÝ´Æ?\\²º€³žÛa?\0?RÆòé¢eÂ7ÎÃ¸¯çZ-\r—²÷R\'ƒR{Å¨ÖÑ¶¨sŒÃdˆØB^XàÐ6qèj‡€¯\Z IÎ‘Xž¾>àëã®îà&‘zÉÄ.d H.uw©+œ¹}	>ÝýùXä’w^lN™LñÆ--y\0§\0uD<êÅ3L6«NV<e;ul)Ÿ¬È`³Ê]ÚT<yÔrAIœHØ|º9‹ÏI1êhÉ`8‡\0ä‘2&oß—›ýÈ÷”¶wüŒÏ\0¨¢)ãxÍ\0¶„_”¬Â¢%0iô	·ŸëÄäsÒQ@ÛÚ÷ÎêØè†åòN¡ËÅõ½êäaÅÐ)\n)]~!Î20	HV°\n«‡!Pñé;²NÞM ÑÓ2Œá¬€ÈÃdMßqm\\\'+2~VÞµ‡\'Q áH\"D–ˆ\'eñÙÔÊ9Õ+5	^{Ë¨Ò^cpY9”ÎHÛz6Îj° ßEà6À«[D<¬&1\'qÇ¹7PÙàq|\\&Ìâwn5ÙB®ÉãH‘elLW„B¾ÂÂ™\'Ð±ÿ¡=SÑî*ë\'M8ç†ÉseÂ¦¾ý›×ÉÃŠìfJùåRWƒRƒ&ˆˆG‚X¯²ßq¹áþOÈÀ+ƒ££hkþœhÔ\rÕÃ‚F´wÚêaµ\0EOycÕæGGoÔf\\F`Ý\nàwVñ;Ób;n-ðsqèGûzvÎ«™,\'…ü^iq€ã\"xÖåa¥öF“ÚP Å7“ty…Ðç}ž*E¯P?DHB{>dpÙ™”î±§X1,Þ-?ãs›,ƒN8‘\0ä1ó^ò.ÖÝŸy˜¹6“ê¬7æêsUiÈAÃÆMÕç¦\Z”ê$½B“î×\\ü®/~Ç5¯M›*‡Œ6>QÒIpf@äa²fAs\\\ZÔ&yUR2¨6ëŒ…ºLT›“õùê\"cçªRpnÔèÅÎnÊuOxéË¼tÅÇÔˆy¯Ît¨&ÈÄ\r½F¸·©iò°ÒÚø)œF2ð#Tƒ‹kt¾:É Pg àš‹›àcjáÉFÆÆ5Z¼LPÚ„×£[Â¹Fa2$<wq{ïÞQN}¸dy(Zy«H”VÜjj}&jªSaQmV§èrSJM²¡P›_ì]—W›K^¶&—ÔþòŒ\\ã]œk\"cûms™Á`ðô+V…j¬\nÕàtÔL\'é±†›íüBÜO?¢ôFœEÃ+iŠŸT£\r¯ZQ›í³[\0*&¿Á-±Gåad€2i\rÙEŽ—;_¨6«R‘ÇŒ¾ç Jjhy}26¸%Ê\Z¹ÄÐµ®6Û§ HfòöìÃ÷‘U.£J0òõ¿•6Ã¯ÆHO+\n©ŠšpD\0,Š¨jm¶ì›ñ»	¬k³s+^ƒáì.€&“‡kËz‹%a>fyUlj²þ®3ä¡f:ÕPR¥!,•4á\nur$±Q-\r]¶o.kdË\Z]ÖÐÏtm¶N&\0ƒ‰â]WI¸ï8—fA‹ŒjR¥°Ç] IFNXŠ±\0…Tjâ	NXEµùI}s¡«ç H&ÆóP¿ìKLX…S•Ú\\ëBªÚç‡fxrEÉÐ\'üÂÉË>»l³û\\9aOÕ›ã¤–¿²¡4¹aiä¬ÎÐO5it®OuxÎQG€çÿ-½€ËÍÅ+\0\0\0\0IEND®B`‚',25),
(3,'MS POWER POINT','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0€\0\0\0€\0\0\0Ã>aË\0\0\'MIDATxÚí]	|SUÖ?Ù—¦MÚ&mÒ5m–‚ìÊêÂîÆâ ‚Š€Ã\"n(*£8#ã‚:#:¸}Š¸Œ¢ \"‹€¬\"e)]Ó4]’6ûòÞûÎ}mB\n\r4É«´Ðÿæ¾ä-÷üï=çÜsî½<èÀ\rÞ¥¾\\Ztà\nG®ptà\nG®ptà\nG®pt L&·y)gß5?1—ú^¸B\Zaž}/þßß3Õ÷ßÈ£Fã¡˜.±baWMwÅÃ%~W!Ÿ—ñciu^…ÝufÆæ_/\\±0Î\Z%”ðù™.Š!î\"òó|4ÓU&tá¨Ç®ÿßÌÓ;¿ÝCÑß¬<\\ä»ÔÏÀ.{”N©@ávâóx]½4+äósñ¡ó±EgcYL8õMžYºïÔÂï‹L¯ì1š—úÙ¸@»&@-v×	«60U³Fói4^†ÎUˆ„yØB»â“uA!ç	y¼lÍŽž™ùêtÅ‡‹w<\\`¶×_êççíŠ\0Æ™£DbvÛ>:ŸÏ#zYÀvÛØÂ»àƒ$òšï¶9Åáêú=£¾ÜuãS}sêì*h÷v@›$@éô±Øz;cç¥™¼Æn»+é¶QÄòKùnŠ®ûË¶£/OW—¥ÄH+³•r£\\$¨ÅC†§öííŠ—Œ\0•3Gñ±¦’°£^æuÅÉówÛì¶yÀã·…ûlD\r€J\"½RÉr	H¬†ñà¡z$AaªÑ“¨ñùf´;Lø,&|¦\ZTQU|àUâÃT£waÁß4!Œ_¥ý‘Óê{æ¾á¢X‘Pï¦™|¼p®ÝGå+ÅÂÎX1	Ø¢[½Ûæ\Z›Jª€AIgÅÉA§BŒPpŽÓÐLˆBž¤ßkÑf©Æz1Ò\05^Š®ÁÃ•Ø(j±qTaòB™±Üª^õ?N	ÂI…WÏ\ZÍC¡ÆâÉ:K…‚®­ší¶Ål·Í“µÆu/	Pð¿TZ Úé= \r	+^ˆ\0a_!d9ÃX	a(†©AUd”	ø•XïŸÑ4³1ýÍ#¬»6ÌÉG½¬E–çaã%Ýv®˜í¶!­\rwÛœâ˜Ù\'ñ•ÂÏˆ“R\"w(uºÂîšZ\\ïX3ú«=t¸¿¿è]/”Ç»>5ñÆeÌ³2ÖÚæ%œó«ËVÐ¡`ŒK†ƒÝ‡Aº&²Ô*ˆç1ÀwZ±Õcµ4¼Ûêðï: Ég‡\r-7ŠŠj¬-üCÂ8¼¾SË¹\ní\r÷+\nÃê	.z·è“DƒS&<Ô3kMK¾%À.–Á–þ·Czj*äää€F£±XÌª‡æ@ìp9X\"0öz ëÌh.âËikx\'d±Y¶YXÒ0v$“ÛÙ@˜F²\\HÅàù©k?Û™Ù[£¬øàxYX½ÀEš®ÊÒceW7®ÿÖ–|ÿJ\0ó÷\'BRj:K€äädJ¥ØL³\ZŸ-òºYR0ka¬f–<¤wñ8Tá±À÷Ñ@tf½ûCn·ÄXãÏfo8wpÑ;Fk]†Ï¥?=møAÔÿ’KPßm<lÑ?öº¤ú.,RRR@.—si†@a\\ë?b_~¸}”)íÍýº%Ä\Z­®ç–\0R_‚~­îèä~H’I²[ù	ÛHÝßy 8»ô†ììlHOO…B|>?ês_üâ8Ö®\0ÏOëE&§ûd··E·ÔtÒbç–\0èãŠ\\­ýüæ¾«¯OKÙúOØöAPÚ\rŒÝ‡@VVddd€R©@õ¹/~qloÿ¼¶Š˜êöŒür÷Ÿ2be¦b«3¬(åE	 òH\0Íƒº.žÑ=cFK~s% <!Ž÷™™™,	âããA(¶þ…‘\0ÖÍoÁ¯¢J«¿½{Ã™j©¸ÊèpSáœî¢Â”	ø|\'EÇ?ÔC?cÑ€./´ä7W¬2%ì\Zð\'HOKcÕ€Z­nðZH\0Ë¢ûª(”|SX¹æþ-‡ÏŒ•UŸªspëÑ²áó n€.~ä·ôû´%¿¹@ñ°iÈ]’šÆ\Z‚III ‘HZßDÔ>yë>úKVüZ´â¹=\'žC˜‹¬Nn	@ ðc´rIÞ¾IC~¦£}W,XOàšÛ 6#;à	Èd²V\'\0CSPóð8\0_ÀÖc^ØwjÑk—éäK…ÃÍí@LÈ—z)&åÔÔ¡;å\"¶UŸ°a_þP ;÷`U@\Zªâ	´6h»j›,9fáîs?9ax/]_ãòrO\0ôÄNŠÒ~;æêµý’T[õ	Û	H-Ó÷s·¬HŒÁ¸¸¸¦® öTuðJàKÓ¢$UY5OOÅ~8àq0Ó6ÿ:eWEí×f·Ï\ZîùZ¦ø|!Å0še×w[:¡“îî–þîrGIrõ\Zz½ž}O ‰+ˆ¨züvX Ö‚(·\'Hz\rq~_à‘ïE@oá1¨ýÇ#øÓ\0Ñ˜±ëöÞrÜlÛVçñÙÃ=_{\0>ßî£ïõè“}ržiéï.w˜cÕphÀxHS* C&xAˆ:š‡­]6`8¨zèV`¼Ác3ðãÕ ñ\'<‘8,\"¸ì€º•‹‚‹˜Ñ_ï`v{”X]ŽpŸ¡EWñyÄæQŽÊPßöÎˆž«™°ð`5¬7ÔƒŸ\'µLb„iè.ü7ÐØòMsn)`Ab2ÄMž’îW·˜Ž­ßBý‡¯>#É¼=?ÞÞCÌç•Û]®pŸ¡Å‚óyŠÎª˜^›oë¿-œß]î@œMËŒ“A’Œ¤‡ñA’ß	|UPõÔ=\rÝ}[B1úNPL˜¬×C|™Û÷kÁöÅê@‘‡bj³ßßÒÉWQé 1çðÐbA¢!(ó1LÚ‰É×ï	øÊKP×m?–Õhè‘\0Z¹”Œœ‚ìê ~öð@õßÖ×Í‚¨\nY¿ëA5ë¯ÀŠ.ôE¨[û&86(²¸½g°¸Ž$¨[aÅZL\0d¶ØCÓº­\ZðmŽ2¦û¥¨ì6l¾ûªê ÖåŒX @!€bèXPa×î:¼j_¶Åµ,ë?T3æcO‚0H\0óÛ/€sÏ–@Ñ	³mÿð¯öŒMWHMÅVWØ³•ZL\0™€/ôÒLò[Ã®ZNl?¸ªÛ,\nÌ6(¬s@\Z \r	 ”A9n\nÄ›\nöíßƒå½W[~2pÜí3!öæIÍÛx¼úŸóÁ}d_ h[yíÆÉMK–KLaÆZL\0ìÚøN­~²Oöü‡{êãuØ,vì7ÕA*\n?I/Aâ=ƒbÄm`ÝðÔº*¼bë×,Xb}—ó!LÏÝÞÒÓ’ï‹«>y`ë‘G‘|5EVgë@‚ž€—aT“:§L~iPîëáüör†ÝKÁÆÒjìþ%‰HŠ!ùþ§!fà¨ûü?`ýîã°Ï)ÎÉÍ3ËÎ·\0™”¹:PòQaÕÓ»žEP‹*€û¤Ð` 	b¯RÇþâæ¾ß…ûÛËÄ€ûæŒ	Qðú8)¨ñ=}þk¬\'`~g)Øwlˆä¤ ~l	Èzl¢\nŠ‚òÇ\0ã	x{ÌÒ…K–.~\r	h1ØÃ‹„%D4åèçê4ä\0Ÿéa@*›°b… Y*„ìßqz6T-ÿ8ìˆè¼’®½!ùÉW›€ÄÊ\ZA‰„Ì’}§ç}|Â°\Zåv áþÃ¹)>_B1Œn÷@¿³#=Œ\0«|O¥l^ë	èd\"èòÆ JHã?æ€ûä‘ˆOúÚ§ LÐ>{M0Ì»‹µüWlûï÷m-«ýÂâ	?@b„|‘‹b´ïè±z°.¾#=¬¿×bË´¹ØYB©\nt{w#$R0<u/x+Ë#>oâ´Ç!ö†[½€ûô1¨X4;‘ÇRæÎ\rÇ·Ø·ÖGh<GË® ÀMÓš…WwZ<%/µ#=¬%VA¤¢!˜¡N€«Vo\0¡@\0%Úù21ƒGƒfæü\0vBåëÏW:3výþAÕNïatÃŽ„kð]?#?mú_ûæ¼Ø¦]ArgÐ<Û:~*7³ž@VF:ô\\ùñúE3FPa{fˆ³r!õ¹`Ýú-T¿óJà8Í0žë¾ÜÓ–ÛÝaÇüÕÔbÙ	*¼¸k’”#?Ù£M¤‡14\r|±„\ZˆR2A”œÂøDà‰ÐFÅc”½¼åÅà,ø¨Z§S²ü hÖWF&†ÎÝºCß‘ÛÅÄ`‹âze\"d,ûoC’	É\\ÿ1Ô+xiÆÜ}ÍŽ¾‰R‘¡Ò~€ ì»óy1ÉrIîã¯Þû‡¥‡±S®àËcA¤K±.ƒ6ûž¦\ng3ryþùw¿e\Zß]‡Á²îCpþ…S\"3m(©fã\0¹ýCÏ¯Ðj†òÓ&\r“í˜†ê\nãº|YèW­ zÍ\n¨ÛðYà8êýâk>Û5U©ØæòDzïaÕ€ÔG3)ûïÈ}z‘>¬P•âT¬…’g±‚`¹¿dIDmÏ0ýçewë<ý\\aö8]‡Ž†.¤‡1>/PhŽ²Z€²Ô²ŸIÏDÕ[€¶Öþ&ÇÉ÷XÒÐðcb!{Õw\rÏ‰÷]¹j	Xwn\\óL½óàëöÝš#5•ØÂê1 ËÅd¢ÈÚ‘=×öÒÄq›F¢jÿB×G­\r¨ðˆ}‘ë¸\nCù‹svFd;s>€ßÐ¬tx wàµ?ñ>ˆ×¥‚P‡½VL°Õ0KÎý‚>3H\0B2ATŒ=Ÿ\0†¥O‚ýðžÀew-›îÛòÛÔd™ØTáðDdl„]³>Oèc@óÒÀ.KÇf%qšFôyúâU ëÔ«S^àbØíÃ«ó99Ý™zX¬\'*CœHÀ¦‡‘Œ\\‚Ø8ÄÅƒ€ä*üã;¶r*¡ásL[Æc\'šž?\\òìLpm.­ùtÎöcsR’êb«ë!€=E\'<Ø=ýÑ9=2ŸáÚHžñ$(‡Žáò”¡•jÄnµ~ûÿ¢>Y1d©Räv< ^\"bG[vLƒƒ/’<¢\Z};hîÓ$Ã˜|çÌœ	à«­\n­=YñÖ¢}§ \n¨Ev€ lá‰ð®ðV•CSÆ/¿®ë;‘œãBˆ¿yhî~°eéÕ~€ò·Æ„ºÔÌŽ™±U‰’RÎssy«P8w\"ë1D7EÃF4É¢Q±RH@ˆüˆ*\'iò#ãMã\0\r\'§fÕûÿ-?\\üÂÊ#¥¯êäb3ª€Ö_\"ÆŸ§È‰“÷úò¦^œ§‡)z‚Ôy/…$\0íõ€§´ÜøòKÁm(OyxM@“ 	¯¡ÒI‹¡-¡¾c¨®»)$	È÷ÊQ\rØìŒúÞ¿G(ÅBvé’(áóÃ6_ˆ 3Ñ÷—çöhRN9lprÆM¾ºô`Ñ¼OOW£Z®¯qûþ8 !(CO mïíöŠøÜ¦‡‰’S çŸŸ„$€«ø$>q/ðÈDÌ=2ZT+ñÃÆ† ú×?®‡Š·_Œzàh{…™=!@@FVó|™:¯úø¢¦ó=&œ~d~áì|€§vŸ˜¾Í`þ¼.Â8\0AD@Æ‰½£[wSïoõq2NÓÃHbdî»›ØÁæ@»œpüÏ£ˆÅØâsC«óŠ¯€/‘6{Üc,ƒSÞd	(ùC5V0»½lfUAŒHv <\ZRzö¼àD¯åÌ_ÿŒ÷(g¦üpdìIðR¶ˆë;’I|!ö\0Éÿ’»|hJ·éa(ØœW>izóÁFÒeŸšs;xªŒáœ2ž\\\n±}7m†ãÓ†£z	;§²	NÕ9 Èêd=2,+¢¼Â©b²ž[	ò¼^ç±¢Š*yù	ð‹Œ8†“6Råò2:<û²@ÖP?rUÆü™ù©EzžPHd¶„æƒ„\0%/Í+ºpá yÒlÐŒ»·Y5@ÎY0{øêj£ºo2p¨Ú\nºqC~ Ú‚z1y=A¿pe³êÏ¼å(ë%è)¨ëö÷ÀÓ¢Q€ \"Á‰‘ÖØ¨nËNšü\\¿ÎÓÃ’î˜IþRXÆÿ[5ë×†uN5\n_{×ìÐx`øÎ¦ZE‡‚ËkAÛè\n&H„è\n¶Ð@If?ÿ6ÈsòÏ?Ff­[•­ù¦¾ßç»{‘8€Éé(@±à±ùñŠAïö}4çiÊA# }Îâ†`Íæ¯ÀðöËÐr«ºisA}ãí!	ðû´h_D7*H\\ù\r¥5¬˜®°ibXO-²Ôc\'ƒÝßPÙÀkVBõ7Šì^ªôº¯÷\rB[ƒGh¨™† ›¶m\\¿\\¯&Íì_þ $ì‡áÔ‚™pxHôr—}bur³ÇÉøÁ1TÑÆ¶ÈÝþh07™%€	 m\'Óµd?»,ä¤BÐ²•Ïƒù§ïe(ôßÆm8t#ÚU¥6wÄÆK4=€„b@·ñÖÞ? Ó9M#Öz÷÷6‡œRå«·ÀÑé7¶,F€ßI›5‡	éš·ýJÞXtñs]Øì¯®›—B@ÉrñÅ’™¾3äüí\rv8ôy8óò“P¿ÿl~á^SÝ³~:vV&®ªpz\"Þ¾&bÈ|‘›¦µ+†ä­îŸ¬ä6=ŒDÕÞü\n$I)!êƒ£3nb‰p!ÄvïÚ‰3ÙAÞ‚Îüc.ÔÚÍÉ­XìPnw³ž\0qÉL¡Pž€\"¿7èŸx‰\r\Z]x\'ž™Ž“GEÛ*ÌŸÏÛuòTTeˆ0D1Øô0ŠÖ<Ñ+sñÄNZnÓÃð³Ÿ~\r”¡Ü6â\n.|\0lÇ±aSžXbM\nHÓô MÕƒUˆ¢{_*.:¤ì8}\næßÇÙ­—ÛÜpÌbc…OâqÍyxOI·Þ:6ð/40èyx;ä/ZWTõîâý…óSå’š»;âqìhl\0¾›fâïí¬þXŒ£9WsH2’ÇÜÒh«?ø307HÓs@œ¤k¢?[ºLV>ñ4¶¬3œÝw=öÆ?WÖvÍè	H@%\n\ná}+ºö„Ô©¼S~‹ï“<ïá©#Øá`Ñ[¿—¿òÖ±òµQÄØºŠô‡²6<×[;òÍkó>åzÍ\0õ°±ñÀÓ¨¤@¶@D ƒ?EËŸƒÚ#>Gs éa›ÊjØ	\"¬+(€4&Tý®õÈÛ@Ñ­OÓŒ¥€$ˆš<”øoÅ‘Ò¿~|ªrUŒ_i ¼»h$=L-å~=ºç^|(NÓÃy=¡Ëóoq¿è¶&ŸÝ†Â_–½;¸ODQì%‚J—»vƒ¬~!±{ovh;Ògñ —rxÆÍÁ³†™%Šfo1Ô®­óPQí^Õã“ô0/Í¤lÓ{§\\Àmz˜0V	=ßÛÈØ˜;Ybmûÿ üÃà­nÐçW‚âc@Ú­/g«‡9ŠNÂÑ¹w5YèÇo?aqlŒ&@Uí¢!(FCPûöõ]×^•ÃizXo$€\r¹~|vˆ…î8sÌ¿ü5[¿w•±5ƒÏ^\Z_•ÝÕ÷–\0dáóVuè¡,z¤IzÀôŸŽ\rEÝ¿·Úåjô*ZÀ®ö·¾YKoLKä6=…˜ÿ·!]¥}\'ð7åC+¹œ¥…à,/WYûî,)Êioè>ÿ yµ™ù`2&ôêaa¢\Z‰[¸laP€¡\'m>ÚÝðH‚¨2[£íÈ:Â	ÎÕ=:«k\nÇ«‡ñ@ÿSL†o›~íÎMP³s3\nû¸*ËYc©AOþ³Bš#A¦Q“ÙeäI/˜˜\"ÑÅÝ½\në>†’wÿx&44mC¿=ØK%–™\\‘Ç\0¢™(BÒÃ†hUã_¼&‡óô0í˜» óÏ7¯?Éðèg«¡lÍ¿¹¼$\' ÄR(\Zÿ ¤¥¦² ë“…¤#±ÑK?Z	†Ïß\r”¹(Ê0bý¡‰Q% â8\0AÔ#éaúXi¯÷oÈç<=LÕ{ äýmYÈŠ«Fîä+OsyIn@FÇÎM†ž]GX§ÓE¸¥L\nW<¦Í_ÊLNÏï6ý6Š‚Êì‘Ç¢ªÚi›nî¹WÈqz˜D£…>o²â%§áÐCMÒ¤Ú°wºáNPäö`	Š=ALLLdž\0àøó vÏÖ@Ñoµ¶íì811Y&®2F ˆš\0hŠ}4£ûhXþº…ô*Në+¬ÿÇÛ@ “7{˜ö¸aÏ¤kÙA¶¢©M½‡ ÏµEbcc#òHpä¯ÓÁzìì?WÖ}5ÿ—Ó³ÕQu¥ËÕÃGM€†‰\"Lò’~ÙË‡h•œ¦‡‘‰\"½—}1Ù¹!+çÀìñàª(åò²œ &#\\×Œ„œ¼<Ðçt•JÅà¼AéšyFfcYí{K?•\"×”Ú=Qå³s x|Å¨gäéæOé¬å<=¬ËÜ¿CÒÐ[BVÎ±%s¡ö—m\\^’˜n8Rk­B©ñJHHH\0Y<zq*ÆÆá{<ˆ”ñl$Pˆeb•\Z¤º4\'hÎ›²çž¡à;»Î\0ó\'¯¾}¼âE­Ld®pz/-È:Âè–¨nÉHœüDtÎÓÃÒ\'Î„Ì{hV’Ê)zïu(ûâ}./É	HzØÎÊzH’ŠØÐ0É5›ØØ\'à³¤Ž¿²¦7õz(—vMºŽçð?öªc†g>)¬zS)Dð_=jô°.JÙ •ƒ»|ÏyPhÐpè:iHÊ¸ñK8±|1——ä„œ[ˆ—Ù°0Éàµ“5õHŸp_µà®1Áž)#›¬ôêo¥n5XÖÔ{£‹pE\09¾ôßŒºŠóÕÃb2r ïŠÏC ¾àœ{Op¾|›\0¹ÒP0êjPcO ½\0ÈjczRnj:ðe/:	ûœ \0Iò—Â;·86X£Œøï3j4¤‡1ºÏ†çÿ/q›&ÃÏ~~ˆ-Ù¼¨wbÙñk\rUÍ@#—ù‚®`·§_Í aMÊÌ‡öÀ¯ÏÌ\n^ypçÉaåv÷/u^*ê¹íœ\0Lä¡iíKWg¯î«VpšF<þ«×ƒ<%£ùãØÕîºwx¢Léæ\ZD1Ÿªs‚A’¢eg\n	ƒ\'öœ÷}^ù\0”ùM\'…·|Ç_]ø>~ž¶­ /ÖwÑéz…N ðnŠÑ<œŸ²ø6½šóÕÃº/øh=¯Šý± COÏYö¥Áš’ö7ƒN)JÄPn vðZ-à±Ô‚ÏZÞú†¿½–\ZèóÚ‡çÒ¯×À©·^”`Ok³ñh¯X‘ ´*Ê8\0\'‚ò§‡Ý‘¥ž>;/…óô°œiBÆ\ry{^¬,GyØŠO£¬ˆ}Õ?Ì&y´5x”‰`7‹Ý\\’Œ’ X,j²ix“qsÔ;üÁPüÉe.Š®»éÈ\04*U._Tq\0ÿõ£†€ûÀ‹ë‘ ùò5Ùœ¯FZñ™‰°=ØbZeÙ˜V\0#BåÄÇ!%55¢Í%	Ž£‡cØðß@YµË{üž­ÇG Z1•;<ÑMf…>nL¢D˜û×åîmñŒË<††Êñ€:»s (Îæ’„\0¿=?L?ŸÝ âˆÙ¾ýñ=…“’¤\"S¥ËU€½G®Õ€ÔÇ0)_Ïß!òu­Q¡íØ·×Ü0W]Qz!Àþ\'¦åè@Ù/UÖ¯(ž/V¡\nˆ:ÂÐ£!¨ýgÿìµù*yÇæ’Ð Ûë{ß\0ÂþÃ#J#øyÆ´yÎnýƒÁòÁ+GÊž@Pƒ* ºum€[ ¤F3¯{ÚÒa)ÊŽÍ%aÏé	ÔÐñ ÏÔƒ¾q›ù–¦‡l½sz\ru¢OWýëýS¦%ÉR‘ÙèŠ.@À]€ž€‹fîÎÖÌ™Ò)i—çnÏ°\n$P¨J…ô”ÈÒëA£K™R’\rˆU	l0H§bçCž«\ZÈ‚›Çöc7ŒnƒÂ_ðé™ª•J‘ ®ÖCE÷Æ™üéaý5±ãÿÖ+ãŽÍ%à¥hØaªµD:¹TbaÃL¡ÆeáH+\'£œÙwÝ¦<Ô„îÚjøqâuMâ\0+U<¼ÕX÷¡•ƒ8\0§BòxŠ…¤×ŠÙ›Ka›±\">;$7³|\\î¬y5aZ÷ÖVr\Z¶ßwKð,ifÁâ»NÔ9¿³úèˆ†\n§BBCP†RÚ‡æíE–wl.Ùˆ}Õ62n	:™±\'²\'M«¾ûÜÅ~Ó„&eµ‡÷Âî¿L\rþ.3oï™‘evÏîz/Ñç‚SøÓÃÞ˜³.-FÌmzX;Æ1‹êÐe\'1TD¦ÖŸ7ŽÕïïoBÒ€ë›”¶~‡–Ìƒà=‚Ú]ØÏé£Uº¢pJ\0zØÓ=Ò–£-Ð±¹d#Šm.(wx-wH’‰ÈÖ;M× i¼ò3På6m3E_}GW,	|F{Á}çÖW)„üÒ*·/â…¡‚Á­\nhðÔSr4óïÐ«9Ok¯¨—Ä€Q×	Ôb$	ºìâ$ÍËçvíñÀð„˜”ô³?Bãðä‡oBÁûoŠ¼4]uÇÖ‚~q\"Ñì¡¢Žp* ª6ªQ)ª{îª]ÆõùÛ+¨%Ø\'=ÊN!CÂ\Z¦q¦”ËÅÆ7¤ê$àmzÁf/Š¿Y(«óøNMÝqê­LdÂ%ê8\0çñx±9qÒA/÷Íä|õ°ö\n»ûú{Ÿ]Z:K\0­V{Ñ ›\rüüãhœÝxò”Õ¹ç/{‹ÿ”$š*]¾¨ã\0œˆ¤‡‰ø<ý‡×vîØ\\Ò¦uüýØ%Ÿ%@JJ\nÈåò‹`×÷AõÁ³k¬±·ø×²é*± ªÖÃÍdî{\0>OB3Œnõ œÍèóæ´F}¶GØ®Ï.UKà\n](&ÀÏÖ3\'E;«¬k^=jx\\+U—G™îç@CPäaíÂi«{&Ätl.ÙgÏ! ¹îv¦Pff&ºPL€`ÃíCÀc®	}SZûÆ»§ª¡\n0£\nh›@WPàAO`Fç¤¿ßœ¦êØ\\²}>ðnº›~VcPH\"Ñ•€öyaý­}:»óQaõâÏ‹k_O,5ÄZÃà#âÇ¥ÇOŸš£á<=¬½‚Š×€÷ÎG #=\r\r«Õê®à®3Ãwãú\r3ïž2=¶ÕXÿ>–Ô×ûè¶I\0ACj[\\¾R>ò¹^imbsÉ¶\0’æ˜:ÒÒ3 ;\'’× h.ÅÍVZ\'`÷OðŸbéQÃ”ßÌŽ¯mÅ×æ\Zè\nÆÄK¹oöÏÚ‹;ÒÃ\Zñ‹Å\rŠØXÈÔiYO@Ÿ\0R|‰É>‰±J(Øñ\01É4”ÂÎù3›Äž9XzS©Ã³Ãî£9‰´\nP\rH)†IypÎ© #=ÌÃfž;Y&‚D‰ÌM6ÂôïpJæB°i•Mg;1Oì/éoóRG«Ü>6;„Àu9>˜ØM3Úç{§}œ\'ÔzUÚ~@„{Úê³ÇÇÆÈL¡–î(‚®µcÆ®3}Å/ÅI€ •T\0)\0ÍÃ]’—^›Û‘ÖƒÃÃ”Ø= ‘\nydÖðyA¡Ð`NÖ»v.8T6Y.äW \rÀI€ µz\06=lBFüœ‰úÄmz›ù?H€êÿ–˜·ëd\"ª…F\"Tj¤¢8$BªM’!à›øe^t¸ü36Ï6™€Wí¤N†	ZE0$ßß”}bÆÏË×q¾zX{…ƒ¢kïû¹Lq\"Ã¸$…Ž´b$ó…|ž(A,ˆQ±ØÊUj$‡B$P ÉàÛUeÝZë¡~Çï–	y`õ2ÀÉ A«	oT‘*÷z¹OzGz˜(¸9ûŠ‡Uº|ÐÐÈ‰\'l|4ó™Ôiídc~°à8ëþZQ0¨Øô°÷e]±éa$í3°38ÃÐè¾_8Zqï›{Ö\r,9Ìñò€ôÄè#@^àxÌV#€ˆÇ“5^é›¾.EvÙ§‡„â¥g•Ûk28¼¥è³Mnoy™ÝS^áô–8|t)öÝ%¨ó«ìçr¼ w^Ðg¦ñÅY·ßÜE9Gã:ÂÉsó´Ëû%ÊÛ}z˜BoÃ¾ÄÀ >7—Ú=Ø—œC™Ãc¨tzK+\\Þ\ZÔÛD¸TcwMZ-y\'­˜Ìð¨5èñ6±¶]« qÊ¸zbfüüqéñµO ¸ÛöÑŒýöª2‡·¬Üé©0¡°Ñ+¯ty\rd~ü.Å#[ø58ÔË{Î‹”ùàR.f„Ö4yØTC“cï™ÑIÓÖÒÃÎ¶f`·~¯G+¾²2´Ñé5°5ãË„$ -—jÍ$<w!!áRA/ºñåïÊÛZU($=L¯ZÔ#õ’¤‡·fša¨:/…­™ÕÇ(ìò‡Û€­º¬Æí«C	ùB´f¿ÀÏmÉD¸~aŸ+ä6\'èPh]ô0OÿVÿŒý<O\Zý›E ²ÉÃxhÆŽº¸uq)\nÛHtt¹ÃKô´ÑM1dÌÛ‚ízµ‹Ö	Z¹\0	Ö–nY¿ŒÍ*‘ ªô°&Fša6]SJ/—Ï€]v9\Zd“ÛW†ú¹ûk/ï¬Ö\\‹öëâ`AŸÛm·»Ö	Z•\0hŠÐ-Ò>•¯]ÝM%kIzX“ÖŒ¿ua÷lB]\\†­¹¢Êí+G¡—£ÀÉx¸­ÑkIkÖÍä†¦­¹U\\¬ö€Ö&\0›voVâßGéâ‚ÓÃÿ¦odÎœÓÇXÊZ3éª+Pà#vá(èjlÆD¨¤5û[í¹ºù\\!·ès}Y·æHÐªó€ïa þæ”¸éè.¶xˆÖ ‰ñEZ3¾Ì\r.•/—êbº¹CÐ-D«€,ŒÊç‘™Ñ<=6ù7Í(¦…­¹Ý¹Tí­îš	Ð$ãø\'y‘@G°vn·M„{Ea—\Z„oN$ýUgƒÁBö`‚¾hK£s¸è ÀŽ\\áø=§q#½\0\0\0\0IEND®B`‚',25);

/*Table structure for table `tb_user` */

DROP TABLE IF EXISTS `tb_user`;

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `role` enum('Admin','Super Admin') NOT NULL,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `tb_user` */

insert  into `tb_user`(`id_user`,`username`,`pass`,`role`,`nama`) values 
(1,'admin','$2y$10$qg3tutFl3jiKDyohnp7tHuHpO6x/A0q3b4KMs7c0MV8pIL98ashq6','Super Admin','Super Admin'),
(6,'adminarie','$2y$10$0wkqc6mitxBI1bfgXxVfXuToyuYIQE9sONdJGxYoL.FzxNjvTgFlu','Admin','Arie Sapta'),
(7,'adminarie2','$2y$10$wZY8tMl0XELjVTh7gVIQBO0TfSlSRIKJBGBegnKkPl4edJL45Dpni','Admin','Arie2'),
(8,'ariefujiwara','$2y$10$biqQpYp91vGxsU5HfLsNo.LFkQnO9Na//PR.ywgGxutQ4v8PBpnzi','Super Admin','Arie Sapta');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
