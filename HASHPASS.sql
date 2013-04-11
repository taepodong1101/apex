create or replace FUNCTION  "HASHPASS" 
   ( raw_pass IN varchar2 )
   RETURN varchar2
IS
    I NUMBER;
    res VARCHAR2(500);
BEGIN
    res:=raw_pass; -- start by putting raw value into result
 
    FOR I IN 1..95 LOOP -- hash it 95 times to prevent dictionary attacks
        SELECT WWV_FLOW_ITEM.MD5(res) into res FROM DUAL;
    END LOOP;
 
    RETURN res; -- return hash
END;
