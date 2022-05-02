INSERT INTO membertbl
     ( idx
     , names
     , levels
     , addr
     , mobile
     , email
     , userid
     , password
     , lastlogindt
     , loginipaddr)
VALUES 
    ( TEST4_SEQ.NEXTVAL
    , '홍길동'
    , 'A'
    , '부산시 동구 초량동'
    , '010-7989-0909'
    , 'HDG09@NAVER.COM'
    , 'HGD7989'
    , '12345'
    , null
    , null) ;