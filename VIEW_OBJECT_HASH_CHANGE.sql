
select *
from object_hash_table where rawtohex(dbms_crypto.hash(dbms_metadata.get_ddl(object_type,object_name, '<<SCHEMA>>'), 2)) != object_hash;
