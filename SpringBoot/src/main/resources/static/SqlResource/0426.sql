use enjoytrip;

show tables;

desc user;

drop table if exists noticeboard;
drop table if exists notice_board;
drop table if exists trip_plan_detail;
drop table if exists trip_plan_user;
drop table if exists board_comment;
drop table if exists user_board_like;
drop table if exists board;
drop table if exists board_type;
drop table IF EXISTS user;

# 날씨 API를 위한 sido테이블 수정
desc sido;
alter TABLE `sido` add column `sido_nameEn` varchar(45) DEFAULT NULL;
UPDATE sido SET sido_nameEn = 'Seoul' WHERE sido_code = 1;
UPDATE sido SET sido_nameEn = 'Incheon' WHERE sido_code = 2;
UPDATE sido SET sido_nameEn = 'Daejeon' WHERE sido_code = 3;
UPDATE sido SET sido_nameEn = 'Daegu' WHERE sido_code = 4;
UPDATE sido SET sido_nameEn = 'Gwangju' WHERE sido_code = 5;
UPDATE sido SET sido_nameEn = 'Busan' WHERE sido_code = 6;
UPDATE sido SET sido_nameEn = 'Ulsan' WHERE sido_code = 7;
UPDATE sido SET sido_nameEn = 'Sejong' WHERE sido_code = 8;
UPDATE sido SET sido_nameEn = 'Gyeonggi-do' WHERE sido_code = 31;
UPDATE sido SET sido_nameEn = 'Gangwon-do' WHERE sido_code = 32;
UPDATE sido SET sido_nameEn = 'Chungcheongbuk-do' WHERE sido_code = 33;
UPDATE sido SET sido_nameEn = 'Chungcheongnam-do' WHERE sido_code = 34;
UPDATE sido SET sido_nameEn = 'Gyeongsangbuk-do' WHERE sido_code = 35;
UPDATE sido SET sido_nameEn = 'Gyeongsangnam-do' WHERE sido_code = 36;
UPDATE sido SET sido_nameEn = 'Jeollabuk-do' WHERE sido_code = 37;
UPDATE sido SET sido_nameEn = 'Jeollanam-do' WHERE sido_code = 38;
UPDATE sido SET sido_nameEn = 'Jeju-do' WHERE sido_code = 39;
select * from sido;

#
alter TABLE attraction_info add column recommand int DEFAULT 0;
select * from attraction_info;

# 유저 데이터 생성
CREATE TABLE user (
                      id varchar(20) NOT NULL,
                      pw varchar(20) NOT NULL,
                      name varchar(20) NOT NULL,
                      nickname varchar(40) NOT NULL,
                      email varchar(20) NOT NULL,
                      email_domain varchar(20) NOT NULL,
                      type  varchar(20) DEFAULT 'user',
                      status tinyint(4) default 0, # 0 활성, 1 비활
                      PRIMARY KEY (id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into user ( id, pw, name, nickname, email, email_domain, type)
values('ssafy', 'ssafy', '김싸피', '김싸피', 'kimssafy', 'ssafy.com','user'),
      ('admin', 'admin', '관리자', '관리자', 'admin', 'ssafy.com', 'admin'),
      ('d', 'd', 'test용', 'test용','ssafy', 'ssafy.com', 'user');
select * from user;


# 게시판 타입 - 공지사항, 자유 게시판등 여러개 일 것
create table board_type(
                           type_no int auto_increment,
                           type_name varchar(50),
                           primary key(type_no)
)ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into board_type values (1, 'notice'),
                              (2, 'free');

select * from board_type;
insert into board_type (type_no, type_name) value (1, 'notice'), (2, 'free');


# 게시판
create table board(
                      no int not null auto_increment primary key,
                      type_no int not null,
                      user_id varchar(20) not null,
                      title varchar(100) not null,
                      content varchar(4000) not null,
                      hit int default 0,
                      like_cnt int default 0,
                      created_at datetime not null,
                      status tinyint(4) default 0,
                      constraint board_fk_id foreign key (user_id) references user(id) on delete cascade,
                      foreign key (type_no) references board_type(type_no)
)ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
select * from board;
alter table board auto_increment = 0;
insert into board (type_no,title, user_id, content, created_at)
values (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (1, 'enjoytrip을 사용해주셔서 감사합니다.', 'admin', '감사하다고요', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now()),
       (2, 'this is free board', 'ssafy', 'THX XD', now());

select * from board;

# 게시판 댓글
create table board_comment(
                              no int auto_increment,				#댓글 번호
        user_id varchar(20), 				#작성자 아이디
                                  comment_content varchar(200) not null,		#댓글 내용
                                  comment_like int default 0,			#댓글 좋아요 수
                                  board_no int not null,				#해당 댓글이 속한 게시글 no
                                  created_at datetime NOT NULL, 		#작성 시
                                  status tinyint(4),
                              primary key(no),
                              constraint comment_fk_id foreign key (board_no) references board(no) on delete cascade,
                              foreign key (user_id) references user(id)
)ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# 유저가 좋아요 누른 게시글 출
create table user_board_like(
                                user_id varchar(20),
                                board_no int,
                                foreign key (user_id) REFERENCES user(id),
                                foreign key (board_no) REFERENCES board(no)
)ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# 여행 계획 - 유저별
create table trip_plan_user(
                               user_id varchar(20),
                               plan_no int auto_increment,
                               plan_start date not null,
                               plab_end date not null,
                               primary key(plan_no),
                               foreign key (user_id) references user (id)
)ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# 여행 계획 - 디테일
create table trip_plan_detail(
                                 plan_no int not null,
                                 plan_detail_no int auto_increment, #여행 계획 일정 순서
                                     content_id int not null,
                                 primary key(plan_detail_no),
                                 foreign key (plan_no) references trip_plan_user(plan_no),
                                 foreign key (content_id) references attraction_info(content_id)
)ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

