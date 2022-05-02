SELECT LOWER(m.email) AS email
     , m.mobile
     , m.names
     , m.addr
     , m.levels
  FROM membertbl m
 ORDER BY m.names DESC;
