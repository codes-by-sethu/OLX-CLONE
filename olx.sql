/*
SQLyog Community v13.1.8 (64 bit)
MySQL - 5.5.16 : Database - olx
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`olx` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `olx`;

/*Table structure for table `add_category` */

DROP TABLE IF EXISTS `add_category`;

CREATE TABLE `add_category` (
  `id` bigint(60) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `add_category` */

insert  into `add_category`(`id`,`name`,`status`,`image`) values 
(8,'Houses & Apartments','Active','house.jpg'),
(9,'Mobile Phones','Active','mobile.jpg'),
(10,' Motorcycles','Active','motorcycle.jpg'),
(11,'Cars','Active','cars.jpg'),
(12,'Fashion','Active','fashion.jpg'),
(13,'Beauty','Active','beauty.png'),
(14,'Furniture','Active','furniture.png'),
(15,'Electronics & Appliances','Inactive','Electronics & Appliances.jpg'),
(16,'Accessories','Active','accessories.jpg');

/*Table structure for table `admin_login` */

DROP TABLE IF EXISTS `admin_login`;

CREATE TABLE `admin_login` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `admin_login` */

insert  into `admin_login`(`id`,`name`,`username`,`email`,`password`) values 
(1,'Admin','Admin',NULL,'427fd5fe20ec52d871f9df0a87799153'),
(2,NULL,NULL,NULL,NULL);

/*Table structure for table `chat_groups` */

DROP TABLE IF EXISTS `chat_groups`;

CREATE TABLE `chat_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `sender` bigint(20) DEFAULT NULL,
  `receiver` bigint(20) DEFAULT NULL,
  `last_update` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `chat_groups` */

insert  into `chat_groups`(`id`,`product_id`,`sender`,`receiver`,`last_update`) values 
(1,37,17,12,'2023-04-22 13:17:59.669058');

/*Table structure for table `favourites` */

DROP TABLE IF EXISTS `favourites`;

CREATE TABLE `favourites` (
  `product_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `favourites` */

insert  into `favourites`(`product_id`,`user_id`,`id`) values 
(36,20,5),
(12,20,6),
(23,20,7),
(37,14,12);

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chat_id` varchar(255) DEFAULT NULL,
  `messenger_id` bigint(20) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `messages` */

insert  into `messages`(`id`,`chat_id`,`messenger_id`,`date`,`message`) values 
(1,'1',17,'2023-04-22 13:17:35','Hai'),
(2,'1',12,'2023-04-22 13:17:59','hellooo');

/*Table structure for table `otps` */

DROP TABLE IF EXISTS `otps`;

CREATE TABLE `otps` (
  `id` bigint(60) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `otp` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'pending',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

/*Data for the table `otps` */

insert  into `otps`(`id`,`email`,`otp`,`status`) values 
(1,'lakshmisethuktm202@gmail.com','1778','pending'),
(2,'lakshmisethuktm202@gmail.com','758','pending'),
(3,'lakshmisethuktm202@gmail.com','4777','pending'),
(15,'lakshmisethuktm202@gmail.com','4178','Verified'),
(16,'lakshmisethuktm202@gmail.com','6753','pending'),
(17,'lakshmisethuktm202@gmail.com','6615','pending'),
(18,'lakshmisethuktm202@gmail.com','2950','pending'),
(19,'lakshmisethuktm202@gmail.com','1115','Verified'),
(20,'akhils@mailinator.com','8223','pending'),
(21,'akhils@mailinator.com','6247','Verified'),
(22,'sachin@mailinator.com','400','Verified'),
(23,'asd@gmail.com','660','Verified'),
(24,'as@gmail.com','8124','pending'),
(25,'akhilcogniz@gmail.com','272','pending'),
(26,'as@gmail.com','1686','pending'),
(27,'as@gmail.com','6803','pending'),
(28,'as@gmail.com','149','pending'),
(29,'akhilcogniz@gmail.com','6426','Verified'),
(30,'sach@mailinator.com','8571','pending');

/*Table structure for table `reports` */

DROP TABLE IF EXISTS `reports`;

CREATE TABLE `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) DEFAULT NULL,
  `reason` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `reports` */

insert  into `reports`(`id`,`customer_id`,`reason`) values 
(1,12,'Fake Customer'),
(2,12,'He cheated me'),
(3,12,'Fake Customer'),
(4,14,'Fake Customer,Cheated me');

/*Table structure for table `submit_ad` */

DROP TABLE IF EXISTS `submit_ad`;

CREATE TABLE `submit_ad` (
  `id` bigint(60) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `categoryid` varchar(255) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `condition` varchar(255) DEFAULT NULL,
  `type1` varchar(255) DEFAULT NULL,
  `description` text,
  `price` varchar(255) DEFAULT NULL,
  `manufacturers` varchar(255) DEFAULT NULL,
  `image1` varchar(255) DEFAULT NULL,
  `image2` varchar(255) DEFAULT NULL,
  `image3` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `po` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `customer_id` varchar(255) DEFAULT NULL,
  `verification_status` enum('Active','Inactive','Sold Out','Blocked') DEFAULT 'Active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

/*Data for the table `submit_ad` */

insert  into `submit_ad`(`id`,`title`,`categoryid`,`brand`,`condition`,`type1`,`description`,`price`,`manufacturers`,`image1`,`image2`,`image3`,`name`,`email`,`phone`,`state`,`city`,`po`,`address`,`customer_id`,`verification_status`) values 
(2,'Iphone 13 128GB','9','iPhone','Good','iOS','Blue colour 128GB with bill and accessories. Not for exchange. Heavy bargainers please stay away','53,000','Apple','iphone.jpg','iphone1.jpg','iphone2.jpg','Darshan','darshan@gmail.com','86945827','Karnataka','Bengaluru','Doddanagamangala','Doddanagamangala, Bengaluru, Karnataka','12','Inactive'),
(3,'Honda City (2009)','11','Honda','super super xcellent condition',' 5 seater 4 cylinder car','super super xcellent condition\r\nADDITIONAL VEHICLE INFORMATION:\r\nABS: Yes\r\nAccidental: No\r\nAdjustable External Mirror: Manual\r\nAdjustable Steering: Yes','2,60,000','Honda','honda1.jpg','honda2.jpg','honda3.jpg','Suhan','Suhanauto@gmail.com','9023541678','Maharashtra','Pune','Pune Cantonment','Pune Cantonment, Pune','12','Sold Out'),
(4,'Hyundai Xcent (2014)','11','Hyundai ','perfect','SX Automatic 1.2 (O)','2014 December model almost 2015\r\nnew tyre both keys available\r\nloan available','4,25,000',' Ranawat Moters','hyundai.jpg','hyundai1.jpg','hyundai2.jpg',' Ranawat Moters','ranawatmotors@gmail.com','987654345','Maharashtra','Mumbai','Palava City','Palava City, Mumbai, Maharashtra','12','Sold Out'),
(5,'Fiat Avventura (2015)','11','Fiat','excellent','Active Multijet 1.3','single owner double key available insurance valid non accdential vehicle\r\nADDITIONAL VEHICLE INFORMATION:\r\nABS: Yes','4,45,000','CARS MART PRE OWNED CARS','cars1olx.jpg','cars2olx.jpg','cars3olx.jpg','carsmart','carsmart@gmail.com','7845964633','Telangana','Hyderabad','Madhapur','Madhapur, Hyderabad, Telangana','12','Blocked'),
(6,'DUKE 390 (2021)','10','KTM','excellent','390 Duke ABS','Duke 390\r\nInsurance complete\r\n1st owner','275000','KTM','bike1.webp','bike3.webp','bike4.webp','Saket','saket@gmail.com','6987584252','Rajasthan','Jodhpur','674592','Khas Bagh, Jodhpur, Rajasthan','12','Blocked'),
(7,'Aadab Fabulous Men Casual Shoes','12','Puma','perfect','Men Casual Shoes','Material: PU\r\nSole Material: Rubber\r\nFastening & Back Detail: Lace-Up\r\nSizes:IND-6, IND-7, IND-8, IND-9, IND-10\r\nEasy Returns Available In Case Of Any Issue','1000','Online Marketplace','shoe.webp','shoe1.webp','shoe3.webp','Online Marketplace','onlinemarketplace@gmail.com','9874512364','Maharashtra','Samudrapur','567465','Samudrapur, Maharashtra, India','12','Blocked'),
(8,'House for sale near Vimala Cheroor Thrissur 49 lacks','8','SR Constructions','excellent','Houses & Villas','5 Cent plot 1640 Sq feet House at Cheroor near Vimala College Thrissur. 3 bed rooms attached, Semi Furnished, Water well, Bore well, car parking, Compound wall, tar road frontage. 350 Mtr from the bus route. 5 KM from the town. Price 49 lacks.. Contact BabuRamakrishnan Thrissur Property. Next to the Kalyan Silk Palace Road Thrissur. thrissurproperty. com. 9495955 and 777','4900000','Vechoor Constructions','olxhome.webp','olxhome2.webp','olxhome3.webp','Thrissur Property','thrissurproperty@gmail.com','9495955777','Kerala','Kolazhy','654785','Cheroor, Kolazhy, Kerala','12','Active'),
(9,'Low Price Best Home Cinema Wifi Smart HD LED Projector USB HDMI SD AUX','15','SD AUX','good','T5 WiFi Version','T5 WiFi Version LED Projector is specially designed for home theater, entertainment, etc. Its physical (native) resolution is up to 480*360 Plxels. 1920×1080p Supporting a variety of video, pictures and music fomats. And, its 1500 lumens brightness provides high definition and bright images. It will bring you much convenience and unexpected experience whether in your daily life &in your work.\r\n\r\nLOW PRICE BEST HOME CINEMA HD LED MULTIMEDIA VIDEO PROJECTOR USB HDMI AV SD AUX 5V DC POWER\'BANK POWER SUPPLYWatch 2022 IPL 80 inch A Big Screen best for Hotel Restaurant Bar Cafe Gym Road site dhabas Best For Customer Entertainment\r\nT5 Wi-Fi Version HD LED PROJECTOR LOW PRICE BEST HOME CINEMA HD PROJECTOR USB HDMI TV AV SD AUX CONNECT ALL TV SETUP BOX','4999','wifi peaks','wifi1.webp','wifi.webp','wifi3.webp','Omexcart.Com','omexcart@gmail.com','987546123','Kerala','Shoranur','657812','Vallapuzha, Shoranur, Kerala','12','Active'),
(10,'Black sandals','12','Mukta fabrics','good','women\'s wear sandals','Comfortable, stylish, women wear.','1500','Mukta fabrics','sandals.webp','sandals2.webp','sandals3.webp','Mukta','mukta@gmail.com','698457126','Kerala','Vaniyamkulam II','685721','Nellaya Village, Vaniyamkulam II, Kerala','12','Active'),
(11,'4k lens (Insta 360 one r twin)','15','Insta 360 one r twin','excellent condition','4k lens','Not even single use.. only genuine buyers pls contact me .. Instagram Id niktales_','10000','Insta 360 one r twin','lens.webp','lens1.webp','lens2.webp',' Niktales','niktales@gmail.com','69874512','Kerala','Vaniyamkulam II','659670','Nellaya Village, Vaniyamkulam II, Kerala','12','Active'),
(12,'150m 4cent 3bhk house near Malayinkeezhu Moviluvila','8','SRJ Builders','perfect','Houses & Villas','150m 4cent 3bhk house near Malayinkeezhu Moviluvila\r\n3 Bds - 3 Ba - 950 ft2','3900000','SRJ Builders','prop.webp','prop1.webp','prop2.webp',' smithasanthosh',' smithasanthosh@gmail.com','864579215','Kerala','Thiruvananthapuram','698545','Peyad, Thiruvananthapuram, Kerala','12','Active'),
(13,'Airpods pro 1st generation with unused accessories and box','16','Airpods pro 1st generation','excellent','Mobile','Mint condition apple airpods pro 1st generation with full box, bill and accessories.\r\n\r\nAccessories including charging wire is not used and is still in original packaging.\r\n\r\nSelling because brought 2nd generation airpods pro','10000','Airpods pro 1st generation','airpods.webp','airpods1.webp','airpods3.webp',' Hari','hari12@gmail.com','989567435','Kerala','Thiruvananthapuram','685721','Kazhakoottam, Thiruvananthapuram, Kerala','12','Active'),
(14,'Boat Rockerz 450 Pro With upto 70 hours Playback blueetoth headset','16','Boat Rockerz 450 Pro','perect','Mobile','Boat Rockerz 450 pro\r\n\r\nNew headset only 1 week used\r\n\r\nFull box\r\n\r\nGood look\r\n\r\nGood sound Quality\r\n\r\nHigh Bass','1800','Boat','boat.webp','boat1.webp','boat2.webp',' Bibin Roy','bibinroy@gmail.com','890066543','Kerala','Alappuzha','687560','Alappuzha Cantt, Alappuzha, Kerala','12','Active'),
(15,'DJI OM6 brand new.1 month old','16','DJI OM6','excellent','Mobile','DJI OM6 new . Never used .brand new condition. 1 month old . serious buyers only text here.','11500','DJI OM6','acc.webp','acc1.webp','acc2.webp','Shafeeq','shafeeq@gmail.com','890766457','Kerala','Malappuram','667542','Valanchery, Malappuram, Kerala','12','Active'),
(16,'Samsung Galaxy watch 4 Classic','16','Samsung Galaxy','excellent','Mobile','(Brand new) - LTE, Bluetooth, WiFi, GPS, 4.55 Cm, MRP: 42,999/-, Manufacturer Date: January 2023, Sealedbox not yet opened, Unwanted gift, Purchase date 18/02/2022, Invoice copy will be shared at the time of purchase','17999','Samsung','watch.webp','watch1.webp','watch3.webp','Shahir','shahir@gmail.com','932678008','Kerala','Kochi','698546','Kakkanad, Kochi, Kerala','12','Active'),
(17,'Apple iwatch SE GPS + CELLULAR 40MM Aluminium 100% battery health','16','Apple iwatch','good condition','Mobile','iwatch SE\r\nGPS + CELLULAR 40MM Aluminium\r\nFull box and warranty bill\r\nRarely used\r\n100% battery health\r\nEMI AVAILABLE\r\nDEBIT / CREDIT CARD ACCEPTED','18500','Apple iwatch','applewatch1.webp','applewatch.webp','applewatch1.webp','ELITE Mobiles','elitemobiles@gmail.com','9088764526','Kerala','Kottarakkara','678543','Neduvathoor, Kottarakkara, Kerala','12','Active'),
(18,'20000mah Powerbank','16','Mi','good','Mobile','Mi Powerbank For sale... Little bulged... Working perfectly.','600','Mi','power.webp','power1.webp','power2.webp','Juleo Joseph Mundolickal','juleojosephmundolickal@gmail.com','9977554396','Kerala','Idukki Township','765238','Adimali, Idukki Township, Kerala','12','Active'),
(19,'iPhone Charger 12 pro','16','Apple','good','mobile','Only 2 monts used','3100','Apple','charger.webp','charger1.webp','charger.webp',' Bharath Hastha','bharathhastha@gmail.com','987654329','Kerala','Kollam','654231','Ashramam, Kollam, Kerala','12','Active'),
(20,'Sony alpha 77 II','15','Sony','good','alpha 77 II','Sony mirrorless camera\r\n18-135 lens\r\n13k shutter count only\r\nReason for sale going abroad\r\nCharger,Battery,bag available\r\nVery good condition','25500','Sony','camera1.webp','camera.webp','camera2.webp',' 2Stroker',' 2stroker@gmail.com','987654237','Kerala','Vaniyamkulam II','667743','Nellaya Village, Vaniyamkulam II, Kerala','12','Active'),
(21,'Dell i7 Laptop with 16GB RAM and 256GB SSD Laptop','15','Dell','Good condition','i7','Best performance Dell i7 Laptop\r\n* intel core i7-6300u processor\r\n* 16GB DDR4 RAM\r\n* 256GB SSD M.2\r\n* 14\" inch Full HD Display\r\n* windows 11 pro original OS\r\n* 4GB Graphics integrated\r\n* keyboard back light\r\n* GPS support\r\n* 4G Sim support\r\n* good backup','23900','Dell','i7.webp','i71.webp','i72.webp','Ec Store','ecstores@gmail.com','908766578','Kerala','Kochi','686002','Edappally, Kochi, Kerala','12','Active'),
(22,'Well maintained old bullet','10','Royal Enfield','perfect','Classic','Well maintained November month old bullet\r\n2017 - 23,220 km','60000','Royal Enfield','re.webp','re1.webp','re2.webp','Mohanan','mohanan@gmail.com','998762435','Kerala','Thiruvananthapuram','676689','Muttathara, Thiruvananthapuram, Kerala','12','Active'),
(23,'House for sale in decent jn kollam','8','New Home Builders','excellent','Houses & Villas','22 cent\r\n4 bedroom 4 bathroom\r\nStore room\r\nMaid room\r\nNegotiable\r\n4 Bds - 4 Ba - 3400 ft2','20000000','New Home Builders','home.webp','home1.webp','home3.webp','GK','gk@gmail.com','09874512364','Kerala','Thrikkovilvattom','687985','Decent Junction, Thrikkovilvattom, Kerala','12','Active'),
(24,'Get iPhone 12pro max (256gb) with Bill Box & Warranty','9','Apple','perfect','iPhone','Get iPhone 12pro max (256gb) with Bill Box & Warranty\r\n\r\nExchange not Available\r\n\r\nFree Cash Home Delivery\r\n\r\nContact me On WhatsApp','29500','Apple','pro.webp','pro1.webp','pro2.webp','Mahesh','mahesh@yahoo.com','9876543215','Kerala','Shoranur','678902','Vallapuzha, Shoranur, Kerala','12','Active'),
(25,'Honda Civic (2006)','11','Honda','excellent','Civic (2006)','1.Mugen RR full body kit\r\n2.New full black seat cover\r\n3.Maintained perfectly\r\n4.Service is done from showroom\r\n5.Tax upto 2026\r\n6.Tires are in good condition','380000','Honda','honda1.webp','honda2.webp','honda3.webp','Sidharth S','sidharths@gmail.com','9564532178','Kerala','Palakkad','879054','Peringottukurissi, Palakkad, Kerala','12','Active'),
(26,'9000km run force goods traveller','11','Force Motors Ltd','excellent','Trucks','Delivery van closed body\r\nPower steering\r\nAbs\r\nRun only 9000km\r\nBrand new vehicle','1125000','Force Motors Ltd','truck.webp','truck2.webp','truck3.webp','Cibil Iqbal','cibiliqbal@gmail.com','9447033219','Kerala','Muvattupuzha','654578','Perumattom, Muvattupuzha, Kerala','12','Active'),
(27,'Ford Ecosport (2015)','11','Ford','excellent','1.5 TDCi Ambiente','no replacement good condition place perumbavoor\r\nADDITIONAL VEHICLE INFORMATION:\r\nABS: Yes\r\nAccidental: No\r\nAux Compatibility: Yes\r\nBattery Condition: New\r\nBluetooth: Yes\r\nVehicle Certified: Yes\r\nInsurance Type: Comprehensive','459000','Ford','ford.webp','ford1.webp','ford2.webp','Perumbavoor Cars','perumbavoorcars@gmail.com','09876543215','Kerala','Perumbavoor','678902','Chelamattom, Perumbavoor, Kerala','12','Active'),
(28,'Bean chair with beans high quality beans filled bags delivery','14','Bear teddy bean bags','excellent','bean','Bean Bags available in best price\r\n#delivery available in all Kerala#\r\nDouble stitched high quality premium material Denim cotton leather materials\r\n6 Sizes of bean bags available\r\nXL, XXL, XXXL, JUMBO, KING, MONSTER Sizes\r\nMost comfortable, easy to carry and budget friendly bean bag sofas now made and delivered upon order\r\n- Brand: Bear teddy bean bags','1499','Bear teddy bean bags','bean.webp','bean1.webp','bean2.webp',' BeaR TeddY',' BeaRTeddY@gmail.com','09447033219','Kerala','Shoranur','600328','Vallapuzha, Shoranur, Kerala','12','Active'),
(29,'Get New iPhone 12pro max (256gb) with Best Offer','9','Apple','excellent','iphone','Get New iPhone 12pro max (256gb) with Best Offer\r\nBill Box & Warranty\r\nFree Cash Home Delivery','28999','Apple','iPhone 12pro.webp','iPhone 12pro 2.webp','iPhone 12pro.webp','Nurvika Jha','NurvikaJha@gmail.com','9876543215','Kerala','Shoranur','678902','Vallapuzha, Shoranur, Kerala','12','Active'),
(30,'Sheos for girls','12','abibas','excellent','girls shoes','Sheos for girls','370','abibas','Sheos for girls.webp','Sheos for girls.webp','Sheos for girls.webp','Siya','siya@gmail.com','9447033219','Kerala','Shoranur','657812','Vallapuzha, Shoranur, Kerala','12','Active'),
(31,'2016 MODEL HONDA DIO','10','Honda','GOOD CONDITION','Dio','HONDA DIO\r\nGOOD TYRES\r\nSECOND OWNER\r\nALL PAPER CLEAR\r\nFIXED PRICE\r\nPLACE','36999','Honda','scooter.webp','scooter1.webp','scooter2.webp','ZODIC PREOWNED BIKES','ZODICPREOWNEDBIKES@gmail.com','09564532178','Kerala','Kochi','678902','Vyttila, Kochi, Kerala','12','Active'),
(32,'KTM RC Model','10','KTM','excellent','RC','Brand:\r\nKTM\r\nModel:\r\nRC\r\nYear:\r\n2021\r\nKM driven:\r\n37,000 km','195000','KTM','ktm.webp','ktm1.webp','ktm.webp','Joyal','joyal@gmail.com','99447033219','Kerala','Payyannur','600328','Kannur, Payyannur, Kerala','12','Active'),
(33,'desert storm 500','10','Royal Enfield','excellent','desert storm 500','owner going to abroad, Accedent free...\r\nWell-maintained\r\nBrand:\r\nRoyal Enfield\r\nYear:\r\n2015\r\nKM driven:\r\n47,500 km','75000','Royal Enfield','desert storm 500.webp','desert storm 5001.webp','desert storm 5002.webp',' Nasar','nasar@gmail.com','9447033219','Kerala','Kochi','678902','Kolenchery, Kochi, Kerala','12','Active'),
(34,'Montra Downtown','10','Montra Downtown hybrid bike','excellent','hybrid','a. Montra Downtown hybrid bike for sale\r\n\r\nb. 10 months old, and clocked around 700 kms\r\n\r\nColor: Grey with Neon Orange\r\n\r\nNote: Some accessories such as below, will be part of sale, will proceed only if interested\r\n\r\n1. Adjustable XMR handle bar for height\r\n\r\n2. Bottle holder','20000','Montra','Montra.webp','Montra1.webp','Montra3.webp',' Pravin','pravin@gmail.com','984576268','Kerala','Kayamkulam','688905','Kareelakulangara, Kayamkulam, Kerala','12','Active'),
(36,'A great home is great investment','8','Green land homes','excellent','Houses & Villas','Build your dream home with us\r\n3 Bds - 3 Ba - 2000 ft2\r\nSemi-Furnished\r\nCarpet Area (ft²) :\r\n1800','3800000','Green land homes','houses.webp','houses1.webp','houses2.webp','Neethu','neethu@gmail.com','9447033219','Kerala','Shoranur','600328','Vallapuzha, Shoranur, Kerala','12','Active'),
(37,'Apple Iphone 14','9','Apple','Good','Apple','Good Apple iphone 14.','45000','Apple','-original-imaghx9qtwbnhwvy.jpg','-original-imaghx9qmgqsk9s4.webp','-original-imaghx9qmgqsk9s4.webp','sethu','lakshmisethuktm202@gmail.com','8714406682','Kerala','Kottayam','686586','Kottayam','12','Active'),
(38,'Bens Car ','11','Bens','Good','Car','Good car for sale','1562000','Bens','1668442134552-2019-mercedes-benz-e-class-coupe-1548703839.jpg','1668442134552-2019-mercedes-benz-e-class-coupe-1548703839.jpg','1668442134552-2019-mercedes-benz-e-class-coupe-1548703839.jpg','sachin','sachin@mailinator.com','9562530065','Kerala','Kottayam','956856','Kottayam','14','Active'),
(39,'Mac Book M1 Air','9','Apple','Good','Apple','Apple Mac','36500','Apple','mbp-spacegray-select-202206.jpeg','mbp-spacegray-select-202206.jpeg','macbook-air-space-gray-select-201810.jpeg','sachin','sachin@mailinator.com','9562530065','Kerala','Kottayam','686586','rfwrf','14','Active');

/*Table structure for table `user_login` */

DROP TABLE IF EXISTS `user_login`;

CREATE TABLE `user_login` (
  `id` bigint(60) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `user_login` */

/*Table structure for table `user_registration` */

DROP TABLE IF EXISTS `user_registration`;

CREATE TABLE `user_registration` (
  `id` bigint(60) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phoneno` varchar(255) DEFAULT NULL,
  `status` enum('Active','Blocked') DEFAULT 'Active',
  `aadhar` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Data for the table `user_registration` */

insert  into `user_registration`(`id`,`username`,`email`,`password`,`phoneno`,`status`,`aadhar`) values 
(12,'sethu','lakshmiseth0uktm2020@gmail.com','d9d9c191ac5707cd06f3b1bd8efba2a7','8714406682','Active',NULL),
(13,'Akhil','akhils@mailinator.com','0e65d4a24085a4a3f09069234c884c41','9562530061','Active',NULL),
(14,'sachin','sachin@mailinator.com','e872182e5ea18837d095dac24fea00a2','9562530065','Active',NULL),
(15,'akhil','asd@gmail.com','e872182e5ea18837d095dac24fea00a2','9562541250','Active',NULL),
(16,'admin123','as@gmail.com','427fd5fe20ec52d871f9df0a87799153','9562530061','Active',NULL),
(17,'akhil','akhilcogniz@gmail.com','e872182e5ea18837d095dac24fea00a2','9562530061','Active',NULL),
(20,'Sachu','sach@mailinator.com','26fe0288b02dc83049f25dce3497ef0f','9562530061','Active',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
