-- DROP TABLE COM_CODE;

CREATE TABLE COM_CODE(
  CLASSNO 	INT(11),				-- 대분류
  CODECD 	VARCHAR(10),			-- 코드
  CODENM 	VARCHAR(30),			-- 코드명
  PRIMARY KEY (CLASSNO, CODECD)
) ;

-- DROP TABLE COM_DEPT;

CREATE TABLE COM_DEPT(
  DEPTNO 	INT(11),   				-- 부서 번호
  DEPTNM 	VARCHAR(20),            -- 부서명
  PARENTNO  INT(11),                -- 부모 부서
  DELETEFLAG CHAR(1),    	        -- 삭제 여부
  PRIMARY KEY (DEPTNO)
) ;


-- DROP TABLE COM_USER;

CREATE TABLE COM_USER(
  USERNO 	INT(11) NOT NULL AUTO_INCREMENT,	-- 사용자 번호
  USERID 	VARCHAR(20),                    	-- ID
  USERNM 	VARCHAR(20),                    	-- 이름
  USERPW 	VARCHAR(100),                    	-- 비밀번호
  USERROLE	CHAR(1),                    		-- 권한
  PHOTO 	VARCHAR(50),                   		-- 사진
  DEPTNO	INT,
  DELETEFLAG CHAR(1),    	                 	-- 삭제 여부
  PRIMARY KEY (USERNO)
) ;

/*------------------------------------------*/

-- DROP TABLE TBL_BOARD;

CREATE TABLE TBL_BOARD (
  BGNO INT(11),                             -- 게시판 그룹번호
  BRDNO INT(11) NOT NULL AUTO_INCREMENT,    -- 글 번호
  BRDTITLE VARCHAR(255),                    -- 글 제목
  USERNO 	INT,                    		-- 작성자
  BRDMEMO   MEDIUMTEXT,		                -- 글 내용
  BRDDATE   DATETIME,                       -- 작성일자
  BRDNOTICE VARCHAR(1),                     -- 공지사항여부
  LASTDATE  DATETIME, 
  LASTUSERNO  	INT, 
  BRDLIKE 		INT default 0,             	-- 좋아요
  BRDDELETEFLAG CHAR(1),                    -- 삭제 여부
  PRIMARY KEY (BRDNO)
) ;

-- DROP TABLE TBL_BOARDFILE;

CREATE TABLE TBL_BOARDFILE (
    FILENO INT(11)  NOT NULL AUTO_INCREMENT, -- 파일 번호
    BRDNO INT(11),                           -- 글번호
    FILENAME VARCHAR(100),                   -- 파일명
    REALNAME VARCHAR(30),                    -- 실제파일명
    FILESIZE INT,                            -- 파일 크기
    PRIMARY KEY (FILENO)
);

CREATE TABLE TBL_BOARDLIKE (
    BLNO INT(11)  NOT NULL AUTO_INCREMENT,  -- 번호
    BRDNO INT(11),                          -- 글번호
	USERNO 	INT,                    		-- 작성자
	BLDATE  DATETIME, 						-- 일자
    PRIMARY KEY (BLNO)
);

-- DROP TABLE TBL_BOARDREPLY;

CREATE TABLE TBL_BOARDREPLY (
    BRDNO INT(11) NOT NULL,                 -- 게시물 번호
    RENO INT(11) NOT NULL,                  -- 댓글 번호
	USERNO 	INT,                    		-- 작성자
    REMEMO VARCHAR(500) DEFAULT NULL,       -- 댓글내용
	REPARENT INT(11),						-- 부모 댓글
	REDEPTH INT,							-- 깊이
	REORDER INT,							-- 순서
    REDATE DATETIME DEFAULT NULL,           -- 작성일자
    REDELETEFLAG VARCHAR(1) NOT NULL,       -- 삭제여부
	LASTDATE  DATETIME, 
    LASTUSERNO  INT, 

    PRIMARY KEY (RENO)
);

-- DROP TABLE TBL_BOARDREAD;

CREATE TABLE TBL_BOARDREAD (
	BRDNO INT(11) NOT NULL,                 -- 게시물 번호
	USERNO 	INT,          			     	-- 작성자
	READDATE DATETIME,						-- 작성일자
	PRIMARY KEY (BRDNO, USERNO)
);


-- DROP TABLE TBL_BOARDGROUP;

CREATE TABLE TBL_BOARDGROUP (
  BGNO INT(11) NOT NULL AUTO_INCREMENT,     -- 게시판 그룹번호
  BGNAME VARCHAR(50),                       -- 게시판 그룹명
  BGPARENT INT(11),                         -- 게시판 그룹 부모
  BGDELETEFLAG CHAR(1),                     -- 삭제 여부
  BGUSED CHAR(1),                           -- 사용 여부
  BGREPLY CHAR(1),                          -- 댓글 사용여부
  BGREADONLY CHAR(1),                       -- 글쓰기 가능 여부
  BGNOTICE CHAR(1),                       	-- 공지 쓰기  가능 여부
  BGDATE DATETIME,                          -- 생성일자
  PRIMARY KEY (BGNO)
);

-- DROP TABLE COM_LOGINOUT;

CREATE TABLE COM_LOGINOUT (
  LNO 		INT(11) NOT NULL AUTO_INCREMENT,    -- 순번
  USERNO 	INT,                    			-- 로그인 사용자
  LTYPE 	CHAR(1),                       		-- in / out
  LDATE 	DATETIME,                          	-- 발생일자
  PRIMARY KEY (LNO)
);

CREATE TABLE TBL_CRUD(
  CRNO INT NOT NULL AUTO_INCREMENT,	-- 번호
  CRTITLE  	VARCHAR(255),     		-- 제목
  USERNO 	INT,            		-- 작성자
  CRMEMO   	MEDIUMTEXT,				-- 내용
  CRDATE   	DATETIME,        		-- 작성일자
  CRDELETEFLAG CHAR(1),     		-- 삭제 여부
  PRIMARY KEY (CRNO)
) ;


-- 날짜
CREATE TABLE COM_DATE
(
	CDNO bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
	CDDATE char(10) COMMENT '날짜',
	CDYEAR char(4) COMMENT '년도',
	CDMM char(2) COMMENT '월',
	CDDD char(2) COMMENT '일',
	CDWEEKOFYEAR smallint COMMENT 'WEEKOFYEAR',
	CDWEEKOFMONTH smallint COMMENT 'WEEKOFMONTH',
	CDWEEK smallint COMMENT 'WEEK',
	CDDAYOFWEEK smallint COMMENT 'DAYOFWEEK',
	PRIMARY KEY (CDNO),
	UNIQUE (CDNO)
) COMMENT = '날짜';

-- 메일주소
CREATE TABLE EML_ADDRESS
(
	EMNO int(10) NOT NULL COMMENT '메일번호',
	EASEQ int NOT NULL COMMENT '순번',
	EATYPE char(1) NOT NULL COMMENT '주소종류',
	EAADDRESS varchar(150) COMMENT '메일주소',
	PRIMARY KEY (EMNO, EASEQ, EATYPE)
) COMMENT = '메일주소' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 메일
CREATE TABLE EML_MAIL
(
	EMNO int(10) NOT NULL AUTO_INCREMENT COMMENT '메일번호',
	EMTYPE char(1) COMMENT '메일종류',
	EMSUBJECT varchar(150) COMMENT '제목',
	EMFROM varchar(150) COMMENT '보낸사람',
	EMCONTENTS mediumtext COMMENT '내용',
	ENTRYDATE datetime COMMENT '작성일',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	EMINO int(10) NOT NULL COMMENT '메일정보번호',
	DELETEFLAG char(1) COMMENT '삭제',
	PRIMARY KEY (EMNO),
	UNIQUE (EMNO)
) COMMENT = '메일';


-- 첨부파일
CREATE TABLE EML_MAILFILE
(
	FILENO int(10) NOT NULL AUTO_INCREMENT COMMENT '파일번호',
	FILENAME varchar(100) COMMENT '파일명',
	REALNAME varchar(30) COMMENT '실제파일명',
	FILESIZE int(10) COMMENT '파일크기',
	EMNO int(10) NOT NULL COMMENT '메일번호',
	PRIMARY KEY (FILENO),
	UNIQUE (FILENO)
) COMMENT = '첨부파일';


-- 메일정보
CREATE TABLE EML_MAILINFO
(
	EMINO int(10) NOT NULL AUTO_INCREMENT COMMENT '메일정보번호',
	EMIIMAP varchar(30) COMMENT 'IMAP서버주소',
	EMIIMAPPORT varchar(5) COMMENT 'IMAP서버포트',
	EMISMTP varchar(30) COMMENT 'SMTP 서버주소',
	EMISMTPPORT varchar(5) COMMENT 'SMTP 서버포트',
	EMIUSER varchar(50) COMMENT '계정',
	EMIPW varchar(50) COMMENT '비밀번호',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	ENTRYDATE date COMMENT '등록일자',
	DELETEFLAG char(1) COMMENT '삭제',
	PRIMARY KEY (EMINO),
	UNIQUE (EMINO)
) COMMENT = '메일정보';


-- 일정상세
CREATE TABLE SCH_DETAIL
(
	SSNO int(10) NOT NULL COMMENT '일정번호',
	SDSEQ smallint NOT NULL COMMENT '순번',
	SDDATE date COMMENT '날짜',
	SDHOUR char(2) COMMENT '시간',
	SDMINUTE char(2) COMMENT '분',
	PRIMARY KEY (SSNO, SDSEQ),
	UNIQUE (SSNO, SDSEQ)
) COMMENT = '일정상세';


-- 공휴일
CREATE TABLE SCH_HOLIDAY
(
	SHNO smallint NOT NULL AUTO_INCREMENT COMMENT '번호',
	SHTITLE varchar(20) COMMENT '공휴일명',
	SHMONTH smallint COMMENT '월',
	SHDATE smallint COMMENT '일',
	SHCOLOR varchar(10) COMMENT '색상',
	DELETEFLAG char(1) COMMENT '삭제',
	PRIMARY KEY (SHNO),
	UNIQUE (SHNO)
) COMMENT = '공휴일';


-- 일정
CREATE TABLE SCH_SCHEDULE
(
	SSNO int(10) NOT NULL AUTO_INCREMENT COMMENT '일정번호',
	SSTITLE varchar(50) COMMENT '일정명',
	SSTYPE char(1) COMMENT '구분',
	SSSTARTDATE char(10) COMMENT '시작일',
	SSSTARTHOUR char(2) COMMENT '시작일-시간',
	SSSTARTMINUTE char(2) COMMENT '시작일-분',
	SSENDDATE varchar(10) COMMENT '종료일',
	SSENDHOUR char(2) COMMENT '종료일-시간',
	SSENDMINUTE char(2) COMMENT '종료일-분',
	SSREPEATTYPE char(1) COMMENT '반복',
	SSREPEATOPTION varchar(2) COMMENT '반복옵션',
	SSREPEATEND varchar(10) COMMENT '반복종료',
	SSCONTENTS text COMMENT '내용',
	SSISOPEN char(1) COMMENT '공개여부',
	UPDATEDATE datetime COMMENT '수정일자',
	INSERTDATE datetime COMMENT '작성일자',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	DELETEFLAG char(1) COMMENT '삭제',
	PRIMARY KEY (SSNO),
	UNIQUE (SSNO)
) COMMENT = '일정';


-- 결재문서
CREATE TABLE SGN_DOC
(
	DOCNO bigint NOT NULL AUTO_INCREMENT COMMENT '문서번호',
	DOCTITLE varchar(50) COMMENT '제목',
	DOCCONTENTS text COMMENT '문서내용',
	DELETEFLAG char(1) COMMENT '삭제여부',
	DOCSTATUS char(1) COMMENT '문서상태',
	DOCSTEP smallint COMMENT '결재단계',
	DTNO int NOT NULL COMMENT '문서양식번호',
	UPDATEDATE datetime COMMENT '수정일자',
	INSERTDATE datetime COMMENT '작성일자',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	DEPTNM varchar(20) COMMENT '부서명',
	DOCSIGNPATH varchar(200) COMMENT '결재경로문자열',
	PRIMARY KEY (DOCNO),
	UNIQUE (DOCNO)
) COMMENT = '결재문서';


-- 첨부파일
CREATE TABLE SGN_DOCFILE
(
	FILENO int(10) NOT NULL AUTO_INCREMENT COMMENT '파일번호',
	FILENAME varchar(100) COMMENT '파일명',
	REALNAME varchar(30) COMMENT '실제파일명',
	FILESIZE int(10) COMMENT '파일크기',
	DOCNO bigint NOT NULL COMMENT '문서번호',
	PRIMARY KEY (FILENO),
	UNIQUE (FILENO)
) COMMENT = '첨부파일';


-- 문서양식종류
CREATE TABLE SGN_DOCTYPE
(
	DTNO int NOT NULL AUTO_INCREMENT COMMENT '문서양식번호',
	DTTITLE varchar(30) COMMENT '문서양식명',
	DTCONTENTS text COMMENT '문서양식내용',
	DELETEFLAG char(1) COMMENT '삭제',
	PRIMARY KEY (DTNO),
	UNIQUE (DTNO)
) COMMENT = '문서양식종류';


-- 결재경로
CREATE TABLE SGN_PATH
(
	SPNO int NOT NULL AUTO_INCREMENT COMMENT '결재경로번호',
	SPTITLE varchar(30) COMMENT '경로명',
	INSERTDATE date COMMENT '생성일자',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	SPSIGNPATH varchar(200) COMMENT '결재경로문자열',
	PRIMARY KEY (SPNO),
	UNIQUE (SPNO)
) COMMENT = '결재경로';


-- 결재경로상세-결재자
CREATE TABLE SGN_PATHUSER
(
	SPNO int NOT NULL COMMENT '결재경로번호',
	SPUSEQ int NOT NULL COMMENT '경로순번',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	SSTYPE char(1) COMMENT '결재종류',
	PRIMARY KEY (SPNO, SPUSEQ),
	UNIQUE (SPNO)
) COMMENT = '결재경로상세-결재자';


-- 결재
CREATE TABLE SGN_SIGN
(
	SSNO int(10) NOT NULL AUTO_INCREMENT COMMENT '결재번호',
	DOCNO bigint NOT NULL COMMENT '문서번호',
	SSSTEP smallint COMMENT '결재단계',
	SSTYPE char(1) COMMENT '결재종류',
	SSRESULT char(1) COMMENT '결재결과',
	SSCOMMENT varchar(1000) COMMENT '코멘트',
	RECEIVEDATE datetime COMMENT '받은일자',
	SIGNDATE datetime COMMENT '결재일자',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	USERPOS varchar(10) COMMENT '직위',
	PRIMARY KEY (SSNO, DOCNO),
	UNIQUE (SSNO, DOCNO)
) COMMENT = '결재';



CREATE INDEX EML_MAIL_INX01 ON EML_MAIL (EMTYPE ASC, USERNO ASC, EMINO ASC);

-- DROP FUNCTION uf_datetime2string;

DELIMITER $$

CREATE FUNCTION `uf_datetime2string`(dt_ Datetime) RETURNS varchar(10) CHARSET utf8
BEGIN
	DECLARE ti INTEGER ;
	DECLARE ret_ VARCHAR(10);

	SET ti :=  TIMESTAMPDIFF(MINUTE, dt_, NOW());

      IF ti < 1 THEN SET ret_:='방금';
      ELSEIF ti < 60 THEN SET ret_:= CONCAT(TRUNCATE(ti ,0), '분전');
      ELSEIF ti < 60*24 THEN 
            IF ( DATEDIFF(NOW(), dt_)=1) THEN 
                SET ret_:= '어제';
            ELSE
                SET ret_:= CONCAT(TRUNCATE(ti/60 ,0), '시간전');
            END IF;
      ELSEIF ti < 60*24*7 THEN SET ret_:= CONCAT(TRUNCATE(ti/60/24 ,0), '일전');
      ELSEIF ti < 60*24*7*4 THEN SET ret_:= CONCAT(TRUNCATE(ti/60/24/7 ,0), '주전');
      ELSEIF (TIMESTAMPDIFF (MONTH, dt_, NOW())=1) THEN SET ret_:= '지난달';
      ELSEIF (TIMESTAMPDIFF (MONTH, dt_, NOW())<13) THEN 
            IF ( TIMESTAMPDIFF (YEAR, dt_, NOW())=1) THEN 
                SET ret_:= '작년';
            ELSE
                SET ret_:= CONCAT(TRUNCATE(TIMESTAMPDIFF (MONTH, dt_, NOW()) ,0), '달전');
            END IF;
      ELSE SET ret_:= CONCAT(TIMESTAMPDIFF (YEAR, dt_, NOW()), '년전');
      END IF;
      
RETURN ret_;
END;

DELIMITER $$
CREATE PROCEDURE `makeCalendar`()
BEGIN
	DECLARE sdate date DEFAULT '2018-01-01';
	DECLARE edate date DEFAULT '2020-12-31'; 

	WHILE sdate  <= edate DO
		INSERT INTO COM_DATE (CDDATE, CDYEAR, CDMM, CDDD, CDWEEKOFYEAR, CDWEEKOFMONTH, CDWEEK, CDDAYOFWEEK)
			SELECT SDATE, YEAR(SDATE), MONTH(SDATE), day(SDATE),  WEEKOFYEAR(SDATE), FLOOR((DAYOFMONTH(SDATE) - 1) / 7) + 1 , WEEK(SDATE), DAYOFWEEK(SDATE);
			-- SELECT SDATE, YEAR(SDATE), DATE_FORMAT(SDATE, '%m'), DATE_FORMAT(SDATE, '%d'),  WEEKOFYEAR(SDATE), FLOOR((DAYOFMONTH(SDATE) - 1) / 7) + 1 , WEEK(SDATE);
            
		SET sdate = DATE_ADD(sdate, INTERVAL 1 DAY);
	END WHILE;
    
END;
