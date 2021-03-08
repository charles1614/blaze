-- test cases for bitwise functions

-- null
select bit_count(null);

-- boolean
select bit_count(true);
select bit_count(false);

-- byte/tinyint
select bit_count(cast(1 as tinyint));
select bit_count(cast(2 as tinyint));
select bit_count(cast(3 as tinyint));

-- short/smallint
select bit_count(1S);
select bit_count(2S);
select bit_count(3S);

-- int
select bit_count(1);
select bit_count(2);
select bit_count(3);

-- long/bigint
select bit_count(1L);
select bit_count(2L);
select bit_count(3L);

-- negative num
select bit_count(-1L);

-- edge value
select bit_count(9223372036854775807L);
select bit_count(-9223372036854775808L);

-- other illegal arguments
select bit_count("bit count");
select bit_count('a');

-- test for bit_xor
--
CREATE OR REPLACE TEMPORARY VIEW bitwise_test AS SELECT * FROM VALUES
  (1, 1, 1, 1L),
  (2, 3, 4, null),
  (7, 7, 7, 3L) AS bitwise_test(b1, b2, b3, b4);

-- empty case
SELECT BIT_XOR(b3) AS n1 FROM bitwise_test where 1 = 0;

-- null case
SELECT BIT_XOR(b4) AS n1 FROM bitwise_test where b4 is null;

-- the suffix numbers show the expected answer
SELECT
 BIT_XOR(cast(b1 as tinyint))  AS a4,
 BIT_XOR(cast(b2 as smallint))  AS b5,
 BIT_XOR(b3)  AS c2,
 BIT_XOR(b4)  AS d2,
 BIT_XOR(distinct b4) AS e2
FROM bitwise_test;

-- group by
SELECT bit_xor(b3) FROM bitwise_test GROUP BY b1 & 1;

--having
SELECT b1, bit_xor(b2) FROM bitwise_test GROUP BY b1 HAVING bit_and(b2) < 7;

-- window
SELECT b1, b2, bit_xor(b2) OVER (PARTITION BY b1 ORDER BY b2) FROM bitwise_test;
