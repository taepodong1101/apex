select  d.tablespace_name "TABLESPACE",
        sum(d.bytes)/1048576 "SIZE(M)",
        sum(d.bytes)/1048576 - b.FREESPCE "USEDSIZE(M)",
        b.FREESPCE "FREE SPACE(M)",
        100 -(round((FREESPCE/(sum(d.bytes)/1048576))*100)) "USED(%)"
FROM dba_data_files  d,
        (SELECT round(sum(f.bytes)/1048576,2) FREESPCE,
          f.tablespace_name Tablespc
         FROM dba_free_space f
         GROUP BY f.tablespace_name) b
WHERE d.tablespace_name = b.Tablespc
group by d.tablespace_name,b.FREESPCE