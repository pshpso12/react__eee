#sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
grant all privileges on  *.* to 'root'@'%' identified by 'mysql1234';
delete from mysql.user where host="localhost" and user="root";
flush privileges;
select host,user,plugin,authentication_string from mysql.user;

drop database if EXISTS freestyledb;

create database if not EXISTS freestyledb
    DEFAULT CHARACTER set utf8
    DEFAULT COLLATE utf8_general_ci;
    
use freestyledb;

create table user(
 `uid` varchar(20) not null,
 `upw` varchar(20) not null,
 `unickname` varchar(50) not null,
 PRIMARY KEY (`uid`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;
  
CREATE TABLE `skill` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `position` varchar(100),
  `skill.rare` varchar(100),
  `hotkey` VARCHAR(255),
  `skill.explanation` VARCHAR(255),
  `skill.img` VARCHAR(1023),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;
  
  
 CREATE TABLE `freestyle` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `freestyle.rare` VARCHAR(100),
  `freestyle.explanation` VARCHAR(255),
  `freestyle.img` VARCHAR(1023),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;
  
 CREATE TABLE `freecha` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `team` VARCHAR(255),
  `position` varchar(100),
  `rare` varchar(100),
  `tall` varchar(100),
  `characteristic` VARCHAR(100),
  `character.explanation` VARCHAR(500),
  `cha.img` VARCHAR(1023),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;
  
 CREATE TABLE `position` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `position.explanation` VARCHAR(100),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;
  
CREATE TABLE `player` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nickname` VARCHAR(255) NOT NULL,
  `chaid` INT NOT NULL,
  `positionid` INT NOT NULL,
  `skill1` INT NOT NULL,
  `skill2` INT NOT NULL,
  `skill3` INT NOT NULL,
  `skill4` INT NOT NULL,
  `skill5` INT NOT NULL,
  `skill6` INT NOT NULL,
  `freestyle1` INT NOT NULL,
  `freestyle2` INT NOT NULL,
  `freestyle3` INT NOT NULL,
  `rank.num` INT NOT NULL,
  `winrate` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX (`skill1`, `skill2`, `skill3`, `skill4`, `skill5`, `skill6`),
  INDEX (`freestyle1`, `freestyle2`, `freestyle3`),
  INDEX (`chaid`),
  INDEX (`positionid`),
  FOREIGN KEY (`skill1`) REFERENCES `skill` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`skill2`) REFERENCES `skill` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`skill3`) REFERENCES `skill` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`skill4`) REFERENCES `skill` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`skill5`) REFERENCES `skill` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`skill6`) REFERENCES `skill` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`freestyle1`) REFERENCES `freestyle` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`freestyle2`) REFERENCES `freestyle` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`freestyle3`) REFERENCES `freestyle` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,  
  FOREIGN KEY (`chaid`) REFERENCES `freecha` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`positionid`) REFERENCES `position` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;
  
 CREATE TABLE `game` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `home.first` INT NOT NULL,
  `home.second`INT NOT NULL,
  `home.third` INT NOT NULL,
  `away.first` INT NOT NULL,
  `away.second`INT NOT NULL,
  `away.third` INT NOT NULL,
  `win` varchar(100),
  PRIMARY KEY (`id`),
  INDEX (`home.first`, `home.second`, `home.third`),
  INDEX (`away.first`, `away.second`, `away.third`),  
  FOREIGN KEY (`home.first`) REFERENCES `player` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`home.second`) REFERENCES `player` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`home.third`) REFERENCES `player` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`away.first`) REFERENCES `player` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`home.second`) REFERENCES `player` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`home.third`) REFERENCES `player` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
  
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;
  
  

INSERT INTO `skill` (`id`,`name`,`position`, `skill.rare`, `hotkey`, `skill.explanation`, `skill.img`) VALUES
    (1, '킬패스', 'PG/DG', '액티브', 'S', '패스가 어려운 상황에서 노마크인 팀원에게 빠르게 패스한다', '/skill.img/skill1.png'),
    (2, '슛터치', 'PG/SG/DG/SF/SW/CT', '액티브', 'D+단축 키 때기', '슛 게이지를 맞추면 수비의 방해를 덜 받고, 성공률이 상승한다', '/skill.img/skill2.png'),
    (3, '메뉴얼블록', '전체', '액티브', '(← ↑ → ↓) + D', '방향키 방향으로 더 먼 곳으로 블록 가능하게 한다', '/skill.img/skill3.png'),
    (4, '베이스볼 패스', 'PG', '전용 액티브', 'R', '패스 경로에 있는 수비수를 무시하며, 공을 빠르게 패스한다', '/skill.img/skill4.png'),
    (5, '스크린스윔무브', 'PG/DG/C/PF/CT', '패시브', NULL, '스크린에 걸렸을 시, 일정한 확률으로 스크린을 회피합니다', '/skill.img/skill5.png'),
    (6, '오버패스인터셉트', 'PG/DG', '액티브', '패스경로 예측 + A', '오버패스를 인터셉트 할 수 있다', '/skill.img/skill6.png'),
    (7, '패스페이크', 'PG', '액티브', 'V or V+D', '패스를 주는 척한다. 달리고 있는 경우 레이업과 연계 가능', '/skill.img/skill7.png'),
    (8, '다이빙캐치앤패스', 'PG', '액티브', '다이빙캐치 중 + S', '다이빙 캐치 후 즉시 패스로 연결한다', '/skill.img/skill8.png'),
    (9, '최후의 저항', 'PG/C/PF/CT', '전용 액티브', '공격수 등 뒤 + F or D', '등 뒤에서 일정 확률로 슛 저항을 준다', '/skill.img/skill10.png'),
    (10, '퍼펙트패스', 'PG', '패시브', NULL, '좋은 위치 팀원에게 패스 시 일정 시간 슛 정확도 상승', '/skill.img/skill11.png'),
    (11, '강화된 미들 슛', 'PG/DG/SG/SF/SW', '전용 패시브', NULL, '미들슛 성공률을 비약적으로 올려준다', '/skill.img/skill12.png'),
    (12, '강화된 패스', 'PG/DG', '전용 패시브', NULL, '패스 속도가 빨라지고 인터셉트에 잘 당하지 않는다', '/skill.img/skill13.png'),
    (13, '3점슛모션속도 강화', 'PG/DG/SG', '전용 패시브', NULL, '3점슛 빠르기 능력치가 상승한다', '/skill.img/skill14.png'),
    (14, '레이업집중', 'SW/SF/C/PF/CT', '전용 패시브', NULL, '레이업을 쏠 때 수비 방해를 덜 받는다', '/skill.img/skill15.png'),
    (15, '강화된 3점슛', 'SW/SG', '패시브', NULL, '3점슛 성공률을 비약적으로 올려준다', '/skill.img/skill16.png'),
    (16, '강화된 다이빙캐치', 'PG/DG', '패시브', NULL, '다이빙캐치 가능범위가 증가한다', '/skill.img/skill18.png'),
    (17, '강화된 인터셉트', 'PG/DG', '패시브', NULL, '인터셉트 가능범위가 증가한다', '/skill.img/skill19.png'),
    (18, '강화된 스틸', 'PG', '패시브', NULL, '스틸이 빨라져 성공확률 증가', '/skill.img/skill21.png'),
    (19, '3점슛 집중', 'SG', '전용 패시브', NULL, '3점슛을 쏠 때 수비저항을 덜 받는다', '/skill.img/skill22.png'),
    (20, '메뉴얼레이업', '전체', '액티브', '(← ↑ → ↓) + D', '원하는 방향으로 레이업한다', '/skill.img/skill24.png'),
    (21, '다이빙캐치', 'PG/DG', '전용 액티브', '루즈볼 상황 + S', '몸을 날려 루즈볼을 잡아낸다', '/skill.img/skill25.png'),
    (22, '퀵점퍼', 'SF', '전용 액티브', '패스받기 전 + D', '패스 받는 순간 빠르게 슛을 던진다', '/skill.img/skill26.png'),
    (23, '슛중패스', 'PG/SG/DG/SF/SW/CT', '액티브', 'D + S', '레이업과 덩크 중 상대를 속이고 패스를 한다', '/skill.img/skill27.png'),
    (24, '앨리웁패스', 'PG/SG', '액티브', '앨리웁 요청 시 + F', '앨리웁 요청 중인 공격수에게공을 띄워준다', '/skill.img/skill28.png'),
    (25, '훅업패스', 'PG', '액티브', '앨리웁 요청 시 + 레이업 슛 중 + F', '레이업 중 상대를 속이고 엘리웁 패스를 한다', '/skill.img/skill29.png'),
    (26, '인터셉트', '전체', '액티브', '패스경로 예측 + A', '공격수 사이에서 패스를 차단한다', '/skill.img/skill30.png'),
    (27, '직접패스', '전체', '액티브', 'Q or E', '단축키를 통해 원하는 공격수에게 패스한다', '/skill.img/skill31.png');
    
    
INSERT INTO `freestyle` (`id`, `name`, `freestyle.rare`, `freestyle.explanation`) VALUES
    (1, '크라운', 'fx', '슛 동작이 빠르고 타점이 높다'),
    (2, '크라운', 'fx', '슛 동작이 빠르고 타점이 높다'),
    (3, '크라운', 'fx', '슛 동작이 빠르고 타점이 높다');

INSERT INTO `freecha` (`id`, `name`, `team`, `position`, `rare`, `tall`, `characteristic`, `character.explanation`) VALUES
    (1, '잭', 'JACK The PINK', 'SF/PF', '일반', '193cm', '집중훈련 +20', '키가 커서 타점이 높은 장점이 있지만 키가 몇센치 더 크다고 이속이 미친듯이 깎여 버렸다. 잭스포가 살아 남을려면 드리블 뿐.');
    
INSERT INTO `position` (`id`,`name`, `position.explanation`) VALUES
    (1, '포인트가드(PG)', '빠른 이동 속도와 정확한 패스를 통해 환상적인 팀플레이를 만들어낼 수 있다'),
    (2, '슈팅가드(SG)', '팀의 주 득점원인 슈팅가드는 타고난 슛감각과 센스로 어떤 상황에서도 골을 성공시켜야만 하는 포지션'),
    (3, '듀얼가드(DG)', '게임 전체의 조율과 동시에 돌파와 슛을 활용하여 공격을 주도하는 포지션, 패스와 슈팅 능력을 모두 가지고 있는 멀티플레어'),
    (4, '스몰포워드(SF)', '미들슛, 드라이브인, 돌파가 뛰어나며 화려하고 자극적인 플레이가 특징'),
    (5, '파워포인트(PF)', '수비 시에는 리바운드와 블록에 가담하며 공격 시 골밑 슛을 활용하는 포지션'),
    (6, '스윙맨(SW)', '뛰어난 돌파 능력을 가지고 있어 내/외곽을 뒤흔들며 수비 진영을 무너뜨리는 포지션.'),
    (7, '컨트롤타워(CT)', '센터, 파워포워드 등 기존 빅맨에 비해 안정감은 다소 떨어질 수 있으나 빠른 스피드를 이용하여 다른 빅맨보다 다양한 루트로 공격 가능'),
    (8, '센터(C)', '골대와 가까울수록 골이 성공할 확률이 높은 스포츠인 농구에서골대를 장악하는 파워가 가장 강력한 포지션');
    
INSERT INTO `player` (`id`,`nickname`, `chaid`, `positionid`, `skill1`, `skill2`, `skill3`, `skill4`, `skill5`, `skill6`, `freestyle1`, `freestyle2`, `freestyle3`, `rank.num`, `winrate`) VALUES
    (1, '나무꽃', 1, 1, 1, 2, 3, 4, 5, 6, 1, 2, 3, 1, '60'),
    (2, '바봅', 1, 1, 1, 2, 3, 4, 5, 6, 1, 2, 3, 1, '40'),
    (3, '아리랑', 1, 1, 1, 2, 3, 4, 5, 6, 1, 2, 3, 1, '30'),
    (4, '뭘보냐', 1, 1, 1, 2, 3, 4, 5, 6, 1, 2, 3, 1, '20'),
    (5, '그냥해', 1, 1, 1, 2, 3, 4, 5, 6, 1, 2, 3, 1, '10'),
    (6, '아오우', 1, 1, 1, 2, 3, 4, 5, 6, 1, 2, 3, 1, '45'),
    (7, '이이라', 1, 1, 1, 2, 3, 4, 5, 6, 1, 2, 3, 1, '70');
    
    
SELECT nickname, concat(winrate,'%') from player;

select player.nickname, freecha.name, position.name, concat(winrate,'%') from player
    join freecha on player.chaid = freecha.id
    join position on player.positionid = position.id;
    
    
select nickname, concat(winrate,'%'),
 ( @rank := @rank + 1 ) AS rank,
 ( @real_rank := IF ( @last > winrate, @real_rank:=@real_rank+1, @real_rank ) ) AS real_rank,
 ( @last := winrate )
 FROM player AS a,
 ( SELECT @rank := 0, @last := 0, @real_rank := 1 ) AS b 
 ORDER BY
 a.winrate DESC;
 /***
 http://nodapiseverywhere.blogspot.com/2016/11/mysql-ranking-query.html
 랭킹 시스템은 꼭 사용하고 싶어서 참조!
 ***/
 