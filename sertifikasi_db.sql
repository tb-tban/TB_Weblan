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
(1,'MS WORD','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0�\0\0\0�>a�\0\0+IDATx��]|T�����KБf�)\"H��\"� *������QD��H�Hｷ\0!!�^.����{%��\\5�|�<r��}�vfggvfgYP��\Z�ڮ@ju𐣎r�1�C�:x�Q�\09��!G8�\'�Y-�kKK�����x\nu`Ơ);Ykg<�����0L�ѠK�	$\r�zmC`��s8��,6\'*3�x�Re��c�> ��e���esx���8���7`���� �%����N̙m�#sl�~d�����x���čRW�Dn���,67_��ˏ�s�\n\rPS{0����I�Ճ��^(��w��k8yk��ݙmc��D�@�\0{hC|�$r�����wfR/�Yz~�·�9)E�����}�\0�\'m�9�h�A��]����6�����B۞��(\n2n��׷�h�aX!2�}�ܓ��č2��#=��l\'hh�b\'ŶGa�kOm�nj@t�;\"��ty`L6�/�EI�\\�EOCm����5����?AF��lnC�\r��m�m�m`��4\r0��,��PRE(�~�:�A�����8e�Ր̀1Ϡ�dsx�l,!�`�e#cg1�1�1\n��Rd�Z�\"^oؾ���`����m\'�u�Fhb����^�u����F�?�p��y���\"D�@�����_�j��+���C�#���@�1;E���#������R������I�Zi�mg!QeX��|Զ\r�8V\'�O\r�Ԋî#��s� A�,6%>�3��R/����2�X�xBy����_��9G?3�.b��@䴚H\"M����an�5���u���y�%I�!��`3{B��6��i@�h<�h��,�^�^CQ�MP���oH�����l�(liQU30�V�u�a��o�J2�uW���4�H��=�`ƴ|B��1�u	��~Ζ��_Pm#A\n��p\0�T\Z#(KtP��ѿE�Pi����z#�H�r�VcrR�.ȸv��\0��7�X�Є�����O�l�r�V�>�����	���Ճ��@���T/(i*�wB�R��K��9\n��P�G12F���(�R�\\���u�z=���3&��H��X�R��������H���))P#A�>�\"�Op�N/~��#�?`a�����!����A(V�j��_l��2���BQ!3��W�0I��\'�!�@m�6�扭�OzA� ?/�ѹw�<��(p1}�]w\n�9Am5��B�ǣ3!>RA ,�A��ip�����$�UZϥ_=��#k���D�e%{�P��V��ؕ;�RE����>A��\\h-���8����T\nl6���k\0a�׾9مV	��>�e��-s&��y��4�2\0�\'�������\\ۢ����>A����XQQQ������k�`��=TG0��������_:K$�/-����	9�&�Y�7�ŵ�?ڑ{�IU�%^��є	\np�\\�?�~���$��w/�x��_8\\~�F��Y`sl�\0�����w{�˪��6��:�X�t�����]P\n���,6ˢ32�6�~5���U�R���\Z��bsHl��?�i�v�}�\n�W�\06��A�r @�\0�^Wo�+a���]�����.̼��N]\\�lyՖ��I�2��__|�����}]�	�����&a�+d �A.�B&\0��R$\".�8\'I͒��H=u->��DY,�o��.%��5��g���gs��Ѩ�=~�._Rk-~�!��i0굀�7�d�m�&%��Ņ��@$���GJ��$r��#�S�\n@��ebӈ\\*�+h�ɻ0g�9�w|�q�ϣZ }��f:����|TC:�v�_xö����q3�B�2��P�@l��c*N�X������o��_�Rg�����q�0o|{��=���o���W���c,���G�\"Y�Z��q�=����G��7+�Q����AGq^*(�o��\'�̘\"ȨS� �]6�#|�s,��\Z�ڕl=gЩӷ��$�(2�<� @	����o�ܸ^�\\g	��Q@N����>!���6`�˫*$*�PQb	�jZ>��0���.��G�ա8��Ft��g���tξ�C�d����>����8e���=�0�!^x�8��|B�ȕB��hr��L�I�S��٩c��Mt�?>~��UA`��Sp�|��\\���,��J�l��q��,W*�z�ӈ�{���A!��FyL}����)d�No�r�:\Z��+.����#hr!k�w�����m,��u��\0�|�%�Y	�u���ck��&��g�����It��8��!�׸����Om7��\0��+�Ѿ����A\"��8P�ۘ���u(9� -0G�3{/�ɲ�����������rpp�`y�C`s�|45B;�\\�I�oR[�~��U�ZƉ�LN!�L�5�a���v��*�L�us/��m��\'8��0Ë�p�>�e���\'\r��އH�/���C����^s\n�0x�ߠ3X��0W�/����Usq(@���!a�-���/L�Ozf�3�>��j�F�$N!�9�H����\r�\\��˸�����XQ�+-��9<��Mzo����A��g������8�����y�\'��]���	lK�,sr×/��9��N]�t�L�j�L ��k�v�W[����\"�Y���8d�PPȥ�+P�L���!8VNy��Qf�t+��a��#��^9�Ien�>�F�r��N2\0_���b����I�� \r�y���dJX(�6O@�k������x��#P;_&!�\0�F!�\0_�4<��M8wf�v�������>�ӨΗf:����a�0�1���_v\n$�u�ad�H��kK�l �B}ɥ!�:��u�\'t�����~�r��]}��zF���Q�Xl�-�2[���(��%�Ϩ׆�\Z4u�d�\"<�4-k��#=4\"PJ\'a\"�e��X\n�f�$Y�()��<�r��f��� a_K>�!����`�V�\n�m�`<P\'��1whK��7]��s�D�ߙ���\r���]FO�j����B\"�n1!rJt?���^���vҥJ�fBQ�\r�N�z�J!S���-ʛ���/��!�TX�E_ʐeE0�p�yX��u�9��v�<��P�YZ���\\U��g�PĴ�7*��3�bs/��C�&��ojnW\\���F�H�&p�R��O�<i �@�R(K���\Z��v;�/�ƿ_]=�|��ُ^o[�Y�N���)�s�������.��E�N���żrEx��M]�����%�B,��mU���}�a�|ቆ0�WC�P����I*��b�Vj\ZO��,�L:��_����d��3]>������\'�ȈB����\0\0S���Ay��v_7�E��?K]��Rn�	H��Eb������q�оY8D�Ȩ��#���vå�������C�N�vO�R�;4�K�3�Y)ԋ\n��d��H$�Vd�2�`d@�L#F�Ϫp����+)y�s���W����X�\09%��p�B�h����\\����L�۾��^N\Zi�șu(daҋm�[�h���������P9�����Ь��2@DD](��� �n/N�\n��Vk�I��k��]?����ܤ�-A�-�6����	Ip8<��όI���b;\n�/2A���\r�\Z��j;h�4��K�:�d3�kj,뫷:A��`�?o;|f/?�NAj�\"\\m%t:���r�G�B�L\\%6B����:���Q	�G3���hx��بǘY�	j#�L���DbG�)�\"�t&a�Ӷ@zn�Y�yL�	Q~U^C\Zj��|��\Z����^�k����\\�_7�GQ/@��!&&�d��\'�B�M<`�::DX�뇖OJ9����|q����?b\0�-�_l����%=3�FK\0[��:C�Đ*Ŷ������H����}!�OR�u9%0l�&005�5�RT.��i���׾�K��\0Z� 22��)D|�Bv~	��Ѷ\r�˻���|d�^]�r�:��,�?>1-4��ޯ����8f�ީJ1_�TÐ�(wW�l�}��A����F8}�A�{:���6�B������}�l����e��8���		���R\Z�)�i�_U/���\n`��D)��Ȝ�k�`e���z���!�R\\��͕J��y�ٙ������h����N\Z�����w�-�4�گ:�/������Ye�H��Fd���\0ޚ�\\��� ��a�	% �O�,�I��\"�Z6�/��B�\0�3=O�Ghƒs�\"�;�ŉ�0q�n��aN��ڵ�(����\0\0.2\0��y�\"��Þ�ㆶ��x��f\"�vU;�[����8�\0���~��������+g�����h=�97���r�y�H�8��h���в�~��?\0�I�Ä��,>�\\�;�ނ/?d{�����[\Z�ګ�\0����5���F�!4i�כľ���	x�����;I��<m3�dV=��H�o�us�6�߮8j���\n���\'얥���wV�gP�q\rtj%�H��d�\'K�n���}!:��_��q��+0���c�1���ets�8w4Ů�\\d\0>�a�Mz������Q����\ZW����?�9U��]ZE��#�;l_�jt0{2����V\rB����҇(\\�|���T�#P�݁��t@������ͳ����E���_�~	۶Y������*AS<c߯�$�E�\ZU��Bʞ��K�b}fRt�~�e�\0,�ѿ��f�R�������8�0�[\"�ܪrN��4���/XsV�\\鷮��Fu�{ߕ۹�\Z,\'��-�G�/0|�YB0�f]@u�X����<g�yemD�cΊc�a�5�9���c��By`��� Zg�nbsY(|Ct��i���a�\'���?\Z[%���qn��d���:��ٸ���(i��g��V��UZ�3�s�=���z�=y>��}N��D���Ǹ��q��Cf:�_��N�t�_C-�g�# ��K����g\r��೅�`��k;*���\\��`�, u\0����<W�\Z�LӮŀ�[����co�*{Å�0��+�K�\'A��+�s�l*]\\��8����������&݈>�ॾ���cͮK0o�	k*6g\Z�v,��6{X��`��k�cDB^�����8u%���̻sv����}�/��ָ����%�\"(�#��K?�d�#/3wB/h�\\��gl�������Ԥ�4�&��XPcA�O�ag���i\rOwkh��ם���.8�&�)Ԓ�Ę �f3)���]k�0�7�.�����������t��\0�H\0���Iþ���8֩E$L{�K���_{��w��k�D9���~��{�F_��<�����Aoh\\/�R�D�~a�z�᳼����C����}�����t�]�$2�:�ϣ��H����f�����6/����L~����P�1]H���-R�7v*<��}��A(���\n��AW����A��~����#.w-i���<Z���[L���0�王0o�q�w���C�ƕ�	��n��W2�<�@�&>�F���o/��.�x�ؚi)�7~�+\n�%�%�*GWods��AX��ia�w:<l��\rQ?Z����l�{�z�D�n�7�ΪU����ߠ����3��#�T&Y�9��U��1�dk��z�~v�=l��2i�$b��R\n1��~~�g#�b��+�U3���w2�XL����Z`\0�m4h�M����Lg�	x�fֳt����)6j��2��	Q��PM��:g����G`������P��گ��`i���z�]%\Z�,+.h!�}�#L�@Xh0J-)(�J�y� q�7��UC&�i;/�\\޵ू���5*�8��8��dc���M{Op)<��gZÐ�M���}�	.�ʡ��q�����v	�����\\��̣������b79-^D]��A�IEm���E�~{�ˊc4@��c���HdJ\Z���D�A�o@.�2��\r(�wm	h)��Brm��2��M_�Q��5hK\\Zb-ɭ��\\	_���ٙ�*��B����8FV��4֖�������D��f|�J�!\rޜ�\n2�,����׺bC�ٽvܬ��Tٰ}��v�|5��&���FJ̹u�΀�0���K�CMM�����г�r���m�p��r�rf��v��³ZU�ˎ �3]BƨK\Z>�\0����a�W������;��F1<ཕt��6ʔѝ�J��o.�M�J)�\'����Ǟ7�e��\'G/��;����\\p��~D��bekSW�l^����\'�u��r?m�a���ۦ��_5�9�\ZU�KBl�:�����I+eAq.ek�fۂ���r�~�!�s�Ex�w3xcp噻�z�YR�M����@���Je�z�`��=�>s�˴���ɩ8����4\0�R?��D͖�t錧�^D�rJ:����G�u�a��В1-pxI���\"pw����q���$����ٶ_��Fv�w�[i������C�`H��������V\0�����1&�l�$�t3\Z�����M�a��-0�\01�E*��\0|_(�q�9�t4m��)��&�Xb�w�C��vE�W���u�)�V��^@���Y.;�������h�g\\d�~5��U�Iq��kݪ�o���:\'��*�~��?YW�qC��}�<*ZBpt����{.;|�=������t\"�d���J)�����\"��N���Ba�\Z\n�{��:yd�r>\r:1�hl�OA&�T+�ϞZ7��@꟥q�@���hEd��]_w(<��y�f�sU�e\0����bhհ����ӷ�9�\r��̣0���k���?�~�?����UA��{����\"3�AAAt�HU��]#`O*M�:��Sa��]��Η(�����c\0Z\0�#��>Ҭ��������nc�M��H�ABf�*�l���\\�׮������ڵ2�4��O���۹�5\nVfTDG����ڊa^��.�Ȳ��O=���~-�Mq�[����\08��6��9��p\\�F&���3�c�S��l�[O������Yh:vl�`y�y{	�g�6�N��h�T�������+PױFJ1Y���|h�$�4 O���}	����m�BypSwʚ�B{x�{�D6!��-g���M�p�ჾ�����+�j�Nv��}�@�O���a�{����eK;���3�f�%~�8�UYO0\0�����_���l�V���`XID��\rE\Zg��킭�V{�ʙC &̯��2r����%?�:4��@��ng#��n���M\\�+��}�qi�O��Е�P���@��D<�oRX�^ne�^�w{;%�\'|�����^7�ʄ;�(�_Ϡ:�\'���\nt�8Dq�1��X�\"B�O.�D�Z~U���dGe��ɱ��C�k�<����ۧW�*���=��Hx����nxl�sngk�����w�Ti��O���U�ud��/�D\\}�\n�6����n�P�\Z(H=����\\�)i�c���ܿ\\DC��t���\'�C�z�e��Ʌ�&�(�\0Wv��8���m��B,���Ud��/�]�^�nu�L$��χ@BL��2�EvFn�����ٞͪ6��X�\n�eܚ�}���\'�+�*k�Ɂ��V��41c?\Z��wmT�������m�g1���~\\��:�ר��ة�����067����N��U�>a�k�ʹ�u���d5!:����0���;��`���5��(�����a&09��ZFfDg��:�*?�m;x>���6����/[����\n�{�\nxN��a�Lۉ��v�0����F��o��@K�Z�<�g�z,]�9�?$5��ߋ�Ր�Q\07P��Nχ[w��\0df�#�J)���P��@�����������0����Ri�߶30{I�<�s��4��Ewt%nW�#@�Ì]HB�7��\0O�9r@x��Ǫ��6�3�7���#*TA���J˃��Rs?g39�.�l`�`�ʁ�����!Y�g���<���}�ZBe��i��ڣ�p��l�̓�\'>��d�J���\0x�8���V������ad��y/��o�5i�+����W�*H�B�0�]��Q\r<���R*P�B^a	�p\"~� �&��Q�J#����[A,�k��ή�ڕ/\r��(�\\^�=\0�،A�N�:*�E?�d#?et7Эl�!�II/@�8��={5N^N�O6mv�R6�|<����A��dŜ�k��>�a+�NLW1P��z���o�%~YZU�[~\0�L��)\rcɥ��z���ǲ�E��cͣ���|��b�$~ ���KB۳ Qic{Щ`�\0�)���t�������e��2.o��w�h�P��+-t�@౮C��PLl�g�1|���%����fu\nՔ=���N\\\n�P���&����-y��w�\0�c\0�fk>�����z�]�+h#�V\rC]�F���Q�xG�2�����zj�\'&?@��\0tKb	t{k�$ �nsI3:6C�!��Sș�a$�h��@c�w$����Nϼ�cZ8�=zr��KF�:KݲnsI3bXХ�/4H��F\r 88�N�CE�@�*:��o{�I;��ݼ[���-2hT����7��vh�^S�<µ�1�L��Ada���R���#���z�M�\r\"ʵڝ����B�y�֑e/+3��5hK�Zb��D����h@L��\\{Ѐ�1��� �8����0qd7x�w�r������wd���c?ua�n��ԭ!���Hx�@�Hb��u�Kڠ �p�b�D�͚=��2�����лC���{�߀�g�-�K�ڮ��u�38����0�p�Ѥ��c�u�KR�@�a�2�@���J�~�l(<�$�ܝ�v���l3��L�����/��ɞ��j��Wes�cM���F�,Э����A]����N!��\\�u�Z��H��*s��5\n��wK�-;g4���q_rW�.rkA��e\0�G��4|�<�Q��f��E%�U0����\'\0�F�9G��\'@�	#�Qe���=�x���-b��;6Mk�LD���vx��O  �Q�IA�]�6�4#6H\0ú�W�\\����W>1���[�]e�ᴪ�sW���	����u�d}��@�0F��\"�����~�t��+�\"6��7��>�@6��+�g���G�Y��W�$ﾹ��ahQd�J�vx�@$<L��.���=  �����0�BBBjt\nx��?�̕��f�L��}d�d�]I�ێ K�<��l�����4|r�I|���%��������F���	R�M�ߐI��;���Z�������,,�a�=\'��\ne��/��@�6~ж�i�8���	h��wPTL��(���+�gg]��%O�[�C�=�\0>�1�C�۾���x�A�7�k ��I�嶔�n�Y���Y�!d�y��9��-@3�Рq=1�-��\0<c��4�3�/6��\\�Sh!�!]�(�	�-e����W�G|g;L0�g7�Y�vn�AW����1�Q(��ܸ�=��dm!@΅1}b \"2���텇��FJ6�\0l��1)G�-�O�bԕ�� �����K.����vD�n.y/��a�{�b *2�\Zf�\\���Bx��m����cn����8爻��l���0�P���Z�\\�^Ei�e���F��\0?�װĜGP�\n)��H�������6���g~k�^{	@��X�%�	������l.�.<�U�\r`�I�ʁE������e+�*����}fs6���W;��M5����ڏZ!RD��Jk�o@���^��@���J�j`4�2�n�2��e�*���5����f��7�3CS��h�Y$:�E�\n����L��.���q�8�#~\0oI\0�����v`b�)�z��MqnN��={yb?	��Ǉ��j	�{��Ld�����OM9��]I�)6W�k�k<2\rL�b�|�A	�[\r�3èW�]����H\\��!m�6�eqPp9�{��&9W ��\n�R��ʌ�{�:�\rlW�[�rؘ�=°8R�4𑘎�օ��A����gn7��wͧ8v��g�nd�\'�l�Z��xL�x�08��S#���t��zX��ˢ?���g�_���0�8�M)@�Z��yr��|x��\0�d\0f4��t|c#_��`��1e�;��J\nH��mqV~N�g���d�;dB��l�\\Q�g��kY?n/�a�&K 8������!<����2�;�5��ѧkK�	q�j���h���s���,T�Bd�k�_҃�>��,6G���1E�xs��a���N���~\nc,M�D��5E���T4��u�iZef\Z��AC2t1HD��L�]���Ӄ�z���QHa��W�Ȱ�&}��0�vGg�^[�U同�ؓӵ���:\"�U�Y�j�[:[����L�k�9�P&��	��«DAQ\'�C�E>�����O�0��\Z�f2��J��4ʬ����T���}��B��=��B�D��]��\0\\12AL\\�wO���x�v������S�*�əH�;\Zev	���-���!��$�������9���\n�-�/��v��#��fʓ�2�bЕ�/\"���M>��8��[g����ѶP��B�w��x�8<\Z�r�\"��#�a�z3�Y�+-�Bӱ?cO΢\"�H��8ޛm�f���{�G���GxY�8�\0\rzL��jmVfR�/zM���!�Q	�1�Ty9Hc��7[]ql�Hd�]��tov��hx�o�����N�#�ѤB\"��\0M��4}I�]<_d�wؤ�il�#���fN���R6���v�|���#���3��Gx�4#��#II���+�mB܇J	�m��9qj��W��y5m�VG�Z��4;W�Z@<�c���y���ˆjt\0\0\0\0IEND�B`�',35),
(2,'MS EXCEL','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0�\0\0\0�>a�\0\0\'~IDATx��]|S�>�;MG�PZZK�S�@Y�Dd� �P��`�Pde�2\ne	�\rZ��.�ۤiv����6MJK�䥴Џ_H����{�|��s���}��s\r�Ӿ�:<]��9G�s��9G�s��9G�s��t�|�Рի�.�A=�k�u(F��o3�N]Gu_=�%7��l>7�d0��Rj�d��Lf`�ݤF�<Ճ�{&H����W�L63:}\rer؍(�)��a�2��eٔ|���9;���놧}t��\'�K+Ɖ�QC�A�MFS��C�#�V}dc�M�Au�ȥ��7V���~��Fj5����86m=�m�&n�)#��q\Z�Z�`��f���D�f�t�T��{������z��x��Oj�~�5Ȥ7D ��~�4ۨ�Ew�΀r�mZ�Hκ�ro�}[����l��j$P�-AMtCdPl`T�I�^�l��=�X����|v�����L��w�����lD���#���U�xj@����<)�/3XL�i7B��*n��wfM���u-��y ��\0�E,�ar��)�E��Tt9��Y&#���,�De�W\Z����9F������Ƨy/N/�.K�rX|N0e0E�_��r�Qk�`����[�v�F��dr��\0�\0�]�6�@U�Մ�+@�L�z�Z�LDD\Z�\"&	\"��� �<9��(������{�����0���!���E�Z]�l�I�-p��>�z������\0�b`�j;m����V��1A�M:C&\"^�Qo�ޤ7�yl����������F�MFcbk#FQ�V�m��]jl�M\'��yP��\0�������d2?��@\re(��Y[��=�t�ͭC�Fj8�=�=̯b�<&�Z�l�t�g\r�L)�ri�>rp��g�BWJ�\n����)\0�F�j%�V�`0��a�e8�3j�S�ǯ��w���c+5�<*����wp�KMvTe��B^��??hР��r�r�E���7�֠\"	&&INa>\"L!��,&\"�Z�j�^�����	>������m\n�7V�^��&FUjP��X�w��j��+\'����\0\\å� ���\0^^^���h��@U@��\0*DiU��0��<\n��|�\r���b�ר�%����J ���nSTQ��\\����K��� ���&�{�O��|�	|}}A(�E\0�f��ѼM��w��?�z�df�ٔ����2R>���I��~���\r��W(ԯ_@,W�#�	���z���y[�ݤظU�G�e�LMn��9����tR��0�h��a-Ac�t�z��A`` ���\0��r�ĕ\0`�/+���D��v]�p��L���V�� ϟ��Ly����:E���1���n�ˣ�����v��b��a>d�7%��s�Ǔs��uf�M�`U�\0&\"�k`ר�\r_i�EU�y����m��ߟt$p60ż�z�yӽ���p9r�s59�F&�A��>�ͦ���*�<`�b��|�P$��#��tGP����M3JG�G\Z�������7���|�RM/0�l���\"l�nް��Ѿ�\Z�-x�z@P� �CDp����\'���&����\n�p�S��6֧e���J����ێOȼ��K��ڬQ�\Z8l>e4�v�b�Y��]��\\���_\Z���x21�y\"�8�|�}��������p�A����w	_R��M�R�7!�;�U�O�mQ�e%�ğ>&��2���j�`er�QC����{�\Z�l.������\'�`�vO��k\n��ـ�\\�K��*!I!\"�w#�C���`�ƙ�\0�\n��0�GZ\n���`��Å�H!�\0��/=�\rs����gPW��Y����S�zU\"\0��d�����ܫE����y�P���GK	�x�(T2��\\n\"�����n󈿉2��Q�����j�ѻ�a��-�L����d4�#�f�bU[\0�Igp��lz�^�?��q�:�\Zȿ�NR�	pD\n���۫�Mx�2^�n�e�]%�����V����\r�~�\Z���G�2Q��37Eq%�#�Sim����\0��)�������c��T��g&��o>D����\\�\0�\"	1\\I�}���w,*�i�\ZD���p���}����6�V�zj��m�5�k���g�;��b���i�YO�rܳ�����aL\0��=�a���f\\I�����\Zb�q���VN &��Ƿ���g��4y�;���K2ԙ\n���_��B݀\057�>�d�\\���k\"P����J>b`}`�PX��l�Ꭱ>{���|�@Wo���1,�m��ռ-����W����L��<Y��`��(��i����B�Kd5s�2�2)�Z��]E�!�%|�o��p�\\=ߜ�Y�N�\"D���f=F��{�í���۲n\'�zc���RA&�l�V�\0ȫ��&��1]׸G��Ү�(��M�n\r�i�f�K�\r����:h�y;�4��}�~�\0c�΃���G����q��d�.�~IX	�#��^��vm��CX�(��*(@�\0G�#:���;�j&��;`���6��OdG��m�cxeݻP�5��T�ѫ_>8t��<���`3���y�n82tp�U��,è3@��	�Ppr�0�M3�\0\'�/�|������X@k�Aߵ��h2ۙ�w0�7��x�:�my\0���H ��y��dJ�C���9R����\0��t��!M���}��W�xLh?�Y�g�(�;�CZD[rVA�`�P��9;9���B��\0\06\Z9�B�\nn;��N��	0X�\Z��\'ia�����\"- ��Q��0~�*��O�)��*���\rޏ�#;X�S���<���G�*f1�u6��Na��l&Q٧����r�u��$��V��6��p�`��ltF=q��l��1�o��=+�Z��W��R\\ԫ�*{�ݶ\0]e0z��f�Y�O�<��D��_S��Î��>;�����ti����G�k{\0�6pX,��$�߯�\"�v�j�<���Q�/px�+�W��$����ʠ>O���8U������O�X:S�dR���CS����/��s^[	@�a�#����b���W7�<����@wv�� ���{K=���;����W�F�w�\0��ð�sv/l;_:��j~��y��r%�G�\06�0l3 rc��`���q�5^���/��}�wj9tQ��A߼Kf�8\n&:o�R��`|�a ��$�0<H�?�@<�!�Pa��c�~ʼM���s�=�|7I�&��<@ɥ�v\0�)�J�a-��$�M���N��E�>(W��s�_a��]�]c��d�{Æ)����78����{��,py ��U(�+�D$�#J�*����\0�ͅ/&�e����N[�)(f����o��d����J`3P7���&���UF1�.�d㚋�m�9)��=�S��d��k�C;�������AB2��u\r��`��ɜA	�y���TR� ���\Zx����>F��?~ד���r�&�zg��I�0SgG��mB�<,rB�O�\0���(���-�-ԗ�#c���XfuQ%#j��m���T�ݼa��e�b�\\�����ě���@���@�;tq�R)��q�l��~�\Z��c�i$��P�)�ꃭ��:�>��Q`���tD�`p���z���.�\Z1\"�B�XÍ&#������Z�9g�\r�[F�{><�:|��������M��ā0��h�\\d2l>�+l�����ڨ5,�?�1��z\nT*ٔ|��W����9�U�����!\0��\"��ͯK��Qё�����Cy�I�F��[����#B���w֐�,p!��\'����á_YT\Zh���уI$���_�n���N�|��ͺ������r�U\0��ӷֲE|������I��E�7 ��N��9Gy���7>�\'������+���w�GT����n>�N�G�%[���r�aP�ބ\0�(X��zD8�Aov�^��!� ���fYߨ��.Lͺ���@i(�V�A,�X �6��ܛVy����{c>xI�+�1�\0o����[��L�\n|]=�=�r�m��u��f�t�B��/�)�>>>���+�j�?6����Q�j�V��g&��\rs,�\Z��w��$g�7PTfv��Ì&��\r�c����Â<�HK ��YS�g����w�D�K��Na-a�Й��;���{��\\+��h��#	����BbN��ga�\'�߆^�/Zm�����V�n����P�+P�k��fr�QS{�Ki��5�ߌ�G��\r�������I��!�Zt���n5F��C��Z����b`Ƒ����$�g�}�>Zճ.��o�������(���67�\r�h�Tv�[l���h�\ny��\Z�0_��Ú���ǩxH��d�l�]�@C� �6qI����o�ȍ3�L4�C��V$\n�Af���-<7!\'K!�3�j���#�?�e��P�-�����`���<��6���1�]{�S�7lˆ�2O�(8<��c9t�h��u)�\0iy�0h�t�Һ��c�{���;�������݇��H�΁���~m�ao:�3l�s�y����>�Ӛ#����0�u��$�7�?2�oK���z4~�j5A�,TZ5n-�� ����\'���!a`|HO\"\n�y��Ǉւ\Z�oxu0��H�.QAѲ��	�1�O��|N���òÛa��X�6}��߿W���sgh��v����} �)�����#��懴��<�.��n���L�hg_ݤ�>��OA��I!=V���\']���?�*��2qy*%�l~������~^��\\0oS&e�u{��!\\�(C��������Ú���p��a����i\0L���M$����n�tr\r�1V��Fu�p�UZ=��u������S	� ?>���;NO�H���{�i�	�b�Ѕ�4��7�CN��a�gZ��0�C�*�\0��C�?���0�f��nm#i]=��o߇���Mٷ�~���_����,m��n��n G�c2��C�w����6y���``������_����4�V�\r!�^+Z�a�^z������J;{���c��. W��z*`�Fy@���<[�T�<���B��vO$.�ͧ~��G��K�P��\Zt�U�#�N��&�D��%��� ���5�ȳ7@����L&e0�z�i8ο[Ԓ�)�B��)ˡ�W���$�b����Q�s?+�7C{B��\0r�+�% �K���Og�_�y��w_:�J\r�����Y����B]��D&��n8�c��ðf��{k�8HT\\{>���y�Z����;�Q�w�īҀ-�aƒ!klx<����R�ج\0����1IZՏ�P�`�s&f���U��A����(�ì�F�ζ��2p�h�q$��&��Cܭ���&�ovT�+��o�.�w��׆�z+��~Ҍ\n������ұ�~p��j�Vۯ>�on����ePw�?�[��8c�����39t0�ŧL&�&3��erYղz��+�ó7�D ��8L�4nZH���l�����N�U��_�ё���:�w�������1jt�ty�/e	����E��w���?��ܪe���(��g�]�p��#x��l󱶠��{�,��,�+{��d�w�bha�}���a�A,a�J��^��`T��z��!Y��]\0]�<���]#���z�S�_^2���\n����,��#H��\0g!B\Z\0��l�\0x�\0U|��W����y����p�g���O�m��e_]��%�/R\r\Z��8mpR�ͫ}�t���Þ��ͻ��Wߩ0��k�1�٤C�r0K`�j�B.��`K�u���\\d|����UH\n�L౹��C�ju_�~������\n��n�:ԅ�*J�f؝�p�`��0���\rlM�<�\"잱\ZB����D�^���Ɓa�z��O� �B�\'��_�1y*ݠ�&ȋO��@�&�r�(�܂�&��k�p�W����T�:Cw7&v\0\"X�z�����0���iؘ.N]=�CxX��������F�^i�\r�Z�@���`r�B���D�\"/>��|�pp$��<����>����B�`�(����ܛ輙z�ơO:l0�\r���\ZO�ǠYfY1o-�/>�}g�e� %\'�x�I=�����*%��;q0s�`�Y+�L�$�K �� ���Ƃ���>F���gESɦ���?&싛�Z�,�8t�t�\0\\\n����z��&nLk)�q`(l����ڏ��qf #������@��]+%���\'`��U�f�r���3L\0\nV!�B�ז��x�\0�_���R4�u��ڔc��. uO�\0l	�(���-�Hx�.��r�\\�V��?.��k���n?�7�����O�]h�JI�����|m}�&[I�\"��G�J�\"to�Fhu�x����A�7;�ԣ�wg�����~�A�q���\0E����ա��6\ri��y�¯|c9j�[I�����Qa�ba��S�@�Op�$������NZ&���L�	���=YF����YT�[�����D9x��QV��\Z{sF��g�Qm\0��.���\\#G�GG�*�w6�ܶg����_�oWN>�<�.�m�r�q�?����>��[�y��7!�aj�DҠ��=HVP�Q5^\'(� �4�J��\Z�3ݸ�ս␵�҉����p���	���\Z�Cy\0Z��H x���?�EZ�a���QL�I���l���80�*w�C�a�e�!cQ������k�)�q!�l2���a��1`����Ļ0�����\0�v���R�i�:�(�N�� D�@p��W�|��ޣ��C+���m�M���|��!Q�턅�-�d)��Ebf*Lٴ�U�|�7�{AD`C�.y��9��m�թ��r��Qk���w,�A�<���n�l!�y��Ǉc�|OҦ�\'w��%ͩ-���%�l����0+\r�����\'��5��]��u}��B��M�3�쑇���0,Fݒe��uǚ�.!A�t,�A8,e0y\rl#��E6��\0x�������E������X�+��F�S����+z���[FD��wÚ#��r�hʾ��pK���fPim~@DY�C\06�E�r���ܛ;,���y1:mx�|��ɤ��d���%���($\"��!��x�\nz�r�\n�X�o�,�A���Z��(�L��¤�`\"f��7�7Ϋc#�WÃ7���egOh�ZHB���w.�J�W��� /�,$���Z�<�\0�BQ\0a�U�R��d���N�<�����p����m�Lť{��|�#f ��<\0=%H�a���s�\Z��ay�wS�\0�L񩉐��L���=���L20ª��4��D��^\Z��|2 �zBR\'�./��j�`yp�߿��\n��<�7�-�f\Z\n��0h�BX���B�t��a%:��$.�n(d�UU�\">9-��V��h�c���WL����)��v$�:�+f�r엃��>��|�x߰	��09l��l-�*9��I�A�%�d(/��\"��s�?F��FB��4�s5���Sw�s��}��&��E��w��6?	�eu�,~���P�`�U�||���Ö�K����s��t%*�\\����}���P�pIg��Br���]�|�.Y]�\n�9��X\"��qʕ�u�jO�,�P@��X����ݙy7��c�\n�Z_�P4Q�ͽe�w�mB>��ܵ�B-��M\0���\'�ල`��V�U���tz��CWǪ�s~1ѐ���H��0q�|�_��N���`y�2!���(t��|}�����ݗ߰\"��Ļ���w,gQ�\\��V�2i\r�0�5�!湉�m[�pI(�O�rCA����u�����.�6η,H*qׅ��溡�1#�FbpX0Q�\rǿ�`:GVQ��Eދ\"^�>Т��O��>�������!��R�DQ�{�O5F-��R��2�@7��a�����DN���:PXś���[��P�:��������֥��$��ݰb��BLT~���MYBn���<\0��E�|{D�A�@��%�aRh\05�@	X�q�>;v%�=^�j�k!20�|���F�9���<ZC⽘��C���WӲ�\r�(�<�[7���<�i���6�����f/���/�{��,2�;S�K��839��\0p���$�m�x̼M�Wx=qǹ>l� ݠP;����	�k�ˤa�#�:������.\\�j7|���6@.���1�\0D�R&��M\\7N�,]�09\'6���Ql�j �	Y	�C�>`@��d�^���U%yX	0-�7�kަz��;�����~�!_�p\"�\\�7��a,fp�1i���f��=����U���c���9��V�Iٔq��l� �@C\0��\Z�*z�d�����nghmĠ���!�y��a8�l�+�s������^NX�B�\\:�\0��\0l&�2R޾��b�>�)�Y�)�	��d^H\Z?R�I�0�����o)X�����A���Ka�!���(��ã]��.�������0�y�*����>|���\0�\'J�܍�A�]��y�K�qm\Z���KV<��0��P�0?\\G;�>�`�H���@]vA�Ig�m�K��S4�I*�v���ݴ�?\\������a?\0?R���e�7�ø��Z-\r���R\'�R{Ũ�Ѷ��s��d��B^X��6q�j���\Z�I��X��>������&��z��.d H.uw�+��}	>����X��w^lN�L��--y\0�\0uD<��3L6�NV<e;ul)���`��]�T<y�rAI�H�|�9��I1�h�`8�\0�2&oߗ������w���\0��)�x�\0��_��¢%0i�	�����s�Q@���������N�������a��)\n)]~!�20	HV�\n��!P��;�NޝM���2�����dM�qm\\\'+2~V޵�\'Q �H\"D��\'e����9�+5	�^{˨�^cpY9��H�z6�j���E�6��[D�<�&�1\'qǹ7P��q|\\&��wn5�B����H��elLW�B����\'б��=S��*�\'M8���se¦�����Ê��fJ��RW�R�&���G�X���q���O��+���hk��h�\r��ÂF�w��a�\0EOyc��GGo��f\\F`�\n�wV�;�b;n-�sq�G�zvΫ�,\'��^iq��\"x��a��F��P��7�ty����}�*E�P?DHB{>dpٙ�X1,�-?�s�,�N8�\0�1�^�.��ݟy��6��7��sUi�A��M���\Z��$�B����\\��/~�5�M��*��6>Q�Ipf@�a�fAs\\\Z�&yUR2�6댅�LT�����\"c�Rpn����n�uOx�˼t��Ԉy��t�&��\r�F���i����)�F2�#T���kt�:ɠPg �����cj��F��5Z�LPڄ��[¹Fa2$<wq{��QN}�dy(Zy�H�V�j�j}&j�S�aQmV��rS�JM��P�_�]�W�K^�&����\\�]�k\"c�ms��`��+V��j�\n��t�L\'�����B�O?��F�E�+i��T�\r�ZQ�큳[\0*&��-��G�ad�2i\r�E��;_�6�R�ǝ���Jjhy}26�%�\Z��е�6���Hf������U.�J0����6Ð�ƏHO+\n���pD\0,��jm���	�k�s+^���.�&��k�z�%a>fyUlj���3�f:�PR�!,�4�\nur$�Q-\r]�o.kd�\Z]���tm�N&\0���]WI��8�fA��jR���]�IFNX��\0�Tj��	NXE��I}s�����H&��P��KLX��S��\\�B���fxrE��\'����>�l����\\9aO�������4�ai����O5it�Oux�QG���-�����+\0\0\0\0IEND�B`�',25),
(3,'MS POWER POINT','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0�\0\0\0�>a�\0\0\'MIDATx��]	|SU�?ٗ�M�&m�5m���������⠂���\"n(*�8#�:#:�}���� \"���\"e)]�4]�6�����}mB\n\r4ɫ�������-���=��s�<��\rޥ��\\Zt�\nG�pt�\nG�pt�\nG�pt L&�y)g�5?1��^�B\Za�}/���3���ȣF㡘.�baWMw�Ý%~W!���ciu^��uf��_/\\�0�\Z%����.�!�\"��|4�U&t���������;��C�߬<\\����.{�N�@�v��x]�4�+��s��EgcYL8��M�Y�����L��1����ٸ@�&@-v�	�60U�F�i4^��U��y�B��uA!�	y�l������tŇ�w<\\`��_����\0ƙ�Dbv�>:��#zY�v��»��$��9����=���u�S}s��*h�v@�$@����z;c�祙��n�+�Q��K�n���˶�/OW���H+��r�\\$��C�������\0�3G񱦒��^�u���w��y�㷅�lD\r�J\"�R�r	H����z$A��a�ѓ���f�;L�,&|�\ZTQU|�U��T�wa��4!�_�����{��X�P蓮|�p��G�+���X1	آ[���\Z�J��AIg��A��B�Pp���L�B���k�f��z1�\05^���Õ�(j�qTa��B��ܪ^�?N	�I�W�\Z�C����:K��������l�͓��u/	P�TZ���= \r	+^�\0a_!d9�X	a(��AUd�	��X��4�1���#��6��G��E��a�%�v���!�\rwۜ��\'��ψ��R\"w(u���Z\\�X3��=t����]/�ǻ>5��e̳2���%���VС`�K��݇A�&��*��1�wZ���c�4�����:��g�\r-7��j�-��C�8��S���\n�\r�+\n��	.z��D�S&<�3kMK�%�.�����Czj*���F��X̪��@�p9X\"0�z���h.��ikx\'d�Y��YX�0v$���@�F�\\H����k?ۙ�[����xYX��E�����ceW7��֖|�J\0��\'BRj:K���d�J��L�\Z�-�YR0ka�f�<�w�8T����@tf��Cn��X��fo8wp�;Fk]�ϥ?=m�A���KP�m<l�?����.,RRR@.�si�@a\\�?b_~�}�)����%�\Z���\0R_�~����~H�I�[�	�H��y 8����lHOO�B|>?�s_��8֮\0�O�E&��d��E��t�b�\0��\\���澫�OK��O��AP��\r�݇@VVddd�R��@��/~qlo���������r��2be�b�3�(�E	 �H\0���.��=cFK~s%�<!�����,	���A(����\0��o����J���{Á�j����pS��	�|\'E�?�C?cр./��7W�2%�\Z�\'HOKcՀZ�n�ZH\0ˢ���(�|SX���-�ό�U��sp�Ѳ�� n�.~�����%��@��i�]����\Z�III �HZ�D�>y�>�KV�Z��=\'�C���Nn	@ �c�rI޾IC~���}W,XO��� 6#;�	�d�V\'\0CSP��8\0_��c^�wj�k���K����@�Lȗz)&��ԡ;�\"��U��a_�P�;�`U@\Z��	�6h�j�,9f��s?9ax/]_��rO\0��N��~;����T[�	�	H-��s���H������� �Tu�J�K��$UY5OO�~8�q0�6�:eWE��f��\Z��Z��|!�0�e�w[:������rGIr�\Zz��}O��+��z�vX�ւ(�\'Hz\rq~_���E@o�1���#��\0ј����r�l�V����=_{\0>�����}r�i��.w�c�ph�xHS* C&xA�:���]6`8�z�V`��c3��� �\'�<�8,\"�쀺������_�`v{��X]�p��EW�y��Q��P��Έ�����`5�7ԃ�\'�Lb�i�.�7���Msn)`Ab2�M���W�����B���>#ɼ=?��C����]�p��ł�y�Ϊ�^�o�-��]�@�Mˌ�A�����A��	|UP��=\r�}[B1�NPL���C|���k����@��bj�����WQ� 1���bA�!(�1Lډ���	��KP�m?�Րh�\0Z������� ~��@����͂�\nY��A5���.�E�[�&86(���g���$�[�a�ZL\0d��CӺ�\Z�m�2�����6l�����偌X�@!�b�XPa��:�j_�ŵ,�?T3�cO�0H\0��/�sϖ@�	�m����MWHM�VWس�ZL\0��/��L�[îZNl�?���,\n�6(�s@\Z \r	��A9n\nč�\n��߃�W[~2p��3!��I��x�����}d_�h[y���MK�KLa�ZL\0���N�~�O���{��u�,v�7�A*\n?I/A�=�b�m`����*�b��,Xb}��!L����Ӂ�>y`�G�|5EVg�@����aT�:�L~iP�����r��K���j��%��H��!���!f����?`����)���3�η�\0���:P�Q�a�ӻ�EP�*����` 	b�R����߅���Ā��	Q��8)��=}�k�\'`~g)�wl�䤠~l	�zl�\n����\0�	x{���K�.~\r	h1�Ë�%D4�����4�\0��a@*���b�� Y*���qz6T-�8�輒��!��W����\ZA��̒}��}|°\Z�v���ù)>_B1�n�@��#=�\0�|O�l^�	�d\"��� JH�?��䑈O��ڧ L�>{M0̻���Wl���m-����	?@b�|��b���z�.�#=���b˴��YB�\nt{w#$R0<u/x+�#>o��!��[����1�X4;��R��\r��ط�Gh<Gˁ���MӚ�WwZ<%/�#=�%VA��!��N��Vo\0�@\0%���21�G�f��\0vB���W:3v��A�N�atÎ�k�]?#?m�_��ئ]Arg�<�:�~*7��@VF:�\\���E3FPa{f��r!��`��-T��J�8�0��������a����b�	*��k��#?٣M��14\r|��\Z�R2A����D���F�c������,��Z�S���h�W�F&��ݺC������`��ze\"d,�oC�	�\\�1��+xi��}͎��R���~� ��y1�rI��������S���cA�K�.�6���\ng3ry��w��e\Z�]����Cp��S\"�3m(�f�\0��C����j��Ӂ&\r�����\n�|Y�W��z�\n���Y�8���k>�5U�����Dz�aՀ�G3)���}z�>�P��T�����g��`��d�IDm�0��ew�<�\\a�8]����.��1>/Ph��Z��Բ�I�D�[����&���X���cb!{�w\rω�]�j	Xwn\\�L������ݚ#5���1 ��d��ڑ=����q�F�j�B�G�\r���}��\n�C��s�vFd;�s>����tx w൐?�>�ץ�P��VL��0K���>3H\0B2AT�=��\0��O����ew-������d��T��Ddl�]�>O�c@���.K�f%q�F�y��U �ԍ�S^�b��ë�99ݙzX�\'�*C�H������\\��8�Ń��*��;�r�*��sL[�c\'��?\\��Lp�m.��t��csR��b��!�=E\'<�=��9=2���H��$(���򔡁�j�n�~���>Y1d��R�v< ^\"bG[vL���/�<�\Z};h��$Ø|�̜	૭\n�=Y�֢}��\n�Ev� l���V�CS�/���;���B��yh�~�e��~���Ƅ��̎��U��R�s�sy��P8w\"�1D7E�F4ɢQ�RH@���*\'i�#�M�\0\r\'��f���-?\\���#����b3���_\"���ȉ����^���)z��y/�$\0��������K�m(OyxM@� 	���I��-��c���)$	���Q\r���޿G(�Bv��(���6_��3�����hRN9lprƍM���`ѼOOW�Z��q��8�!(CO m�����ܦ���S 矟�$���$>q/��D�=2ZT+��Ɔ ��?����_�z�h{��=!@@FV�|�:������=&�~d~��|��v����`��.�8\0AD@Ɖ��[wS�o�q2N��Hbd����@��p�ϣ����sC�󊯀/�6{�c,�S��d	(�C5V0��lf�UA�Hv�<\ZRz���D���_���(g��pd�I�R���;�I|!�\0����|hJ��a(؜W>iz��F�e��s;x���2�\\\n�}7m��ӆ�z	;��	N�9���d=2,+��©b��[	�^����*y�	���8��6R��2:<��@�P?rU������Ez�PHd��惍�\0%/�+�p� y�lЌ��Y5@�Y0{��j��o2p��\n�qC~ ��z1y=A�pe��ϼ�(�%�)�������Q� \"������n�N��\\���Ò�I�RX��[5�׆uN5\n_{���x`�ΦZE����kA��\n&H��\n��@If?�6�s��?Ff�[�������{�8���(@������A��}4�i�A# }�␆`�������r���isA}��!	���h_D7*H\\�\r�5�����ibXO-��c\'���P��kVB�7��^�����\rB[�Gh���� ��m\\�\\�&���_� $���Ԃ��pxH�r�}bur�����1T�ƶ���h07�%�	 m�\'ӵd?�,�Bв�σ���e(���m8t#�U�6w��K4=��b@����? �9M#�z��6��R嫷���7�,F��I�5��	����J�Xt�s]�쯮��B@�r�����3���\rv8�y8��P��l~�^Sݏ�~:v�V&��pz\"޾&b�|����+���6=�D���\n$I)!ꃁ�3nb�p!�v�ډ3�A����c.���ɭX�Pnw��\0q�L�P��\"�7�x�\r\Z]x�\'����GE�*̟��u��TTe�0D1��0��<�+s��NZn������~\r���6�\n.|\0l��aS�XbM\nH�� MՃU��{_*.:��8}\n���٭���p�bc�O�q�yxOI�ލ:6�/40�yx;�/ZWT������S咚�;�q�hl\0��f����X���9WsH�2����h�?�307H�s@��k�?[�LV>�4��3��w=��?W�v��	H@%\n\n�}+���ԩ���S~��<��#��`�[����ֱ��Q�غ���6<��[;��k�>�z�\0���������@�@D �?E˟��#>Gs �a��j�	\"�+(�4&T�����@ѭOӌ��$��<���oőҿ~|�rU��_i ��h$=L-�~=��^|(N��y=���oq���&�݆�_��;�ODQ�%�J���v��~!�{ovh;�g�rx������%�fo1Ԯ��PQ�^���0/ͤl�{�\\�mz�0V	=���ؘ;Ybm�����୍n��W��c@ڭ/g��9�N�ѹw5Y��o?aql�&@U�!(FCP���]�^��izXo$�\r�~|v���8s̿�5[�w��5��^\Z_�����\0d��Vu�,z�Iz����\rEݿ���j�*Z�����YKoLK�6=�����!]�}\'�7�C+�����,/WY��,)�io�>��y���`2&��aa�\Z�[�laP��\'m>���H��2[���:�	��=:�k\nǫ��@�S�L�o�~��MP�s3\n��*�Yc�AO���B��#A�Q��e�I/���\"��ݽ\n�>��w�x&44mC�=�K%��\\��\0��(B�ÆhU�_�&���0혻 �Ϗ7�?���g��lͿ��$\'��R(\Z� ���� ����#��K?Z	���\r��(�0b���Q% �8\0A�#�a�Xi��o��<=L�{ ��mYȊ�F��+OsyIn@F��M��]GX��E��L\nW<��_�LN��6�6��������i�n�W�qz�D��>o��%���CMҤ��w��NP��`	��=ALLLd�\0���v��@�o����811Y&�2F ��\0h�}4��hX����*N�+����@ �7{���aϤk�A����M����ϵ�Ebcc#�Hp���z��?W�}5��ӳ�Qu����GM���\"L�~�ˇh������\"��}1ٹ!+�����(�򲜠&#\\׌���<��t�J��A��yFfcY�{K?�\"ה�=Q�s�x|Ũg���O��<=��ܿC��[BVα%s���m\\^��n8Rk�B��JHHH\0Y<zq*���{<���l$P�eb�\Z��4\'hΛ�瞡�;��\0�\'���}��E�Ld�pz/-�:�薨n�H��D�t����\'΄�{hV��)z�u(��}./�	Hz���zH����0�5���\'೤����7�z(�vM����?��c�g>)�zS)D�_=j���.J٠���|�yPh�p�:iHʸ�K8�|1�����[��ٰ0����5�H�p_��1��)#����o�n5X��{��pE\09��ߌ�����b2r���C����{Op�|�\0���P0�jPcO �\0�jc�zRnj:�e/:	�� \0I��;�86X����3j4��1�φ��/q�&Ð�~~�-ټ�wb��k�\rU�@#����`��_͠aM�̇�����\n^�yp��a�v�/u^*��\0L�i�KWg��Vp�F<���׃<%������wx�L��\ZD1��s��A��eg\n	�\'���}^�\0��M\'��|�_]�>~�����/�w���z�N �n��<����6����ú/�h=�����CO�Y��������7�N)J�Pn�v�Z-�Ԃ�Z������\Z��ڇ���ү����^�`Ok��h�X���*�8\0\'��ݑ��>;/�����i�B�\ry{^�,Gy؊O����}�?�&y�5x��`7��\\�����X,j�ix�q�s�;��P��e.�����\04*�U._Tq\0���������� ��5ٜ�FZ񙉰=�bZe٘V\0#B���!%55��%	���c���@Y��{����G�Z1�;<�Mf�>nL�D�����m��<�����:�s (�撄\0�=?L?�� �پ��=����\"S��U��G�Հ��0)_��!�u�Q��ط��0W]Qz!��\'����@�/U֯(�/V�\n�:���!��g���*y��Р��{�\0���#J#�y��y�n�����+Gʞ@P�* �um�[ �F3�{��a)ʎ�%a��	����ԃ�q�����l�sz\ru���OW���S�%�R���.@�]����f���̙�)i��nϰ\n$P�J������A�K�R�\r�U	l0H�b�C��\ZȂ���c7�n��_�陪�J����CE��ƙ���a�5����+㝎�%�h�a��D:�Tba�L��e�H+\'���w���<Ԅ��j�q�uM�\0+�U<��X����8\0�B�x���׊��Ka��\">;$�7�|\\�y�5aZ��Vr\Z��wK�,if���N�9�����\n�BBCP��R����E�wl.و}�62n	:��\'��\'M����Ő~ӄ&e�����L\r�.3oev��z/��S������.-F�mzX;�1���e\'1�TD�֟7����oBҀ뛔�~��̃�=��]��飏U���pJ\0z��=Җ�-б�d#�m.(wx-wH����;M��i��3P�6m3E_}GW,	|F{�}��W)���*�/Ⅱ���\nh��Sr4��Ы9Ok���ĀQ�	�b$	����$���v����������?B���oB��o��4]u�ւ~q\"��졢�p* �6�Q)�{�]����+�%�\'=�N!C�\Z��q�����7��$�mz�f/��Y(���NM�q��Ld�%�8\0��x�9q�A/���|���\n���{�]Z:K\0�V{Ѡ�\r���h��x�չ�/{���$�*]���\0������<���v��\\��u����%�%@JJ\n���`��A���k����ײ�*������d�{\0>OB3�n�������F}�Gخ�.UK�\n](&���3\'E;��k^=jx\\+U�G���@CP�a��i�{&�tl.�g�! ��v�Pff&�PL�`��C�c�	}SZ�ƻ���\n0�\nh�@WP�AO`F礿ߜ���\\�}>�n��~VcPH\"ѕ��ya��}�:��Qa��ϋk_O,5�Z��#�ǥ�O����<=����׀��G #=�\r\r�����3�w��\r3�2=��X�>�����I\0ACj[\\�R>�^imbsɶ\0��:��3 ;\'�� h.��VZ\'�`�O�b�QÔ�̎�m���\Z�\n��K�o��ڋ;��\Z��\r��X��iYO@�\0R|��>��J�(��\01�4����3���9XzS�ó��9��\nP\rH)�Iyp���#=̏�f��;Y&�D���M6���pJ�B�i�Mg;1O�/�o�RG��>6;��u9>��M3��{�}�\'�zU�~@�{�������L���(���cƮ3}��/�I���T\0)\0��]��^�ۑ���Ô�=��\nyd��yA��`Nֻv.8T6Y.�W�\r�I���z\06=lBF�����mz��?H�������d\"��F\"Tj��8$B�M�!���e^t���36�6��W�N��	ZE0$�ߔ}b����q�zX{���k����Lq\"ø$���b$�|�(A,�Q���Uj$�B$P����Ue�Z�~��	y`�2�� A�	oT�*�z�OzGz�(�9���U�|��ȉ�\'l|4��i�dc~���8��ZQ0�����e]��a$�3�38���_8Zq��{�\r,9�������#@^�x�V#����5^雾.Ev٧���g��k28���Mnoy��S^���8|t)��%����r��w^�g���Y���E9G�:��s���%��}z�Boþ���>7��=؝��C��c�tzK+\\�\Z��D�TcwMZ-y\'����5��6��]��qʸzbf��q��O ���ь���2�����0��э+�ty\rd�~�.�#[�58��{΋���R.f��4y�TC�c��I����ζf`�~�G+���2���5�5�˄$ -�j�$<w!!�RA/������ZU($=L�Z�#�����f�a�:/�����(���ۀ�����C	�B�f���m�D�~a�+�6\'�Ph]��0O�V���<O\Z��E����xhƎ��uq)\n�Htt��K���M1d��ۂ�z���	Z�\0	֖nY���*� ���&F�a6]SJ/�π]v9\Zd��W����k/��\\����`A��m���	Z�\0h��-�>��]�M%kIzX�֌�ua�lB]\\������+G�����x���kIk��䝆���U\\����&\0�voV��G������odΜ��X�Z3�+P�#v�(�jl�D��5�[��\\!��s}Y��HЪ��a �攸��.�x�֠���EZ3��\r.�/��b��C�-D��,��瑙�<=6�7͐(����ݹT���	�$��\'y�@G�vn�M�{Ea�\Z�oN$�Ug��B�`��hK�s�� ��\\���=�q#��\0\0\0\0IEND�B`�',25);

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
